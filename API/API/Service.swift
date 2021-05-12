//
//  Service.swift
//  BitPrice
//
//  Created by Bruno Tortato Furtado on 02/02/18.
//  Copyright © 2018 Bruno Tortato Furtado. All rights reserved.
//

import Foundation

open class Service<T: Decodable> {

    // MARK: - Variables

    private let dbService = RequestDbService()

    // MARK: - Public

    public init() {}

    public func jsonDecode(data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }

    public func dbFetch(reference: ReferenceType, cachedDays days: Int? = nil) -> T? {
        guard let request = dbService.fetch(reference: reference) else { return nil }

        guard let days = days else {
            return jsonDecode(data: request.data)
        }

        if Date().days(from: request.date) <= days {
            return jsonDecode(data: request.data)
        }

        return nil
    }

    public func dbInsert(reference: ReferenceType? = nil, data: Data, date: Date = Date()) {
        dbService.insert(reference: reference, data: data, date: date)
    }

}

public enum ServiceFailureType {
    case connection
    case server
}
