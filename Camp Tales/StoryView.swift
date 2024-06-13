import SwiftUI
import SwiftData
import Combine

struct StoryView: View {
    
    var genre: String = "Mystery"
    
    @State private var selectedTimer: String? = nil
    @State private var timeRemaining: Int = 0
    @State private var timerActive: Bool = false
    @State private var timerCancellable: AnyCancellable?
    
    @State private var storyIntroduction: [Tag] = []
    @State private var wordBank: [Tag] = [
        Tag(name: "Mystery", size: 100),
        Tag(name: "Adventure", size: 100),
        Tag(name: "Fantasy", size: 100),
        Tag(name: "Sci-Fi", size: 100)
    ]
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack {
                    // Centering the content within GeometryReader
                    VStack {
                        
                        // Genre Title
                        Text(genre)
                            .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize))
                            .frame(width: geo.size.width * 0.50, height: geo.size.height * 0.03)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(20)
                            .padding(.top, geo.size.height * 0.05)
                        
                        // White background for the middle section
                        VStack {
                            // Word Bank Title
                            Text("Word Bank")
                                .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                            
                            // Word Bank Box
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                                    .fill(Color.white)
                                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.2)
                                    .shadow(color: .black, radius: 1, x: -1, y: 2)
                                
                                WordView(words: $wordBank)
                                    .padding(.bottom)
                                    .padding(.leading)
                                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.2)
                            }
                            
                            // Story Introduction Title
                            Text("Story Introduction")
                                .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                            
                            // Story Introduction Box
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                                .fill(Color.white)
                                .frame(width: geo.size.width * 0.85, height: geo.size.height * 0.075)
                                .shadow(color: .black, radius: 2, x: 0, y: 2)
                                .overlay(
                                    Text("Drag and Arrange")
                                        .foregroundColor(.gray)
                                )
                        }
                        .padding(geo.size.width * 0.05)
                        .background(Color.white)
                        .frame(width: geo.size.width * 0.90)
                        
                        // Timer Buttons
                        TimerButtonView(selectedTimer: $selectedTimer)
                            .frame(height: geo.size.height * 0.8) // Adjust height as needed
                            .padding(.top, geo.size.height * 0.02)
                            .padding(.leading, geo.size.width * 0.0)
                        
                        
                        
                        Spacer(minLength: geo.size.height * 0.01)
                        
                        
                        
                        // Timer Circle
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.7)
                                .overlay(
                                    VStack {
                                        Rectangle()
                                            .frame(width: geo.size.width * 0.15, height: geo.size.height * 0.02)
                                            .padding(.bottom, geo.size.height * 0.29)
                                    })
                                .overlay(
                                    Circle()
                                        .fill(Color.black)
                                        .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5))
                                .overlay(
                                    Rectangle()
                                    
                                        .frame(width: geo.size.width * 0.08, height: geo.size.height * 0.02)
                                        .rotationEffect(.degrees(140))
                                        .padding(.leading, geo.size.width * 0.40)
                                        .padding(.bottom, geo.size.height * 0.15))
                            
                                .overlay(
                                    VStack{
                                        if timerActive {
                                            Text(timeString(from: timeRemaining))
                                                .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                                                .foregroundColor(.black).frame(width: geo.size.width * 0.25, height: geo.size.height * 0.06)
                                                .background(Color.white)
                                                .cornerRadius(20)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color.black, lineWidth: 2)
                                                )
                                            
                                        } else {
                                            Button(action: startTimer) {
                                                Text("BEGIN")
                                                    .font(.custom("aptos-bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                                                    .frame(width: geo.size.width * 0.21, height: geo.size.height * 0.01)
                                                    .foregroundColor(.black)
                                                    .padding()
                                                    .background(Color.white)
                                                    .cornerRadius(10)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color.white, lineWidth: 2)
                                                        
                                                    )
                                            }
                                        }
                                    }
                                )
                        }
                        .padding(.top, geo.size.height * -0.9)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding()
                .background(Color.lightRed)
                .ignoresSafeArea()
            }
        }
    }
    
    func startTimer() {
        guard let selectedTimer = selectedTimer else { return }
        
        switch selectedTimer {
        case "2:00":
            timeRemaining = 120
        case "4:00":
            timeRemaining = 240
        case "6:00":
            timeRemaining = 360
        default:
            return
        }
        
        timerActive = true
        timerCancellable?.cancel()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timerActive = false
                    timerCancellable?.cancel()
                }
            }
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    StoryView()
}
