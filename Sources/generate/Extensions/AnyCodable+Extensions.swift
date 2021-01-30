//
//  File.swift
//  
//
//  Created by Mathew Polzin on 1/30/21.
//

import OpenAPIKit
import Foundation

fileprivate let decoder = JSONDecoder()

extension AnyCodable {
    static func json(literal: String) throws -> AnyCodable {
        try decoder.decode(AnyCodable.self, from: literal.data(using: .utf8)!)
    }
}
