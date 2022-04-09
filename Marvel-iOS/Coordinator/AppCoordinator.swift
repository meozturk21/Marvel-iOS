//
//  AppCoordinator.swift
//  Marvel-iOS
//
//  Created by Mehmet Emin on 9.04.2022.
//

import Foundation
import RxSwift

class AppCoordinator: BaseCoordinator {

    let window: UIWindow?
    let disposeBag: DisposeBag

    init(window: UIWindow?) {
        self.window = window
        self.disposeBag = DisposeBag()
        super.init()
    }

    override func start() -> Observable<Void> {

        let navigationController = UINavigationController()

        let router = Router(navigationController: navigationController)
        let schedulers = MarvelAppSchedulers()
        let repository = MarvelRepository.init(appSchedulers: schedulers)
        
        let coordinator = CharactersListCoordinator(
            router: router,
            repository: repository,
            schedulers: schedulers
        )

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return self.coordinate(coordinator)
    }
}
