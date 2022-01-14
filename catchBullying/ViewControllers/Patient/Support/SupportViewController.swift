//
//  SupportViewController.swift
//  catchBullying
//
//  Created by apple on 15/05/1443 AH.
//

import UIKit
import WebKit


class SupportViewController: UIViewController {
  
  var selectedURL: String?
    override func viewDidLoad() {
        super.viewDidLoad()
      
    
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showVideo" {
      let vc = segue.destination as! VideoPlayerViewController
      vc.url = URL(string: selectedURL!)!
    }
  }
  
  func playVideo(urlString: String) {
    selectedURL = urlString
    performSegue(withIdentifier: "showVideo", sender: self)
  }
    
  @IBAction func video1Action(_ sender: Any) {
    playVideo(urlString: "https://youtu.be/c0TkALJp5xI")
  }
  
  @IBAction func video2Action(_ sender: Any) {
    playVideo(urlString: "https://youtu.be/tJsGGsPNakw")
  }
  
  @IBAction func video3Action(_ sender: Any) {
    playVideo(urlString: "https://youtu.be/4mrE5zgEvt4")
  }
 
  
  
  
}
