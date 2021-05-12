//
//  RequestDbService.swift
//  BitPrice
//
//  Created by Bruno Tortato Furtado on 27/01/18.
//  Copyright © 2018 Bruno Tortato Furtado. All rights reserved.
//

import CoreData
import Foundation

public class RequestDbService {

    // MARK: - Public

    public init() {}

    public func insert(reference: ReferenceType?, data: Data, date: Date) {
        delete(reference: reference)

        let stack = CoreDataStack.shared
        let context = stack.context
        _ = RequestEntity(reference: reference?.rawValue, data: data, date: date)

        do {
            try context.save()
            stack.saveContext()
        } catch let error {
            debugPrint("error: \(error)")
        }
    }

    public func fetch(reference: ReferenceType?) -> RequestEntity? {
        let context = CoreDataStack.shared.context
        var request: RequestEntity?

        let fetchRequest: NSFetchRequest<RequestEntity> = RequestEntity.fetchRequest()
        fetchRequest.fetchLimit = 1

        if let reference = reference {
            fetchRequest.predicate = NSPredicate(format: "reference = %@", reference.rawValue)
        } else {
            fetchRequest.predicate = NSPredicate(format: "reference = nil")
        }

        do {
            request = try context.fetch(fetchRequest).first as RequestEntity?
        } catch let error {
            debugPrint("error: \(error)")
        }

        return request
    }

    public func fetch() -> [RequestEntity]? {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<RequestEntity> = RequestEntity.fetchRequest()
        var requests: [RequestEntity]?

        do {
            requests = try context.fetch(fetchRequest) as [RequestEntity]?
        } catch let error {
            debugPrint("error: \(error)")
        }

        return requests
    }

    public func delete(reference: ReferenceType?) {
        let stack = CoreDataStack.shared
        let context = stack.context
        let request = fetch(reference: reference)

        if let request = request {
            context.delete(request)
            stack.saveContext()
        }
    }

    public func delete() {
        let stack = CoreDataStack.shared
        let context = stack.context
        let requests = fetch()

        if let requests = requests {
            for request in requests {
                context.delete(request)
            }
            stack.saveContext()
        }
    }

}
