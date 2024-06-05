//
//  WelcomePage.swift
//  Camp Tales
//
//  Created by Cannon Goldsby on 5/16/24.
//

import Foundation
import SwiftUI

struct WelcomePage:View {
    var body: some View {
        NavigationStack {
            GeometryReader { geoProx in
                ZStack{
                    
                    VStack{
                        Text("Camp Tales")
                            .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                        Text("Craft stories with provided words")
                            .font(.custom("aptos", size: UIFont.preferredFont(forTextStyle: .title3).pointSize))
                        
                        Spacer()
                        ZStack{
                            Rectangle()
                                .fill(.lightRed)
                                .frame(width: geoProx.size.width/1.5, height:
                                        geoProx.size.width/3.5)
                            Text("GET STARTED")
                                .font(.custom("aptos-Bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                        }
                    }
                    .padding(.leading, 60)
                }
            }
        }
        
    }
}

#Preview {
    WelcomePage()
}
