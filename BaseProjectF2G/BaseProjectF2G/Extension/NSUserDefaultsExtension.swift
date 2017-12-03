//
//  NSUserDefaultsExtension.swift
//  LaleTore
//
//  Created by Quan Nguyen on 10/13/16.
//  Copyright © 2016 Paditech. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func setString(_ string: String, forKey: String) {
        set(string, forKey: forKey)
    }
    
    func setDate(_ date: Date, forKey: String) {
        set(date, forKey: forKey)
    }
    
    func dateForKey(_ string: String) -> Date? {
        return object(forKey: string) as? Date
    }
}
extension Sequence {
    func group<GroupingType: Hashable>(by key: (Iterator.Element) -> GroupingType) -> [[Iterator.Element]] {
        var groups: [GroupingType: [Iterator.Element]] = [:]
        var groupsOrder: [GroupingType] = []
        forEach { element in
            let key = key(element)
            if case nil = groups[key]?.append(element) {
                groups[key] = [element]
                groupsOrder.append(key)
            }
        }
        return groupsOrder.map { groups[$0]! }
    }
}
