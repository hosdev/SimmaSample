//
//  HomeScreen.swift
//  SimmaSample
//
//  Created by hosam abufasha on 07/02/2024.
//

import SwiftUI








struct HomeScreen: View {
    @State var isStorePresented = false
    
    var body: some View {
        NavigationStack {
            VStack{
                Button(action: {
                    isStorePresented = true
                }) {
                    Text( "Open SheIn Store")
                        .font(Font(CTFont(.application, size: 17))).fontWeight(.heavy)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 0)
                }
            }
            .navigationTitle("Home")
             .navigationDestination(isPresented: $isStorePresented) {
                    SheinStoreScreen()
            }
        }
    }
}



#Preview {
    HomeScreen()
}
