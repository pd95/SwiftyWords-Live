//
//  LevelsView.swift
//  SwiftyWords
//
//  Created by Philipp on 22.04.23.
//

import SwiftUI

struct LevelsView: View {
    var category: Category

    var body: some View {
        List(0..<category.levels.count, id: \.self) { level in
            NavigationLink(value: level) {
                LevelRow(category: category, level: level)
            }
        }
        .navigationDestination(for: Int.self) { level in
            ContentView(category: category, levelNumber: level)
        }
        .navigationTitle(category.name)
    }

    struct LevelRow: View {
        let category: Category
        let level: Int

        @AppStorage private var completion: Double?

        init(category: Category, level: Int) {
            self.category = category
            self.level = level
            let key = UserDefaults.completionDateKey(for: category, level: level)
            self._completion = AppStorage(key)
        }

        var body: some View {
            HStack {
                Text("Level \(level + 1)")
                Spacer()
                if let completion {
                    Text("✅ \(Date(timeIntervalSinceReferenceDate: completion).formatted(.dateTime))")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct LevelsView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsView(category: .example)
    }
}
