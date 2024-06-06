//
//  TagView.swift
//  Camp Tales
//
//  Created by Cannon Goldsby on 6/1/24.
//

import SwiftUI
import SwiftData

struct TagView: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Text(text)
            .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .title3).pointSize))
            .padding()
            .background(isSelected ? Color.lightRed : Color.white)
            .foregroundColor(isSelected ? Color.white : Color.black)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black, lineWidth: 1)
            )
            .shadow(color: .black, radius: 2, x: 0, y: 2)
            .onTapGesture {
                action()
            }
    }
}

#Preview {
    TagView(text: "ADVENTURE", isSelected: true, action: {})
}
