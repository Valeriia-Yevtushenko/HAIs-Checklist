//
//  RevisionServiceProtocol.swift
//  HAIs-Checklist
//
//  Created by Valeriia Yevtushenko on 21.02.2023.
//

import Foundation

protocol RevisionServiceProtocol: AnyObject {
    func getCurrentRevision() -> Revision? 
    func startRevision(departament: String) async throws
    func getUncompletedChecklists() -> [Document<Checklist>]
    func addCompletedChecklist(_ checklist: CompletedChecklist)
    func getRevisionResult() -> RevisionResult
    func saveRevision() async throws
}
