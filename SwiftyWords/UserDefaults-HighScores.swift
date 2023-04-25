//
//  UserDefaults-HighScores.swift
//  SwiftyWords
//
//  Created by Philipp on 25.04.23.
//

import Foundation

extension UserDefaults {

    static func completionDateKey(for category: Category, level: Int) -> String {
        "completed_\(category.id)_\(level)"
    }

    func setCompletionDate(for category: Category, level: Int) {
        let key = Self.completionDateKey(for: category, level: level)
        guard double(forKey: key) == 0 else { return }

        setValue(Date.now.timeIntervalSinceReferenceDate, forKey: key)
    }
}
