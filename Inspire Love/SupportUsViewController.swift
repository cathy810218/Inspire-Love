//
//  SupportUsViewController.swift
//  Inspire Love
//
//  Created by Cathy Oun on 8/16/15.
//  Copyright (c) 2015 The Love Foundation. All rights reserved.
//

import UIKit

class SupportUsViewController: UIViewController {
  var iPadFontSize : CGFloat = 30
  
  @IBAction func donationButtonPressed(sender: UIButton) {
    
    let alert = UIAlertController(title: "Attention", message: "By clicking OK, you agree to exit the app and will be directed to the Paypal donation page.", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
      var url : NSURL!
      url = NSURL(string: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=283RGZX2GVAD8")
      UIApplication.sharedApplication().openURL(url)
    }));
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))

    
    self.presentViewController(alert, animated: true, completion: nil)

  }
  @IBOutlet weak var supportLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      supportLabel.font = supportLabel.font.fontWithSize(iPadFontSize)
    }
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
