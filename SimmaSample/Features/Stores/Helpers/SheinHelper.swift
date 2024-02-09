//
//  SheinHelper.swift
//  SimmaSample
//
//  Created by hosam abufasha on 09/02/2024.
//

import Foundation


struct SheinHelper{
    static let url = URL(string: "https://ar.shein.com/")!
    static let jsScript = """
              if (document.readyState === "complete" || document.readyState === "interactive") {
                                
                                  const id = setInterval(() => {
                                              try {
                                    const priceElement = document.getElementsByClassName('goods-price__main')[0].innerText
                                    const detailsElement = document.getElementsByClassName('detail-title-text fsp-element')[0].innerText
                                    const imgElement = document.getElementsByClassName('crop-image-container__img fsp-element')[0].src
                                    if(priceElement) {
                                      window.webkit.messageHandlers.jsMessenger.postMessage(JSON.stringify({ "price": priceElement, "details": detailsElement, "img":imgElement }));
                                      clearInterval(id)
                                     }
                                    } catch (e) {
                                        window.webkit.messageHandlers.jsMessenger.postMessage("");
                                       clearInterval(id)
                                      }
                                  }, 1000)
                                 
                               
                              } else {
                                window.addEventListener('load', (event) => {
                                  window.webkit.messageHandlers.jsMessenger.postMessage('The page has fully loaded');
                                });
                              }
              """
    static let cartPath = "https://ar.shein.com/cart"
}
