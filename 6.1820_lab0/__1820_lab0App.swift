//
//  __1820_lab0App.swift
//  6.1820_lab0
//
//  Created by Maxwell Zetina on 2/6/25.
//

import SwiftUI

@main
struct __1820_lab0App: App {
    @State private var weather = Weather()

    var body: some Scene {
        WindowGroup {
            ContentView().environment(weather)

        }
    }
}
