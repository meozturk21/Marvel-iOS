//
//  MediaComponentViewModel.swift
//  Marvel-iOS
//
//  Created by Mehmet Emin on 9.04.2022.
//

import Foundation

// MARK: - Protocol
protocol MediaComponentProtocol {
    var input: MediaComponentViewModel.Input {get}
    var output: MediaComponentViewModel.Output? {get}
}
// MARK: - I/O
extension MediaComponentViewModel {
    struct Input {
        let media: Any
    }
    struct Output {
        let imageUrl: URL?
        let title: String?
    }
}

// MARK: - Class
class MediaComponentViewModel: MediaComponentProtocol {
    
    /// Protocol variables I/O
    var input: Input
    var output: Output?
    
    init(media: Any) {
        
        self.input = Input.init(media: media)
        
        if let comic = media as? Comic {
            self.output = Output.init(
                imageUrl: comic.thumbnail?.getImageUrl(),
                title: comic.title ?? ""
            )
        }
    }
}
