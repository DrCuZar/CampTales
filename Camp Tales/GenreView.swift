//
//  GenreView.swift
//  Camp Tales
//
//  Created by Cannon Goldsby on 6/1/24.
//

import SwiftUI

struct GenreView: View {
    @State private var selectedTag: String? = "ADVENTURE"
    
    let tags = [
        "ADVENTURE", "FANTASY", "SPACE", "MYSTERY", "SCI-FI", "HORROR",
        "DARK FANTASY", "DYSTOPIAN", "RELATIONSHIPS", "GUIDANCE", "CHILDREN",
        "FOLK TALE", "CULINARY", "ROMANCE", "MYTHOLOGY", "THRILLER", "HISTORIC"
    ]
    
    var body: some View {
        VStack {
            Text("Choose your story elements")
                .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                .padding(.bottom)
            
            GeometryReader { geometry in
                
                let columns = [GridItem(.adaptive(minimum: geometry.size.width / 3 - 20))]
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(tags, id: \.self) { tag in
                        TagView(
                            text: tag,
                            isSelected: selectedTag == tag,
                            action: {
                                selectedTag = tag
                            }
                        )
                    }
                }
                .padding()
            }
            
            Spacer()
            
            Button(action: {
            }) {
                Text("START")
                    .font(.custom("atpos-bold", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.lightRed)
                    .foregroundColor(.white)
                    .cornerRadius(5)

            }
            .padding()
        }
    }
}

#Preview {
    GenreView()
}
