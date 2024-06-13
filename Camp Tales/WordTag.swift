//
//  WordTag.swift
//  Camp Tales
//
//  Created by Cannon Goldsby on 6/5/24.
//

import SwiftUI
import SwiftData

struct Tag: Identifiable, Hashable {
    var id = UUID().uuidString
    var name: String
    var size: CGFloat
}

struct WordView: View {
    @Binding var words: [Tag]
    var fontSize: CGFloat = 18
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 15) {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(getRows(for: geo.size.width), id: \.self) { row in
                            HStack(spacing: 4) {
                                ForEach(row) { tag in
                                    Text(tag.name)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                                        .fixedSize().onDrag {
                                            return NSItemProvider(object: tag.name as NSString)
                                        }
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .onChange(of: words) { _ in
                    updateWordSizes()
                }
            }
        }
    
    func getRows(for width: CGFloat) -> [[Tag]] {
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        var currentRowWidth: CGFloat = 0
        
        for word in words {
            let wordWidth = word.size + 5 + 5// Padding + horizontal space
            if currentRowWidth + wordWidth > width {
                rows.append(currentRow)
                currentRow = [word]
                currentRowWidth = wordWidth
            } else {
                currentRow.append(word)
                currentRowWidth += wordWidth + 1 // Spacing
            }
        }
        
        if !currentRow.isEmpty {
            rows.append(currentRow)
        }
        
        return rows
    }
    
    func updateWordSizes() {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        
        for index in words.indices {
            let size = (words[index].name as NSString).size(withAttributes: attributes)
            words[index].size = size.width
        }
    }
}

#Preview {
    StoryView()
}
