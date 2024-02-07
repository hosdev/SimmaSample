//
//  NavHolderScreen.swift
//  SimmaSample
//
//  Created by hosam abufasha on 07/02/2024.
//

import SwiftUI

struct NavHolderScreen: View {
    var body: some View {
        TabView {
            HomeScreen().tabItem {
                Label("Home", systemImage: "homekit")
            }.tag(0)
            
            SettingScreen().tabItem {
                Label("Settings", systemImage: "person.crop.circle.fill")
            }.tag(1)
        }
    }
}

#Preview {
    NavHolderScreen()
}
