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
    
    var body: some View {
        VStack {
            Text("\(weather.name)")
            Text("\(weather.currentTemp)")
            Text("\(weather.weatherDescription)")
            Text("\(weather.relativeHumidity)")
            Text("\(weather.windString)")
            Text("\(weather.visibilityKm)")
            
            TextField("Zip Code", text: $zipCode)

            Button(action: {
                Task{
                    _ = await weather.fetchWeatherForZip(zip: zipCode)
                    
                }
            }, label: {
                Text("Get Weather")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView().environment(Weather())
}
