//
//  TimerButton.swift
//  Camp Tales
//
//  Created by Cannon Goldsby on 6/12/24.
//

import SwiftUI

import SwiftUI

struct TimerButtonView: View {
    @Binding var selectedTimer: String?
    let timerOptions = ["2:00", "4:00", "6:00"]

    var body: some View {
        GeometryReader { geo in
            HStack(spacing: geo.size.width * 0.15) {
                ForEach(timerOptions, id: \.self) { timer in
                    Button(action: {
                        selectedTimer = timer
                    }) {
                        Text(timer)
                            .font(.custom("aptos", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                            .frame(width: geo.size.width * 0.22, height: geo.size.height * 0.05)
                            .background(selectedTimer == timer ? Color.lightRed : Color.white)
                            .foregroundColor(selectedTimer == timer ? .white : .black)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: selectedTimer == timer ? 3 : 1)
                            )
                    }
                }
            }
        }
    }
}

#Preview {
    TimerButtonView(selectedTimer: .constant("2:00"))
}
