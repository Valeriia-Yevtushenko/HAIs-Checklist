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
            let data = $0.data()
            
            guard let documetData = T(from: data) else {
                return nil
            }
            
            return Document<T>(documentId: $0.documentID, data: documetData)
        }
        return checklists
    }
    
    func create(to collection: String, document: DatabaseModel) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            let documentId = UUID().uuidString
            do {
                try database.collection(collection).document(documentId).setData(from: document, completion: { error in
                    guard let error = error else {
                        continuation.resume()
                        return
                    }
                    
                    continuation.resume(throwing: error)
                })
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}
