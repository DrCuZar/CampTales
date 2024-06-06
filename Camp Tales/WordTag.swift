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
    var fontSize: CGFloat = 16
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading, spacing: 15) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(getRows(for: geo.size.width), id: \.self) { row in
                            WordRowView(row: row)
                        }
                    }
                    .padding(.vertical)
                }
                .onChange(of: words) {
                    updateWordSizes()
                }
            }
        }
    }
    
    func getRows(for width: CGFloat) -> [[Tag]] {
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        var currentRowWidth: CGFloat = 0
        
        for word in words {
            let wordWidth = word.size + 20 + 20
            if currentRowWidth + wordWidth > width {
                rows.append(currentRow)
                currentRow = [word]
                currentRowWidth = wordWidth
            } else {
                currentRow.append(word)
                currentRowWidth += wordWidth + 5
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

struct WordRowView: View {
    var row: [Tag]
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(row) { tag in
                WordTextView(tag: tag)
            }
        }
    }
}

struct WordTextView: View {
    var tag: Tag
    
    var body: some View {
        Text(tag.name)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(RoundedRectangle(cornerRadius: 5).fill(Color.white))
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
            .fixedSize()
    }
}

#Preview {
    WordView(words: .constant([Tag(name: "Sample", size: 100)]))
}
