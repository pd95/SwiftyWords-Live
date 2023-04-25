//
//  ContentView.swift
//  SwiftyWords
//
//  Created by Philipp on 22.04.23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) private var dismiss
    var category: Category
    var levelNumber: Int

    @StateObject private var model: LevelViewModel
    @State private var showCongratulationAlert = false

    init(category: Category, levelNumber: Int) {
        self.category = category
        self.levelNumber = levelNumber

        _model = StateObject(wrappedValue: {
            LevelViewModel(words: category.levels[levelNumber])
        }())
    }

    var body: some View {
        VStack {
            VStack {
                ForEach(model.answers) { answer in
                    HStack {
                        if answer.isSolved {
                            Text(answer.word.solution)
                        } else {
                            Text(answer.word.hint)
                            Spacer()
                            Image(systemName: answer.imageName)
                        }
                    }
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold(answer.isSolved)

                    Spacer()
                }
            }

            Text(model.currentAnswer)
                .font(.title)
                .lineLimit(1)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.quaternary)
                .cornerRadius(5)
                .overlay(alignment: .trailing) {
                    Button(action: model.delete) {
                        Label("Delete", systemImage: "delete.left")
                            .font(.title)
                            .labelStyle(.iconOnly)
                    }
                    .buttonStyle(.plain)
                    .offset(x: -10)
                }

            Spacer()

            LazyVGrid(columns: Array<GridItem>(repeating: .init(.flexible()), count: 4)) {
                ForEach(0..<model.segments.count, id: \.self) { index in
                    let segment = model.segments[index]

                    Button {
                        model.select(index)
                    } label: {
                        SegmentView(segment: segment)
                    }
                    .buttonStyle(.plain)
                    .disabled(segment.isUsed)
                    .disabled(model.selectedSegments.count == 7)
                }
            }
        }
        .onChange(of: model.isCompleted, perform: { isCompleted in
            if isCompleted {
                showCongratulationAlert = true
                UserDefaults.standard.setCompletionDate(for: category, level: levelNumber)
            }
        })
        .alert("🎉 Well done! 🎉", isPresented: $showCongratulationAlert, actions: {
            Button("Continue") {
                dismiss()
            }
        }, message: {
            Text("You have successfully completed level \(levelNumber+1).")
        })
        .padding()
        .navigationTitle("Level \(levelNumber + 1)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(category: .example, levelNumber: 0)
    }
}
