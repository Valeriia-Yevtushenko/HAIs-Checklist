//
//  FirestoreService.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

class FirestoreDatabaseService {
    private let database = Firestore.firestore()
}

extension FirestoreDatabaseService: DatabaseServiceProtocol {
    func get<T: DatabaseModel>(from collection: String) async throws -> [Document<T>] {
        let querySnapshot = try await database.collection(collection)
            .getDocuments()
        
        let checklists: [Document<T>] = querySnapshot.documents.compactMap {
            var data = $0.data()
            
            if let date = data["date"] as? Timestamp {
                data["date"] = date.dateValue()
            }
            
            guard let documetData = T(from: data) else {
                return nil
            }
            
            return Document<T>(documentId: $0.documentID, data: documetData)
        }
        
        return checklists
    }
    
    func create(to collection: String, document: DatabaseModel) async throws {
        let documentId = UUID().uuidString
        try await database.collection(collection).document(documentId).setData(document.dict)
    }
}
