//
//  VideoPlayerViewController.swift
//  catchBullying
//
//  Created by apple on 02/06/1443 AH.
//

import Foundation
import UIKit
import WebKit

class VideoPlayerViewController: UIViewController {
  
  @IBOutlet var webView: WKWebView!
  
  var url: URL?
  
  override func viewDidLoad() {
    

    super.viewDidLoad()
    
    guard let url = url else {
      return
    }
    
    webView.configuration.mediaTypesRequiringUserActionForPlayback = .video
    webView.load(URLRequest(url: url))
  }
  
  
}
