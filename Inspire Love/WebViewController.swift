//
//  WebViewController.swift
//  Inspire Love
//
//  Created by Cathy Oun on 8/20/15.
//  Copyright (c) 2015 The Love Foundation. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let webView = WKWebView(frame: view.frame)
    webView.navigationDelegate = self
    view.insertSubview(webView, belowSubview: activityIndicator)
    
    let urlRequest = NSURLRequest(URL: NSURL(string: "http://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=283RGZX2GVAD8")!)
    webView.loadRequest(urlRequest)
    activityIndicator.hidesWhenStopped = true
    activityIndicator.startAnimating()
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}


extension WebViewController : WKNavigationDelegate {
  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    activityIndicator.stopAnimating()
  }
}