//
//  InformationPatienViewController.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit

class InformationPatienViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nickName: MainTF!
  @IBOutlet weak var dateOfBirth: MainTF!
  
  let datePicker = UIDatePicker()
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
   createDatePiker()
        
    }
    
  func createToolbar() -> UIToolbar {
    
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:#selector(donePressed))
    
    toolbar.setItems([doneBtn], animated: true)
    
    return toolbar
  }

  func createDatePiker(){
    datePicker.preferredDatePickerStyle = .wheels
    datePicker.datePickerMode = .date
    dateOfBirth.inputView = datePicker
    dateOfBirth.inputAccessoryView = createToolbar()
  }
  
 @objc func donePressed() {
   
   let dateFormatter = DateFormatter()
   dateFormatter.dateStyle = .medium
   dateFormatter.timeStyle = .none
   self.dateOfBirth.text = dateFormatter.string(from:datePicker.date)
   self.view.endEditing(true)
  
  }
  
}

extension InformationPatienViewController {}
