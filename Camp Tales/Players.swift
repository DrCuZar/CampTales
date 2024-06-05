//
//  Players.swift
//  Camp Tales
//
//  Created by Cannon Goldsby on 6/1/24.
//

import SwiftUI

struct Players: View {
    
    @StateObject private var playerManager = PlayerManager()
    @State private var shakeAdd = false
    @State private var shakeDel = false
    
    var body: some View {
        GeometryReader{ geo in
            VStack {
                HStack{
                    Text("WHO'S PLAYING?")
                        .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                        .padding(.leading)
                    Spacer()
                    Button(action: addPlayer) {
                        ZStack{
                            Rectangle()
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                                .foregroundColor(.green)
                                .border(Color.black, width: 3)
                                .offset(x: shakeAdd ? -10 : 0)
                                .animation(shakeAdd ? Animation.default.repeatCount(3).speed(3) : .default)
                            
                            Image(systemName: "plus")
                                .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                                .foregroundColor(.black)
                                .offset(x: shakeAdd ? -10 : 0)
                                .animation(shakeAdd ? Animation.default.repeatCount(3).speed(3) : .default)
                            
                        }
                    }
                    Button(action: deletePlayer) {
                        ZStack {
                            Rectangle()
                                .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.05)
                                .foregroundColor(.lightRed)
                                .border(Color.black, width: 2)
                                .offset(x: shakeDel ? +10 : 0)
                                .animation(shakeDel ? Animation.default.repeatCount(3).speed(3) : .default)
                            
                            Image(systemName: "xmark")
                                .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                                .foregroundColor(.black)
                                .offset(x: shakeDel ? +10 : 0)
                                .animation(shakeDel ? Animation.default.repeatCount(3).speed(3) : .default)
                        }
                    }
                    .padding(.trailing)
                }
                LazyVStack(spacing: geo.size.height * 0.01){
                    ForEach(playerManager.players.indices, id: \.self) { index in
                        PlayerCard(player: playerManager.players[index], index: index)
                            .frame(height: geo.size.height * 0.08)
                            .shadow(radius: 1)
                            .padding()
                    }
                }
                
                
            }
        }
    }
    
    private func addPlayer() {
        if playerManager.getPlayers().count < 6 {
            let playerName = "Player \(playerManager.getPlayers().count + 1)"
            playerManager.addPlayer(name: playerName)
            shakeAdd = false
        } else {
            shakeAddPlayerButton()
        }
    }
    
    private func deletePlayer() {
        if playerManager.getPlayers().count > 1 {
            playerManager.removePlayer(at: playerManager.getPlayers().count - 1)
            shakeDel = false
        } else {
            shakeDeletePlayerButton()
        }
    }
    
    private func shakeAddPlayerButton() {
        shakeAdd = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            shakeAdd = false
        }
    }
    
    private func shakeDeletePlayerButton() {
        shakeDel = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            shakeDel = false
        }
    }
    
}

#Preview {
    Players()
}
