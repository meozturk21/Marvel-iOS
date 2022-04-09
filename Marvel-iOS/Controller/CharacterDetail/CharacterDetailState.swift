//
//  CharacterDetailState.swift
//  Marvel-iOS
//
//  Created by Mehmet Emin on 9.04.2022.
//

import Foundation
enum CharacterDetailState: Equatable {
    
    case error(_ error: Error)
    
    static func == (lhs: CharacterDetailState, rhs: CharacterDetailState) -> Bool {
        switch (lhs, rhs) {
        case (.error, .error):
            return true
        }
    }
}

