//
//  SplashScreen.swift
//  Camp Tales
//
//  Created by Cannon Goldsby on 5/30/24.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var screen: Bool = false
    
    var body: some View {
        ZStack{
            if screen{
                WelcomePage()
            } else{
                Rectangle()
                    .foregroundColor(.black)
                    .ignoresSafeArea()
                Image("FlameSC")
                    .resizable()
                    .scaledToFit()
            }
        }
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.screen = true
                }
            }
        }
    }
}
    
#Preview {
    SplashScreen()
}
