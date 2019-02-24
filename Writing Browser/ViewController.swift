//
//  ViewController.swift
//  Writing Browser
//
//  Created by zijia zhang on 2018-10-10.
//  Copyright © 2018 zijia zhang. All rights reserved.
//
import UIKit
import WebKit
class ViewController: UIViewController, UISearchBarDelegate, WKNavigationDelegate {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var canvasView: DrawView!
    @IBOutlet var webView: WKWebView!
    var fakeSearchbar: UISearchBar = UISearchBar(frame: CGRect(x:100,y:100,width: 50,height: 50))
    @IBAction func forward(_ sender: Any) {
        if(webView.canGoForward){
            webView.goForward()
        }
    }
    @IBAction func Clear(_ sender: Any) {
        canvasView.clearCanvas(animated: true)
    }
    @IBAction func refresh(_ sender: Any) {
        webView.reload()
    }
    @IBAction func back(_ sender: Any) {
        if(webView.canGoBack){
            webView.goBack()
        }
    }
    
    @IBOutlet var `switch`: UIBarButtonItem!
    @IBAction func Switch(_ sender: Any) {
        canvasView.ispassing = !canvasView.ispassing
        if(!canvasView.ispassing){
            `switch`.tintColor = UIColor.red
        }else{
            `switch`.tintColor = nil
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canvasView.clearCanvas(animated: false)
        webView.load(URLRequest(url:URL(string: "https://canvas.ubc.ca")!))
        webView.navigationDelegate = self
        fakeSearchbar.delegate = self
        
        fakeSearchbar.isUserInteractionEnabled = false
        searchBar.inputAccessoryView = fakeSearchbar
        canvasView.webView = self.webView

    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var urlString: String = searchBar.text!
        
        if urlString.starts(with: "http://") || urlString.starts(with: "https://") {
            let url = URL(string: urlString)
            let request = URLRequest(url: url!)
            self.webView.load(request)
        }else{
            urlString = "https://www.google.ca/search?q=\(urlString)"
            self.webView.load(URLRequest(url: URL(string: urlString)!))
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fakeSearchbar.text = searchText
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
        }
    }


