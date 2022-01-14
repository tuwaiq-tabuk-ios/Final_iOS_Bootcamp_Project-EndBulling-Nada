//
//  DateSelectorViewController.swift
//  catchBullying
//
//  Created by apple on 02/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class DateSelectorViewController: UIViewController {

  @IBOutlet weak var datePicker: UIDatePicker!
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  @IBAction func addAction(_ sender: Any) {
    print(datePicker.date)
    if doctorProfile.availableDates.contains(where: { d in
//     compare year and month and day
      return false
    }){
      return
    }
    doctorProfile.availableDates.append(datePicker.date)
    let db = Firestore.firestore()
    do {
      try db.collection("doctors").document(doctorProfile.docID!).setData(from: doctorProfile) { error in
        if let error = error {
          fatalError()
        }
        self.navigationController?.popViewController(animated: true)
      }
    } catch {
      fatalError()
    }
    
  }

}
