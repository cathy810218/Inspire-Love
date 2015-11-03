//
//  ViewController.swift
//  Inspire Love
//
//  Created by Cathy Oun on 7/29/15.
//  Copyright (c) 2015 The Love Foundation. All rights reserved.
//

import UIKit
import Social


class ViewController: UIViewController, UIGestureRecognizerDelegate {
  
  var quotes: [String]?
  var index = 0
  let iPadQuoteFontSize : CGFloat = 30
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var quoteLabel: UILabel!
  
  @IBAction func optionButtonAction(sender: UIBarButtonItem) {
    selectionAlert.modalPresentationStyle = UIModalPresentationStyle.Popover
    if let popover = selectionAlert.popoverPresentationController {
      popover.sourceView = view
      if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
        popover.permittedArrowDirections = UIPopoverArrowDirection.Up
        popover.sourceRect = CGRectMake(view.frame.maxX, view.bounds.origin.y, 0, 0)
      }
    }
    self.presentViewController(selectionAlert, animated: true, completion: nil)
  }
  let selectionAlert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
//      backgroundImageView.image = UIImage(named: "iPadBackgroundImage.jpg");
//    } else {
//      // assume its initially portrait
//      backgroundImageView.image = UIImage(named: "iPadBackgroundImage.jpg");
//    }
    
    
    let cancelAtion = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (alert) -> Void in
    }
    let aboutUsAction = UIAlertAction(title: "About Us", style: UIAlertActionStyle.Default) { (alert) -> Void in
      // segue
      self.performSegueWithIdentifier("AboutUs", sender: self)
    }
    
    let shareAction = UIAlertAction(title: "Share Quote", style: UIAlertActionStyle.Default) { (alert) -> Void in
      // social sharing
      let quoteToShare : String = self.quoteLabel.text!
      let shareObjects : NSArray = [quoteToShare + "\nBy Harold W. Becker" + "\n\nhttps://itunes.apple.com/us/app/inspire-love/id1038260913?ls=1&mt=8"]
     
      let gpBoard = UIPasteboard.generalPasteboard()
      gpBoard.strings = shareObjects as? [String];
      
//      let fbShareLink : FBSDKShareLinkContent = FBSDKShareLinkContent()
//      fbShareLink.contentURL = NSURL(string: "https://itunes.apple.com/us/app/inspire-love/id1038260913?ls=1&mt=8")

      
      if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
        
        let activityViewController = UIActivityViewController(activityItems: gpBoard.strings!, applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
          if activityViewController.respondsToSelector("popoverPresentationController") {
            let presentationController = activityViewController.popoverPresentationController
            presentationController?.permittedArrowDirections = UIPopoverArrowDirection.Up
            presentationController?.sourceRect = CGRectMake(self.view.frame.maxX, self.view.bounds.origin.y, 0, 0)
            presentationController?.sourceView = self.view
          }
        }

      } else {
        let activityViewController = UIActivityViewController(activityItems: shareObjects as [AnyObject] , applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
          if activityViewController.respondsToSelector("popoverPresentationController") {
            let presentationController = activityViewController.popoverPresentationController
            presentationController?.permittedArrowDirections = UIPopoverArrowDirection.Up
            presentationController?.sourceRect = CGRectMake(self.view.frame.maxX, self.view.bounds.origin.y, 0, 0)
            presentationController?.sourceView = self.view
          }
        }

      }
      
    }
    
    let supportAction = UIAlertAction(title: "Support Us", style: UIAlertActionStyle.Default) { (alert) -> Void in
      // segue
      self.performSegueWithIdentifier("SupportUs", sender: self)
    }
    
    selectionAlert.addAction(shareAction)
    selectionAlert.addAction(supportAction)
    selectionAlert.addAction(aboutUsAction)
    selectionAlert.addAction(cancelAtion)
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      quoteLabel.font = quoteLabel.font.fontWithSize(iPadQuoteFontSize)
    }
    if let filepath = NSBundle.mainBundle().pathForResource("quotes", ofType: "json") {
      if let data = NSData(contentsOfFile: filepath) {
        quotes = jsonData(data)
        if let quotes = quotes {
          let eachQuote = quotes[index] // to display the first quote
          quoteLabel.text = eachQuote
        }
      }
    }
    
    // send quotes to apple watch in side view did load
    let tapGestrue = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
    view.addGestureRecognizer(tapGestrue)
  }
  
  func jsonData(jsonData : NSData) -> [String] {
    do {
      // Try parsing some valid JSON
      let quote = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.AllowFragments)
//      print(quote)
      return quote as! [String]
    }
    catch {
      // Catch fires here, with an NSErrro being thrown from the JSONObjectWithData method
      let alertViewController = UIAlertController(title: "Error", message: "Failed to load the quote", preferredStyle: .Alert)
      let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
      alertViewController.addAction(okAction)
      self.presentViewController(alertViewController, animated: true, completion: nil)
      exit(0)
    }
  }
  
  func handleTapGesture(tapGesture: UITapGestureRecognizer ) {
    if let quotes = quotes {
      quoteLabel.text = quotes[++index % quotes.count]
    }
  }
//  override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
//    let app = UIApplication.sharedApplication()
//    if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
//      
//      if (app.statusBarOrientation.isLandscape) {
//        backgroundImageView.image = UIImage(named: "backgroundLandscape.jpg");
//      }
//      else {
//        backgroundImageView.image = UIImage(named: "backgroundPortrait.jpg");
//      }
//    }
//  }
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "AboutUs" {
      if let _ = segue.destinationViewController as? AboutUsViewController {
        
      }
    }
    if segue.identifier == "SupportUs" {
      if let _ = segue.destinationViewController as? SupportUsViewController {
        
      }
    }
  }
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

