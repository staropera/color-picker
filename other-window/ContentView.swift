//
//  ContentView.swift
//  other-window
//
//  Created by Szymon Błaszczyński on 25/08/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var r: Double = 0.5
    @State private var g: Double = 0.5
    @State private var b: Double = 0.5
    @State private var a: Double = 0
    
    @State private var pause: Bool = false
    
    var body: some View {
        VStack {
            Text("Metal API and color picker")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            HStack {
                let number = String(format: "%0.f", r*255)
                Text("Red: " + number)
                Slider(value: $r)
            }
            HStack {
                let number = String(format: "%0.f", g*255)
                Text("Green: " + number)
                Slider(value: $g)
            }
            HStack {
                let number = String(format: "%0.f", b*255)
                Text("Blue: " + number)
                Slider(value: $b)
            }
//        Slider(value: $a)
            Toggle("Pause", isOn: $pause)
            MetalView(r: $r, g: $g, b: $b, a: $a)
                .onAppear() {
                    changeColor()
                }
                .background(Color.black)
        }
    }
    
    func changeColor() {
        if !pause {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let rr = Int.random(in: 0..<2)
                let gg = Int.random(in: 0..<2)
                let bb = Int.random(in: 0..<2)
                if r <= 0.01 || r >= 0.99 {
                    r = 0.5
                } else if rr == 1 {
                    r += 1/255
                } else {
                    r -= 1/255
                }
                if g <= 0.01 || g >= 0.99 {
                    g = 0.5
                } else if gg == 1 {
                    g += 1/255
                } else {
                    g -= 1/255
                }
                if b <= 0.01 || b >= 0.99 {
                    b = 0.5
                } else if bb == 1 {
                    b += 1/255
                } else {
                    b -= 1/255
                }
                changeColor()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                changeColor()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
