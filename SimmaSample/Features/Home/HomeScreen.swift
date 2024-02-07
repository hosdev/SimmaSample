//
//  HomeScreen.swift
//  SimmaSample
//
//  Created by hosam abufasha on 07/02/2024.
//

import SwiftUI








struct HomeScreen: View {
    
    @State var showWebView = false
    
    var body: some View {
        WebViewScreen(url: URL(string: "https://ar.shein.com/")!, showWebView: $showWebView)
            .navigationTitle("Home")
    }
}



#Preview {
    HomeScreen()
}
