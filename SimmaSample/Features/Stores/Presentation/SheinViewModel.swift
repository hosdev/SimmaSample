//
//  SheinViewmodel.swift
//  SimmaSample
//
//  Created by hosam abufasha on 09/02/2024.
//

import Foundation
import SwiftUI

@MainActor
class SheinViewModel: ObservableObject{
    @Published var webView : WebViewScreen?
    @Published var title = ""
    @Published var sheinItemModel :  SheinItemModel?
    @Published var isInCart = false
    
    init() {
        webView = WebViewScreen(
            url: SheinHelper.url,
            jsScript: SheinHelper.jsScript,
            onChangeURL: { url in
                withAnimation {
                    self.title = url
                    self.isInCart = url.contains("cart")
                }
            },
            onJSMessageListener: { message in
                let model = try? JSONDecoder().decode(SheinItemModel.self, from: message.data(using: .utf8)!)
                withAnimation {
                    self.sheinItemModel = model
                }
            }
        )
    }
    


}
