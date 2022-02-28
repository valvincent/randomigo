//
//  ContentView.swift
//  Randomigo
//
//  Created by Val Vincent on 2/26/22.
//

import SwiftUI

//MARK: Main view
struct ContentView: View {

    // Arrays for actions:
    // 0 for draw a card
    // 1 for flip a coin
    // 2 for roll a dice
    @State private var outputScreens = [false, false, false]
    private var choices = ["🃏","🪙","🎲"]
    
    var body: some View {
        NavigationView {
            ZStack{
                Color("mainColor").ignoresSafeArea()
                VStack (spacing: 15){
                    Spacer()
                    Spacer()
                    Text("Your amigo for randomness.")
                        .font(.title.bold())
                    Spacer()
                    Text("Draw a random card, flip a coin, or roll a dice.")
                        .font(.title)
                        .padding(20)
                    HStack (spacing: 25){
                        ForEach(0..<3) { choice in
                            Button {
                                outputScreens = [false, false, false]
                                outputScreens[choice] = true
                            } label: {
                                Text(choices[choice])
                                    .font(.system(size: 90))
                                    .background(.thinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                        }
                    }
                    Spacer()
                }
                .sheet(isPresented: $outputScreens[0]) {
                    DrawnCard()
                }
                .sheet(isPresented: $outputScreens[1]) {
                    FlippedCoin()
                }
                .sheet(isPresented: $outputScreens[2]) {
                    RolledDice()
                }
            }
            .navigationTitle("randomigo")
        }
    }
}



//MARK: Views for outpus
struct DrawnCard: View {
    @Environment(\.dismiss) var dismiss
    private var numberedCards = ["A","2","3","4","5","6","7","8","9","10","J","Q","K",]
    private var suites = ["♣️","♠️","♥️","♦️"]
    private var suiteNames = ["Clubs","Spades","Hearts","Diamonds"]
    @State private var chosenCard = Int.random(in: 0...12)
    @State private var chosenSuite = Int.random(in: 0...3)
    
    var body: some View {
        ZStack {
            Color("outputColor").ignoresSafeArea()
            VStack (spacing: 20) {
                Spacer()
                Text("Tap card to shuffle and draw again.")
                    .font(.headline)
                Spacer()
                Spacer()
                Button {
                    chosenCard = Int.random(in: 0...12)
                    chosenSuite = Int.random(in: 0...3)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(Color.white)
                            .frame(width: 200, height: 280)
                        VStack {
                            Text(numberedCards[chosenCard])
                                .font(.system(size: 96).weight(.bold))
                                .foregroundColor((chosenSuite >= 2) ? Color.red : Color.black)
                            Text(suites[chosenSuite])
                                .font(.system(size: 72))
                        }
                    }
                }
                .buttonStyle(.plain)
                Text(numberedCards[chosenCard] + " of " + suiteNames[chosenSuite])
                    .font(.largeTitle)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 42))
                }
                .buttonStyle(.plain)
                Spacer()
            }
        }
    }
}


struct FlippedCoin: View {
    @Environment(\.dismiss) var dismiss
    private var coinFaces = ["face.smiling.fill", "pesosign.circle.fill"]
    private var headsTails = ["Heads", "Tails"]
    @State private var randomCoin = Int.random(in: 0...1)
    
    var body: some View {
        ZStack{
            Color("outputColor").ignoresSafeArea()
            VStack (spacing: 20) {
                Spacer()
                Text("Tap coin to flip again.")
                    .font(.headline)
                Spacer()
                Spacer()
                Button{
                    randomCoin = Int.random(in: 0...1)
                } label: {
                    Image(systemName: coinFaces[randomCoin])
                        .font(.system(size: 192))
                }
                .buttonStyle(.plain)
                Text(headsTails[randomCoin])
                    .font(.largeTitle)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 42))
                }
                .buttonStyle(.plain)
                Spacer()
            }
        }
    }
}

struct RolledDice: View {
    @Environment(\.dismiss) var dismiss
    @State private var randomRoll = Int.random(in: 1...6)
    
    var body: some View {
        ZStack {
            Color("outputColor").ignoresSafeArea()
            VStack (spacing: 20) {
                Spacer()
                Text("Tap dice to roll again.")
                    .font(.headline)
                Spacer()
                Spacer()
                Button {
                    randomRoll = Int.random(in: 1...6)
                } label: {
                    Image(systemName: "die.face." + String(randomRoll))
                        .font(.system(size: 192))
                }
                .buttonStyle(.plain)
                Text(String(randomRoll))
                    .font(.largeTitle)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 42))
                }
                .buttonStyle(.plain)
                Spacer()
            }
        }
    }
}



// MARK: Canvas Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

