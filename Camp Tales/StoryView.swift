//
//  StoryView.swift
//  Camp Tales
//
//  Created by Cannon Goldsby on 6/5/24.
//

import SwiftUI
import Combine

struct StoryView: View {
    var genre: String = "Mystery"
    
    @State private var timerDuration: Int = 120
    @State private var timerRemaining: Int?
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {

                    Text(genre)
                        .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                    Spacer().frame(height: geo.size.height * 0.02)
                    
                    // Word Bank Title
                    Text("Word Bank")
                        .font(.custom("aptos", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                    
                    // Word Bank Box
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.2)
                        .border(Color.black)
                    
                    Spacer().frame(height: geo.size.height * 0.02)
                    
                    // Story Introduction Title
                    Text("Story Introduction")
                        .font(.custom("aptos", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                    
                    // Story Introduction Box
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.2)
                        .overlay(
                            Text("Drag and Arrange")
                                .foregroundColor(.gray)
                        )
                        .border(Color.black)
                    
                    Spacer().frame(height: geo.size.height * 0.02)
                    
                    // Timer Buttons
                    HStack(spacing: geo.size.width * 0.05) {
                        Button(action: {
                            self.timerDuration = 120
                        }) {
                            Text("2:00")
                                .font(.custom("aptos", size: UIFont.preferredFont(forTextStyle: .title3).pointSize))
                                .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.05)
                                .background(self.timerDuration == 120 ? Color.gray : Color.clear)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            self.timerDuration = 240
                        }) {
                            Text("4:00")
                                .font(.custom("aptos", size: UIFont.preferredFont(forTextStyle: .title3).pointSize))
                                .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.05)
                                .background(self.timerDuration == 240 ? Color.gray : Color.clear)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            self.timerDuration = 360
                        }) {
                            Text("6:00")
                                .font(.custom("aptos", size: UIFont.preferredFont(forTextStyle: .title3).pointSize))
                                .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.05)
                                .background(self.timerDuration == 360 ? Color.gray : Color.clear)
                                .cornerRadius(10)
                        }
                    }
                    
                    Spacer().frame(height: geo.size.height * 0.05)
                    
                    // Timer Circle
                    ZStack {
                        Circle()
                            .fill(Color.black)
                            .frame(width: geo.size.width * 0.4, height: geo.size.width * 0.4)
                        
                        Text("BEGIN")
                            .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color.red)
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    StoryView()
}
