//
//  AboutUsViewController.swift
//  Inspire Love
//
//  Created by Cathy Oun on 8/16/15.
//  Copyright (c) 2015 The Love Foundation. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
  var iPadFontSize : CGFloat = 30
  @IBOutlet weak var aboutUsTextView: UITextView!
  override func viewDidLoad() {
    super.viewDidLoad()

    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
      aboutUsTextView.font = UIFont(name: aboutUsTextView.font!.fontName, size: iPadFontSize)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
