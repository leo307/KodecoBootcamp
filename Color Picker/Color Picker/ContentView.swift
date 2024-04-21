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
                VStack{
                    // Red Slider
                    Text("Red")
                    Slider(value: $redSlider, in: 0...255, step: 1)
                    
                }
                VStack{
                    // Green Slider
                    Text("Green")
                    Slider(value: $greenSlider, in: 0...255, step: 1)
                    
                }
                VStack{
                    // Blue Slider
                    Text("Blue")
                    Slider(value: $blueSlider, in: 0...255, step: 1)
                    
                }
            }
            
            Button(action: {
                rectColor = Color(red: redSlider, green: greenSlider, blue: blueSlider)
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
