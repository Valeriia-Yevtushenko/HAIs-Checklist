//
//  FirestoreService.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 19.02.2023.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

class FirestoreChecklistService {
    private let database = Firestore.firestore()
    private let collection = "checklists"
}

extension FirestoreChecklistService: ChecklistServiceProtocol {
    typealias ChecklistModel = Document<Checklist>
    
    func get() async throws -> [ChecklistModel] {
        let querySnapshot = try await database.collection(collection)
            .getDocuments()
        
        let checklists: [ChecklistModel] = querySnapshot.documents.compactMap {
            let data = $0.data()
            
            guard let documetData = Checklist(from: data) else {
                return nil
            }
            
            return ChecklistModel(documentId: $0.documentID, data: documetData)
        }
        return checklists
    }
    
    func get(by type: String) async throws -> [ChecklistModel] {
        let querySnapshot = try await database.collection(collection)
            .whereField("type", isEqualTo: type)
            .getDocuments()
        
        let checklists: [ChecklistModel] = querySnapshot.documents.compactMap {
            let data = $0.data()
            
            guard let documetData = Checklist(from: data) else {
                return nil
            }
            
            return ChecklistModel(documentId: $0.documentID, data: documetData)
        }
        return checklists
    }
}
