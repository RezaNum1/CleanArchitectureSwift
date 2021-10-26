//
//  TodoWorker.swift
//  TodoListCleanArc
//
//  Created by Reza Harris on 26/10/21.
//

import Foundation
import CloudKit
import Combine

enum CloudKitHelperError: Error {
    case recordFailure
    case recordIDFailure
    case castFailure
    case cursorFailure
}

class TodoWorker
{
    func fetch(recordType: String ,completion: @escaping (Result<Todo, Error>) -> ()) {
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: recordType, predicate: pred)
        query.sortDescriptors = [sort]
        
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = ["text"]
        operation.resultsLimit = 50
        
        operation.recordFetchedBlock = { record in
            DispatchQueue.main.async {
                let id = record.recordID
                guard let text = record["text"] as? String else {
                    completion(.failure(CloudKitHelperError.castFailure))
                    return
                }
                let element = Todo(recordID: id, text: text)
                completion(.success(element))
            }
        }
        
        operation.queryCompletionBlock = { (_, err) in
            DispatchQueue.main.async {
                if let err = err {
                    completion(.failure(err))
                    return
                }
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }
}
