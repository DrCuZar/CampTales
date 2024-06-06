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
        VStack {
            if storyIntroduction.isEmpty {
                Text("Drag and Arrange")
                    .foregroundColor(.gray)
            } else {
                ForEach(storyIntroduction) { tag in
                    Text(tag.name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black))
                        .onDrag { NSItemProvider(object: tag.name as NSString) }
                        .onDrop(of: [.text], isTargeted: nil) { providers in
                            if let provider = providers.first {
                                provider.loadObject(ofClass: String.self) { (string, error) in
                                    if let name = string {
                                        DispatchQueue.main.async {
                                            self.storyIntroduction.removeAll { $0.name == name }
                                            self.wordBank.append(Tag(name: name, size: 100))
                                        }
                                    }
                                }
                                return true
                            }
                            return false
                        }
                }
            }
        }
    }
}

//#Preview {
//    DropAreaView(storyIntroduction: .constant([Tag(name: "Sample", size: 100)]), wordBank: .constant([]))
//}
