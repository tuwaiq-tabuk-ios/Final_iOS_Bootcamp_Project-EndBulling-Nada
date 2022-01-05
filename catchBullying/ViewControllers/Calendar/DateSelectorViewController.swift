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
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
