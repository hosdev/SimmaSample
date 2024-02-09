//
//  SheinStoreScreen.swift
//  SimmaSample
//
//  Created by hosam abufasha on 08/02/2024.
//

import SwiftUI



struct SheinStoreScreen: View {
    let pasteboard = UIPasteboard.general
    @StateObject var viewmodel = SheinViewModel()
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(content: {
            
            if(viewmodel.webView != nil) {
                viewmodel.webView!.frame(height: .infinity)
            } else {
                ProgressView()
            }
            
            
            ///Show price only if user in the product page
            if(viewmodel.sheinItemModel != nil){
                HStack{
                    
                    AsyncImage(
                        url: URL(string: viewmodel.sheinItemModel!.img),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 80, maxHeight: 80)
                        },
                        placeholder: {
                            ProgressView().frame(maxWidth: 80, maxHeight: 80)
                        }
                    )
                    Text(viewmodel.sheinItemModel!.details).font(.caption)
                    Spacer()
                    Text(viewmodel.sheinItemModel!.price)
                }.padding(.horizontal,10)
                    .background(.black)
            }
            
            Button(action: {
                ///Navigate to cart
                viewmodel.webView?.goSpesificPath(path: SheinHelper.cartPath)
            }) {
                HStack {
                    Text( viewmodel.isInCart ? "Show Cart" : "Checkout")
                        .font(.title2)
                    Image(systemName:viewmodel.isInCart ? "arrowshape.turn.up.forward.circle" : "cart.circle" )
                        .font(.system(size: 30))
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewmodel.isInCart ? Color.green.gradient : Color.orange.gradient)
            }
            .buttonStyle(CartButtonStyle())
        })
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(viewmodel.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                if(!viewmodel.title.isEmpty) {
                    Menu {
                        Button(action: {
                            pasteboard.string = viewmodel.title
                        }) {
                            Label("Copy URL", systemImage: "doc.on.doc")
                        }
                        
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
            ToolbarItemGroup(placement: .topBarLeading) {
                Button(action: {dismiss()}) {
                    Image(systemName: "house")
                }
                
            }
        }
    }
}

#Preview {
    SheinStoreScreen()
}


struct CartButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
