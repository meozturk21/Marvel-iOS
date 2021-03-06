//
//  MarvelRepository.swift
//  Marvel-iOS
//
//  Created by Mehmet Emin on 6.04.2022.
//

import Foundation
import RxSwift
import Realm
import RealmSwift

protocol MarvelRepositoryProtocol {
    var apiClient: APIClientProtocol { get }
    var databaseClient: DatabaseProtocol { get }
    
    /// Characters
    func fetchCharacters(paginator: MarvelPager) -> Observable<[Character]?>
    
    /// Media
    func fetchComics(characterId: Int) -> Observable<[Comic]>

}

struct MarvelPager {
    var offset: Int
    let limit: Int
    var isFirstPage: Bool {
        return offset == 0
    }
    
    mutating func nextPage() {
        self.offset = self.offset + limit
    }
}

class MarvelRepository: MarvelRepositoryProtocol {
    

    /// Public
    var apiClient: APIClientProtocol
    var databaseClient: DatabaseProtocol
    
    /// Private
    private let appSchedulers: AppSchedulers
    private let disposeBag: DisposeBag
    
    
    init(apiClient: APIClientProtocol = APIClient(),
         databaseClient: DatabaseProtocol = Database(),
         appSchedulers: AppSchedulers) {
        
        self.apiClient = apiClient
        self.databaseClient = databaseClient
        self.appSchedulers = appSchedulers
        self.disposeBag = DisposeBag()
    }
    
    // MARK: - Characters
    
    func fetchCharacters<T: Codable & Object>(paginator: MarvelPager) -> Observable<[T]?> {
        let request = CharactersRequest.init(
            offset: paginator.offset,
            limit: paginator.limit
        )
        
        let observeResponse: Observable<CharactersListResponse> =
            fetchNetworkRequest(request: request)
        let fetchRequest = observeResponse
            .flatMap { response -> Observable<[T]?> in
                if let result = response.data?.results?
                    .compactMap({$0}) as? [T] {
                    return .just(result)
                }
                return .just(nil)
            }
        
        /// Try to load DB - Network
        if paginator.isFirstPage {
            return Observable<[T]?>.concat(
                fetchLocal(type: T.self),
                fetchRequest
                    .observe(on: appSchedulers.main)
                    .flatMap { result -> Observable<[T]?> in
                        self.saveObjects(objects: result)
                        return .just(result)
                }
            )
        } else {
            /// Load next page
            return fetchRequest
        }
        
    }
    
    // MARK: - Comics
    
    func fetchComics<T: Codable & Object>(characterId: Int) -> Observable<[T]> {
        let request = ComicsRequest.init(characterId: characterId)
        
        let observeResponse: Observable<ComicsListResponse> =
            fetchNetworkRequest(request: request)
        return observeResponse
            .flatMap { response -> Observable<[T]> in
                if let result = response.data?.results?
                    .compactMap({$0}) as? [T] {
                    return .just(result)
                }
                return .just([])
        }
    }
}

// MARK: - Local Access

extension MarvelRepository {
    
    func fetchLocal<T: Codable & Object>(type: T.Type) -> Observable<[T]?> {
        return self.databaseClient.get(type: type)
    }
    
    func saveObjects<T: Codable & Object>(objects: [T]?) {
        self.databaseClient.save(objects: objects)
    }
    
    func subscribeDatabaseChanges<T: Codable & Object>(type: T.Type) -> Observable<[T]> {
        return self.databaseClient.observe(type: type)
    }
}

// MARK: - Network Access

extension MarvelRepository {
    
    func fetchNetworkRequest<T: Codable>(request: APIRequest) -> Observable<T> {
        
        return self.apiClient
            .send(apiRequest: request)
            .retry(3)
            .flatMap { response -> Observable<T> in
                .just(response)
            }
    }
}
