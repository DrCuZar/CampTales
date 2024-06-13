//
//  DropAreaView.swift
//  Camp Tales
//
//  Created by Cannon Goldsby on 6/6/24.
//

import SwiftUI

struct DropAreaView: View {
    @Binding var storyIntroduction: [Tag]
    @Binding var wordBank: [Tag]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
            
            if storyIntroduction.isEmpty {
                Text("Drag and Arrange")
                    .foregroundColor(.gray)
            } else {
                VStack {
                    ForEach(storyIntroduction) { tag in
                        Text(tag.name)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                            .fixedSize()
                    }
                }
            }
        }
        .onDrop(of: [.text], isTargeted: nil) { providers in
            if let provider = providers.first {
                provider.loadObject(ofClass: String.self) { (string, error) in
                    if let name = string {
                        DispatchQueue.main.async {
                            // Remove the tag from wordBank
                            if let index = self.wordBank.firstIndex(where: { $0.name == name }) {
                                let tag = self.wordBank.remove(at: index)
                                // Add the tag to storyIntroduction
                                self.storyIntroduction.append(tag)
                            }
                        }
                    }
                }
                return true
            }
            return false
        }
    }
}

#Preview {
    DropAreaView(storyIntroduction: .constant([Tag(name: "Sample", size: 100)]), wordBank: .constant([]))
}
