//
//  LoadingSpinner.swift
//  6.1820_lab0
//
//  Created by Maxwell Zetina on 2/7/25.
//


import SwiftUI

struct LoadingSpinner: View {
    var text: String?
    var scale: Double
    var tint: Color
    @State var scaleEffect: CGSize = CGSize(width: 1, height: 1)

    var body: some View {
        VStack{
            if(text != nil) {
                ProgressView(text!).scaleEffect(scaleEffect).progressViewStyle(CircularProgressViewStyle(tint: tint))
            }
            else{
                ProgressView().scaleEffect(scaleEffect).progressViewStyle(CircularProgressViewStyle(tint: tint))
            }
        }.onAppear{
            scaleEffect = CGSize(width: scale, height: scale)
        }
    }
}

#Preview{
    LoadingSpinner(text: "Loading [Text]...", scale: 2, tint: .blue)
}
