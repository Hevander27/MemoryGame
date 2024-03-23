//
//  ContentView.swift
//  MemoryGame
//
//  Created by Admin on 3/21/24.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var selectedSize: Int = 6
    @State private var isChoosingSize = false
    @State private var selectedCards: [Card] = []
    
    private let sizes = [6, 12, 18]
    private let emojis: [String] = ["😀", "😎", "😂", "😍", "🥳", "😊", "😜", "🤩", "😇", "🤔", "😉", "😘", "🤣", "😋", "😁", "🤗", "😆", "🤓"]
    private let columns: [GridItem] = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
    
    var items: [String] {
        let allItems = (0..<selectedSize).map { emojis[$0 % emojis.count] }
        let shuffledItems = allItems.shuffled()
        return Array(shuffledItems.prefix(selectedSize))
    }
    
    var body: some View {
        VStack {
            HStack {
                Menu {
                    ForEach(sizes, id: \.self) { size in
                        Button(action: {
                            selectedSize = size
                        }) {
                            Text("\(size)")
                        }
                    }
                } label: {
                    Text("Choose Size")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(24)
                }
                
                Spacer()
                
                Button(action: {
                    resetGame()
                }) {
                    Text("Reset Game")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(24)
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            if isChoosingSize {
                Picker("Select Size", selection: $selectedSize) {
                    ForEach(sizes, id: \.self) { size in
                        Text("\(size)")
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
            }
            
            ScrollView {
                LazyVGrid(
                    columns: columns,
                    spacing: 32
                ) {
                    Section {
                        ForEach(items, id: \.self) { item in
                            CardView(card: Card(content: item))
                                .frame(width: 100, height: 150) // Adjust as needed
                        }
                    }
                }
            }
        }
    }
    
    private func resetGame() {
        // Reset the game state
        selectedCards = []
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
