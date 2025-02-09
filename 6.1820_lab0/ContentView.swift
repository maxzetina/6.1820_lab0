//
//  ContentView.swift
//  6.1820_lab0
//
//  Created by Maxwell Zetina on 2/6/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(Weather.self) var weather
    
    @State private var zipCode: String = ""
    @State private var getWeatherPressed = false
    @State private var showAlert = false

    var body: some View {
        VStack {
            Data().padding(.vertical).environment(weather)
            
            InputTextField(placeholderText: "Zip Code", input: $zipCode)

            Button(action: {
                Task{
                    getWeatherPressed.toggle()
                    await weather.fetchWeatherForZip(zip: zipCode)
                    getWeatherPressed.toggle()
                    
                    if weather.error {
                        showAlert = true
                    }
                }
            }, label: {
                RoundedRectangle(cornerRadius: 10).frame(width: 300, height: 50).foregroundColor(.blue).shadow(radius: 10).overlay(
                    
                    VStack{
                        if(getWeatherPressed){
                            LoadingSpinner(scale: 1.5, tint: .white)
                        }
                        else{
                            Text("Get Weather").foregroundColor(.white).fontWeight(.bold).font(.title3)
                        }
                    }
                )
            })
        }
        .padding()
        .alert("Error", isPresented: $showAlert, actions: { Button("OK") {showAlert = false}
            }, message: {Text("Unable to fetch weather for the provided zip code.")})
    }
}

#Preview {
    ContentView().environment(Weather())
}
