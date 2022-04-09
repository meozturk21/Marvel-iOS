//
//  CharacterComponentViewModel.swift
//  Marvel-iOS
//
//  Created by Mehmet Emin on 9.04.2022.
//

import Foundation

// MARK: - Protocol
protocol CharacterComponentProtocol {
    var input: CharacterComponentViewModel.Input { get }
    var output: CharacterComponentViewModel.Output { get }
}

// MARK: - I/O
extension CharacterComponentViewModel {
    struct Input {
        let character: Character
    }
    
    struct Output {
        let imageUrl: URL?
        let name: String?
        let description: String?
    }
}

// MARK: - CharacterComponentViewModel
class CharacterComponentViewModel: CharacterComponentProtocol {
    
    /// Protocol
    var input: Input
    var output: Output
    
    init(character: Character) {
        self.input = Input.init(
            character: character
        )
        self.output = Output.init(
            imageUrl: character.thumbnail?.getImageUrl(),
            name: character.name,
            description: character.desc
        )
    }
}
