//
//  DataPreprocessor.swift
//  BeagleUI
//
//  Created by Eduardo Sanches Bocato on 24/09/19.
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

import Foundation

enum DataPreprocessorError: Error {
    case jsonSerialization(Error)
    case emptyJSON
}

protocol DataPreprocessor {
    
    /// Normalizes the data received to add it to a logic, to be decoded
    ///
    /// - Parameters:
    ///   - data: the data you need to preprocess
    ///   - namespace: the namespace identifier for you entities
    /// - Returns: a normalized data
    /// - Throws: a DataPreprocessorError
    func normalizeData(_ data: Data, for namespaces: [String]) throws -> Data
}

final class DataPreprocessing: DataPreprocessor {
    
    private let typeKey: String = "_beagleType_"
    private let contentKey: String = "content"
    
    func normalizeData(_ data: Data, for namespaces: [String]) throws -> Data {
        
        let lowercasedNamespaces = namespaces.map { $0.lowercased() }
        
        var json: Any?
        do {
            json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch {
            throw DataPreprocessorError.jsonSerialization(error)
        }
        
        let newDataJSON = try transformValueIfNeeded(json, for: lowercasedNamespaces)
        
        return try JSONSerialization.data(withJSONObject: newDataJSON, options: .prettyPrinted)
        
    }
    
    private func transformValueIfNeeded(_ value: Any?, for namespaces: [String]) throws -> Any {
        
        if let jsonArray = value as? [[String: Any]] {

            return try jsonArray.map { try transformValueIfNeeded($0, for: namespaces) }
            
        } else if let dictionary = value as? [String: Any], let type = (dictionary[typeKey] as? String)?.lowercased(), containsNamespace(namespaces, in: type) {
            
            var newValue = [String: Any]()
            var content = [String: Any]()
            try dictionary.forEach {
                if let typeName = ($0.value as? String)?.lowercased(), typeName == type {
                    newValue[$0.key] = $0.value
                } else {
                    content[$0.key] = try transformValueIfNeeded($0.value, for: namespaces)
                }
            }
            newValue[contentKey] = content
            
            return newValue
            
        } else {
            return value ?? ""
        }
    }
    
    private func containsNamespace(_ namespaces: [String], in type: String) -> Bool {
        return namespaces.map { type.contains($0) }.filter { $0 == true }.count > 0
    }
    
}
