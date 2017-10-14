//
//  LocalJsonDataManager.swift
//  QuinTypeInsta
//
//  Created by Yogesh S on 2017-10-13.
//  Copyright © 2017 Yogesh S. All rights reserved.
//

import Foundation

class NetworkManager {
    class func getJsonDictionaryFromFile(fileName: String) -> [String: Any] {
        if let url = Bundle.main.url(forResource: "usersWithStories", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                    return json!
                } catch {
                    print("Error")
                }
            } catch {
                return [:]

            }
        }
         return [:]
    }
}
