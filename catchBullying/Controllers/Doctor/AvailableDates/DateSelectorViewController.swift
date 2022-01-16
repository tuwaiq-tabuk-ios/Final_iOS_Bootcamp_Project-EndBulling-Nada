//
//  DateSelectorViewController.swift
//  catchBullying
//
//  Created by apple on 02/06/1443 AH.
//

import UIKit

class DateSelectorViewController: UIViewController {

  
  // MARK: - IBOutlets
  @IBOutlet weak var datePicker: UIDatePicker!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    }
    
  
  // MARK: - IBAction
  @IBAction func addAction(_ sender: Any) {
    print(datePicker.date)
    if doctorProfile.availableDates.contains(where: { d in
//     compare year and month and day and time
      return false
    }) {
      return
    }
    doctorProfile.availableDates.append(datePicker.date)
    
    FirestoreRepository.update(collection: "doctors",
                               documentID: doctorProfile.docID!,
                               document: doctorProfile) {
      self.navigationController?.popViewController(animated: true)
    }
    
  }

}
