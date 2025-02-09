//
//  StyledGauge.swift
//  6.1820_lab0
//
//  Created by Maxwell Zetina on 2/8/25.
//

import SwiftUI

func temperatureColor(_ temp: Double) -> Color {
    switch temp {
    case ..<15:
        return .purple // Cold
    case 15..<40:
        return .blue // Mild
    case 40..<80:
        return .orange // Warm
    default:
        return .red // Hot
    }
}

struct StyledGauge: View {
    @Environment(Weather.self) var weather

    @State private var minValue = 0.0
    @State private var maxValue = 110.0
    
    let gradient = Gradient(colors: [.purple, .blue, .orange, .red])

    var body: some View {
        Gauge(value: weather.currentTemp, in: minValue...maxValue) {
        } currentValueLabel: {
            Text("\(Int(weather.currentTemp))")
                .foregroundColor(temperatureColor(weather.currentTemp))
        }
        .gaugeStyle(.accessoryCircular)
        .tint(gradient).frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview{
    StyledGauge().environment(Weather())
}
