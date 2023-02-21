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
    private let collection = "checklists"
}

extension FirestoreDatabaseService: DatabaseServiceProtocol {
    typealias ChecklistModel = Document<Checklist>
    
    func get<T: DatabaseModel>() async throws -> [Document<T>] {
        let querySnapshot = try await database.collection(collection)
            .getDocuments()
        
        let checklists: [Document<T>] = querySnapshot.documents.compactMap {
            let data = $0.data()
            
            guard let documetData = T(from: data) else {
                return nil
            }
            
            return Document<T>(documentId: $0.documentID, data: documetData)
        }
        return checklists
    }
}
