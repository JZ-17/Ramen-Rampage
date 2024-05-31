//
//  ContentView.swift
//  Ramen Clicker
//
//  Created by Joshua Zhang on 5/21/24.
//

import UIKit
import SwiftUI



struct ContentView: View {
    @ObservedObject var gameState = GameState()

    var body: some View {

        HStack {
            VStack {
                // Ramen Button
                Button(action: { self.gameState.click() }) {
                    Image("Ramen Bowl")
                        .resizable() // Make the image resizable
                        .scaledToFit() // Scale the image to fit the available space while preserving its aspect ratio
                        .frame(width: 225, height: 225) // Set the desired frame size
                }


                // Points Tracker
                Text("Points: \(gameState.points)")
                    .font(.custom("PressStart2P-Regular", size: 24))
                    .foregroundColor(Color.black)
                    .overlay(
                        Text("Points: \(gameState.points)")
                            .font(.custom("PressStart2P-Regular", size: 24))
                            .foregroundColor(Color.white)
                            .offset(x: 1, y: 1)
                    )
                    
                    

                if self.gameState.pointsPerSecond > 0 {
                    Text("PPS: \(gameState.pointsPerSecond)")
                        .font(.custom("PressStart2P-Regular", size: 18))
                        .foregroundColor(Color.black)
                        .overlay(
                            Text("PPS: \(gameState.pointsPerSecond)")
                                .font(.custom("PressStart2P-Regular", size: 18))
                                .foregroundColor(Color.white)
                                .offset(x: 1, y: 1)
                        )
                }
            }
            .padding() // Padding around the VStack for some spacing

            Spacer() // Optional, to push the List to the right

            List(gameState.pointGenerators.enumerated().filter { (index, generator) in
                index == 0 || gameState.pointGenerators[index - 1].level >= 10
            }, id: \.element.id) { index, pointGenerator in
                HStack {
                    VStack(alignment: .leading) {
                        Text(pointGenerator.name)
                            .font(.headline)
                        Text("Level: \(pointGenerator.level)")
                        Text("Points Per Second: \(pointGenerator.pointsPerSecond)")
                        Text("Price: \(pointGenerator.price) points")
                    }
                    Spacer()
                    Button(action: { self.gameState.purchase(pointGenerator: pointGenerator) }) {
                        Rectangle()
                            .frame(width: 100, height: 50) // Adjust the size of the rectangle to make the press area smaller
                            .foregroundColor(Color.clear) // Make the rectangle background color clear
                            .overlay(
                                Image("Purchase Button")
                                    .resizable() // Make the image resizable
                                    .scaledToFit() // Scale the image to fit the available space while preserving its aspect ratio
                                    .frame(width: 200, height: 150)
                            )
                    }
                    .buttonStyle(BorderedButtonStyle())
                    .disabled(self.gameState.points < pointGenerator.price)

                }
                .padding()
                .background(
                    Color.white.opacity(0) // Set the translucent background color
                            .overlay(
                                Image("List Background") // Set the background image for each cell
                                    .resizable()
                                    .frame(width: 686, height: 256) // Adjust the frame size as needed
                                    .offset(x: 0,y :2)
                                    
                            )
                    )
            }
            .listStyle(PlainListStyle()) // Set list style to Translucent
            .background(
                Color.white.opacity(0) // Set the translucent background color for the List
            )
            .frame(maxWidth: .infinity) // Make the List take the remaining space

        }
        .padding() // Padding around the HStack for some spacing
        .background(
                Image("Wooden Background") // Set the background image
                        .resizable() // Make the image resizable
                        .scaledToFill() // Scale the image to fill the available space
                        .edgesIgnoringSafeArea(.all) // Ignore safe area edges
    )}
}



#Preview {
    ContentView()
}
