//
//  WebViewScreen.swift
//  SimmaSample
//
//  Created by hosam abufasha on 07/02/2024.
//

import SwiftUI
import WebKit

struct WebViewScreen: UIViewRepresentable {
    
    var url: URL
    @Binding var showWebView: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let wKWebView = WKWebView()
        wKWebView.navigationDelegate = context.coordinator
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(context.coordinator,  forKeyPath: "x", context: nil)
        
        return wKWebView
    }
    
    
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self)
    }
    
    class WebViewCoordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewScreen
        
        init(_ parent: WebViewScreen) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            let urlToMatch = "https://workshop.appcoda.com/"
            print(navigationAction.request.url)
            if let urlStr = navigationAction.request.url?.absoluteString, urlStr == urlToMatch {
                parent.showWebView = false
            }
            decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload) {
            print(navigationResponse.response.url)
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            // 'override' can only be specified on class member
        }
        
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            //            print("End loading")
            
            webView.evaluateJavaScript("document.body.innerHTML", completionHandler: { result, error in
                
                if let html = result as? String {
                    //print(html)
                    // we are here also at first call, i.e. web view with user / password. Custiomize as needed.
                    print("hosam\(html)")
                }
            })
            
        }
        
        
        func webViewDidFinishLoad(webView : WKWebView) {
            debugPrint("webViewDidFinishLoad: \(String(describing: webView.url))")
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            
            debugPrint("didStartProvisionalNavigation: \(String(describing: webView.url))")
        }
    }
}






