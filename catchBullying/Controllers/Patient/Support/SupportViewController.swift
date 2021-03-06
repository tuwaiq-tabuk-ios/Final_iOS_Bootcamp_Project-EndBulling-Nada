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
      
      // MARK: - View controller lifecycle

    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == K.Segues.go_to_VideoPlayerViewController {
      let vc = segue.destination as! VideoPlayerViewController
      vc.url = URL(string: selectedURL!)!
    }
  }
  
  
  // MARK: - Methods
  func playVideo(urlString: String) {
    selectedURL = urlString
    performSegue(withIdentifier: K.Segues.go_to_VideoPlayerViewController, sender: self)
  }
    
  
  
  
  // MARK: - IBOAction
  
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
