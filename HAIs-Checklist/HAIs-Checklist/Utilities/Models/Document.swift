//
//  Document.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation

class Document<T: Codable> {
    let documentId: String
    var data: T
    
    init(documentId: String,
         data: T) {
        self.documentId = documentId
        self.data = data
    }
}

extension Document: Identifiable {}

extension Document: Hashable {
    static func == (lhs: Document, rhs: Document) -> Bool {
        lhs.documentId == rhs.documentId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(documentId)
    }
}

extension Document: ObservableObject {}
