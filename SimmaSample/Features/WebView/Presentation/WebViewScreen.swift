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
    var jsScript: String
    var onChangeURL : (String)->()
    var onJSMessageListener : (String)->()
    
    let webView = WKWebView()
    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        ///Add observer for listining to url changes
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        let request = URLRequest(url: url)
        
        //let userScript = WKUserScript.init(source: javascript, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        //webView.configuration.userContentController.addUserScript(userScript)
        
        ///Add js channel
        webView.configuration.userContentController.add(context.coordinator, name: "jsMessenger")
        webView.load(request)
        return webView
    }
    
    
    func updateUIView(_ webView: WKWebView, context: Context) {
    }
    
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self)
    }
    
    
    func refresh() {
        webView.reload()
    }
    
    func goBack() {
        guard webView.canGoBack else { return }
        webView.goBack()
    }
    
    func goForward() {
        guard webView.canGoForward else { return }
        webView.goForward()
    }
    
    func goSpesificPath(path: String) {
        webView.load(URLRequest(url: (URL(string: path)!)))
    }
    
   
    
    class WebViewCoordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        
        var parent: WebViewScreen
        init(_ parent: WebViewScreen) {
            self.parent = parent
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            /// Listen to js messages
            parent.onJSMessageListener(String(describing: message.body))           
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            
            if keyPath == #keyPath(WKWebView.estimatedProgress) {
                if (self.parent.webView.estimatedProgress == 1) {
                    // print("### EP:", self.parent.webView.estimatedProgress)
                }
            }
            
            if keyPath == "URL" {
                /// Inject js script
                self.parent.webView.evaluateJavaScript(parent.jsScript) { (result, error) in
                   
                }
                if let url = change?[NSKeyValueChangeKey(rawValue: "new")], url is URL {
                    ///  Notify subscribers for url changes
                    parent.onChangeURL((url as! URL).absoluteString)
                }
            }
        }
        
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
                
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
        }
        
        deinit {
            parent.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.url))
            parent.webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        }
    }
}






