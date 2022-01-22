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
      datePicker.minimumDate = Date()
    }
    
  
  // MARK: - IBAction
  @IBAction func addPressed(_ sender: Any) {
    print(datePicker.date)
    if doctorProfile.availableDates.contains(where: { d in
      let selected = datePicker.date
      let calender = Calendar.current
      let y1 = calender.component(.year, from: selected)
      let m1 = calender.component(.month, from: selected)
      let d1 = calender.component(.day, from: selected)
      let h1 = calender.component(.hour, from: selected)
      let mi1 = calender.component(.minute, from: selected)
      let s1 = calender.component(.second, from: selected)
      
      let y2 = calender.component(.year, from: d)
      let m2 = calender.component(.month, from: d)
      let d2 = calender.component(.day, from: d)
      let h2 = calender.component(.hour, from: d)
      let mi2 = calender.component(.minute, from: d)
      let s2 = calender.component(.second, from: d)
      
      if y1 == y2 && m1 == m2 && d1 == d2 && h1 == h2 && mi1 == mi2 && s1 == s2 {
        return true
      }
      return false
    }) {
      return
    }
    doctorProfile.availableDates.append(datePicker.date)
    
    FirestoreRepository.shared.update(collection: K.collections.doctors.rawValue,
                               documentID: doctorProfile.docID!,
                               document: doctorProfile) {
      self.navigationController?.popViewController(animated: true)
    }
    
  }

}
