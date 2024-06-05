//
//  PlayerManager.swift
//  Camp Tales
//
//  Created by Cannon Goldsby on 6/2/24.
//

import Foundation

class PlayerManager: ObservableObject {
    // Array to store players
    @Published private(set) var players: [Player] = []
    
    // Initializer to add a default player
    init() {
        addPlayer(name: "Player 1")
    }
    
    // Adds Players
    func addPlayer(name: String) {
        let player = Player(name: name)
        players.append(player)
    }
    
    // Removes Players
    func removePlayer(at index: Int) {
        guard index >= 0 && index < players.count else {
            print("Invalid index")
            return
        }
        players.remove(at: index)
    }
    
    // Gets the players
    func getPlayers() -> [Player] {
        return players
    }

    func getPlayer(at index: Int) -> Player? {
        guard index >= 0 && index < players.count else {
            return nil
        }
        return players[index]
    }
}
