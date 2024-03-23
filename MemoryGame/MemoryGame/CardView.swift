//
//  CardView.swift
//  MemoryGame
//
//  Created by Admin on 3/21/24.
//

import Foundation
import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var isFaceUp = false
    var isMatched = false
    var content: String
}

import SwiftUI

struct CardView: View {
    @State private var isFaceUp = false
    @State private var isSelected = false
    var card: Card
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
        .onTapGesture {
            if !isSelected {
                isSelected = true
                isFaceUp = true
            }
        }
        .onChange(of: isSelected) { _ in
            if isSelected {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isSelected = false
                    isFaceUp = false
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(content: "🚗"))
            .previewLayout(.fixed(width: 100, height: 150))
    }
}


