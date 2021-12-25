//
//  PsicologistQuestionsViewController.swift
//  catchBullying
//
//  Created by apple on 11/05/1443 AH.
//

import UIKit

class PsicologistQuestionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
   
  @IBAction func nextButton(_ sender: Any) {
    let vc = storyboard?.instantiateViewController(withIdentifier: "loginuser")
    navigationController?.pushViewController(vc!, animated: true)
  
  
}
}
