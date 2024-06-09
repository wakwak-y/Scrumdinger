//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by Yu Wakui on 2024/06/09.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String
    
    init(id: UUID = UUID(), error: Error, guidance: String) {
        self.id = id
        self.error = error
        self.guidance = guidance
    }
}


