//
//  Example.swift
//  Custom Textfield
//
//  Created by Derek Chan on 2020/8/31.
//

import SwiftUI
import WebKit

struct Example : UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let req = URLRequest(url: URL(string: "https://www.apple.com")!)
        uiView.load(req)
    }
}

struct Example_Previews: PreviewProvider {
    static var previews: some View {
        Example()
    }
}
