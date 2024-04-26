//
//  ContentView.swift
//  Color Picker
//
//  Created by Leo DelPrete on 4/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var redSlider: Double = 0.5
    @State private var greenSlider: Double = 0.5
    @State private var blueSlider: Double = 0.5
    @State private var rectColor = Color(red: 0.4627, green: 0.8392, blue: 1.0)


    var body: some View {
        VStack {
            
            Text("Color Picker").font(.system(size: 40))
            RoundedRectangle(cornerRadius: 20).fill(rectColor)
            
            VStack {
                
                // Red Slider
                Text("Red")
                HStack{
                    Slider(value: $redSlider, in: 0...255)
                    Text("\(Int(redSlider))")
                }
                // Green Slider
                Text("Green")
                HStack{
                    Slider(value: $greenSlider, in: 0...255)
                    Text("\(Int(greenSlider))")
                }
                // Blue Slider
                Text("Blue")
                HStack{
                    Slider(value: $blueSlider, in: 0...255)
                    Text("\(Int(blueSlider))")
                }
            }
            
            Button(action: {
                rectColor = Color(red: redSlider / 255, green: greenSlider / 255, blue: blueSlider / 255)
            }){
                Text("Set Color")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
