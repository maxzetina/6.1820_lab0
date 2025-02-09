//
//  Data.swift
//  6.1820_lab0
//
//  Created by Maxwell Zetina on 2/7/25.
//

import SwiftUI

struct Data: View {
    @Environment(Weather.self) var weather

    let screenWidth = UIScreen.main.bounds.width

    // Define the grid layout
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(Array([[weather.name, "Location"], [String(weather.currentTemp), "Temp (F)"], [weather.weatherDescription, "Description"], [weather.windString, "Wind (mph)"], [weather.visibilityKm, "Visibility (mi)"], [weather.relativeHumidity, "Humidity"]].enumerated()), id: \.offset) { index, item in
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(item[1])")
                            .font(.title2)
                            .fontWeight(.bold)
                    }.padding(.leading, 12).padding(.top, 48).frame(height: 0)
                    Spacer()
                    if(index != 1){
                        Text("\(item[0])")
                            .font(.title3)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    else{
                        StyledGauge()
                    }
                    
                    
                    Spacer()
                }.frame(width: screenWidth / 2 - 20, height: screenWidth / 2 - 20)
                    .background(Color(red: 216/255, green: 216/255, blue: 216/255))
                    .cornerRadius(10)
            }
        }        
    }
}

#Preview {
    Data().environment(Weather())
}


