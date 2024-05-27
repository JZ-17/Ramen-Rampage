//
//  ContentView.swift
//  Ramen Clicker
//
//  Created by Joshua Zhang on 5/21/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameState = GameState()

    var body: some View {
        HStack {
            VStack {
                Button(action: { self.gameState.click() }) {
                    Text("Tap Here")
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(5)
                .foregroundColor(.white)

                Text("Points: \(gameState.points)")
                    .font(.headline)

                if self.gameState.pointsPerSecond > 0 {
                    Text("Points Per Second: \(gameState.pointsPerSecond)")
                }
            }
            .padding() // Padding around the VStack for some spacing

            Spacer() // Optional, to push the List to the right

            List(gameState.pointGenerators) { pointGenerator in
                ScrollView{
                    HStack {
                        VStack(alignment: .leading) {
                            Text(pointGenerator.name)
                                .font(.headline)
                            Text("Level: \(pointGenerator.level)")
                            Text("Points Per Second: \(pointGenerator.pointsPerSecond)")
                            Text("Price: \(pointGenerator.price) points")
                        }
                        Spacer()
                        Group {
                            Button(action: { self.gameState.purchase(pointGenerator: pointGenerator) }) {
                                Text("Purchase")
                            }
                            .buttonStyle(BorderedButtonStyle())
                            .disabled(self.gameState.points < pointGenerator.price)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity) // Make the List take the remaining space
        }
        .padding() // Padding around the HStack for some spacing
    }
}


#Preview {
    ContentView()
}
