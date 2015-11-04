//
//  InterfaceController.swift
//  Inspire Love Watch App Extension
//
//  Created by Cathy Oun on 11/3/15.
//  Copyright © 2015 The Love Foundation. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
  var quotes: [String]?
  var index = 0
//  @IBOutlet var quote: WKInterfaceButton!
  
  @IBOutlet var backgroundGroup: WKInterfaceGroup!
  @IBOutlet var quote: WKInterfaceLabel!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

  @IBAction func nextQuoteAction() {
    if let quotes = quotes {
      quote.setText(quotes[++index % quotes.count])
    }
  }
  
  func jsonData(jsonData : NSData) -> [String] {
    do {
      // Try parsing some valid JSON
      let quote = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments)
      //      print(quote)
      return quote as! [String]
    }
    catch {

      exit(0)
    }
  }

  
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
            backgroundGroup.setBackgroundImage(UIImage(named: "background.png"))
      if let filepath = NSBundle.mainBundle().pathForResource("quotes", ofType: "json") {
        if let data = NSData(contentsOfFile: filepath) {
          quotes = jsonData(data)
          if let quotes = quotes {
            let eachQuote = quotes[index] // to display the first quote
            quote.setText(eachQuote)
          }
        }
      }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
