//
//  PlayerCard.swift
//  Camp Tales
//
//

import SwiftUI

struct PlayerCard: View {
    let player: Player
    let index: Int
    
    var body: some View {
           GeometryReader { geometry in
               HStack {
                   Circle()
                       .fill(Color.gray)
                       .frame(width: geometry.size.width * 0.12, height: geometry.size.width * 0.12)
                   
                   Text("Player \(index + 1)")
                       .font(.custom("aptos", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                       .foregroundColor(.black)
                   
                   Spacer()
               }
               .padding()
               .background(Color.newGray)
               .cornerRadius(10)
               .frame(height: geometry.size.height * 1.10)
           }
       }
}

#Preview {
    PlayerCard(player: Player(name: "Player 1"), index: 0)
}
