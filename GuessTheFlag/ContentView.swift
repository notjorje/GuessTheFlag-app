//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Lupu George on 11.04.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var scoreCounter = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.75, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            
            .ignoresSafeArea()
        
            VStack {
                Text("Guess the flag")
                    .foregroundColor(.white)
                    .padding()
                    .font(.largeTitle.bold())
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap the flag of ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        }  label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                if scoreCounter > 0 {
                    Text("Your score is \(scoreCounter).")
                        .foregroundColor(.white)
                        .font(.title.bold())
                } else {
                    Text("Your score is 0.")
                        .foregroundColor(.white)
                        .font(.title.bold())
                }
            }
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } /*message : {
                Text("Your score is \(scoreCounter)")
            }*/
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct."
            scoreCounter += 1
        } else {
            scoreTitle = "Wrong."
        }
        
        if scoreCounter > 9 {
            scoreCounter = 0
            scoreTitle = "You're pretty good at this, we will restart game."
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
