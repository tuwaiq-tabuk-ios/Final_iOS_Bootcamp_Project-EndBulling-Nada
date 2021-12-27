//
//  QuestionsViewController.swift
//  catchBullying
//
//  Created by apple on 15/05/1443 AH.
//

import UIKit

class QuestionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      self.navigationItem.setHidesBackButton(true, animated: false)
      
    }
    
  @IBAction func nextButton(_ sender: Any) {
    let vc = storyboard?.instantiateViewController(withIdentifier: "logindoctor")
    navigationController?.pushViewController(vc!, animated: true)
  }
  
}
