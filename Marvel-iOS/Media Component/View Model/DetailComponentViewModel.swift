//
//  DetailComponentViewModel.swift
//  Marvel-iOS
//
//  Created by Mehmet Emin on 9.04.2022.
//

import Foundation

// MARK: - Protocol
protocol DetailComponentProtocol {
    var input: DetailComponentViewModel.Input {get}
    var output: DetailComponentViewModel.Output {get}
}
// MARK: - I/O
extension DetailComponentViewModel {
    struct Input {
        let component: CharacterComponentProtocol
    }
    struct Output {
        let imageUrl: URL?
        let name: String?
        let description: String?
    }
}

// MARK: - Class
class DetailComponentViewModel: DetailComponentProtocol {
    
    /// Protocol variables I/O
    var input: Input
    var output: Output
    
    init(component: CharacterComponentProtocol) {
        self.input = Input.init(component: component)
        self.output = Output.init(
            imageUrl: component.output.imageUrl,
            name: component.output.name,
            description: component.output.description
        )
    }
}

