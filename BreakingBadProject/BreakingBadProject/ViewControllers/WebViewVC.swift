//
//  WebViewVC.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 22.11.2022.
//

import UIKit
import WebKit

final class WebViewVC: BaseViewController, WKNavigationDelegate {

    @IBOutlet private weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        let urlString = "https://www.imdb.com/title/tt0903747/?ref_=ttep_ep_tt"
        if let url = URL(string: urlString) {
            DispatchQueue.main.async {
                self.webView.navigationDelegate = self
                self.webView.load(URLRequest(url: url))
                self.indicator.stopAnimating()
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        title = webView.title
    }
    

}
