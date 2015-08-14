//
//  ViewController.swift
//  Inspire Love
//
//  Created by Cathy Oun on 7/29/15.
//  Copyright (c) 2015 The Love Foundation. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate {
  
  var quotes: [String]?
  var count = 0
  
  @IBOutlet weak var quoteLabel: UILabel!
  

  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let filepath = NSBundle.mainBundle().pathForResource("quotes", ofType: "json") {
      if let data = NSData(contentsOfFile: filepath) {
        quotes = jsonData(data)
        if let quotes = quotes {
          var eachQuote = quotes[count] // to display the first quote
          quoteLabel.text = eachQuote
        }
      }
    }
    
    var tapGestrue = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
    view.addGestureRecognizer(tapGestrue)
  }
  
  
  func jsonData(jsonData : NSData) -> [String] {
    var error : NSError?
    if let quote = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String] {
      if let error = error {
        let alertViewController = UIAlertController(title: "Error", message: "Failed to load the quotes", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertViewController.addAction(okAction)
        self.presentViewController(alertViewController, animated: true, completion: nil)
        exit(0)
      } else {
        return quote
      }
    }
    return []
  }
  

  func handleTapGesture(tapGesture: UITapGestureRecognizer ) {
    if let quotes = quotes {
      quoteLabel.text = quotes[++count % quotes.count]
    }
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

