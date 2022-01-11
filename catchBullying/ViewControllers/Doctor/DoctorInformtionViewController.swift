//
//  DoctorInformtionViewController.swift
//  catchBullying
//
//  Created by apple on 29/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class DoctorInformtionViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  //  var firstName :String
  //  var lastName :String
  //  var mobileNumber : String
  //  var email: String
  //  var imageURL: String
  //  var zoom: String
  //  var experience: Int
  //  var languages: [String]
  //  var description: String
  //  var answers: [Int]
  
  let data : [[InformationCellModel]] = [
    [
      .init(title: "First Name", cellType: .textField),
      .init(title: "Last Name", cellType: .textField),
      .init(title: "Mobile Number", cellType: .textField),
      .init(title: "Email", cellType: .textField)
    ],
    [
      .init(title: "Zoom", cellType: .textField),
      .init(title: "Experience", cellType: .textField),
      .init(title: "Languages", cellType: .textField)
    ],
    [
      .init(title: "Description", cellType: .textArea)
    ],
  ]
  
  @IBAction func hideKeyboard() {
    view.endEditing(true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
   

    
    
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(InformationCell.self, forCellReuseIdentifier: "cell")

    
  }
  
//  let data : [[InformationCellModel]] = [
//    [
//      .init(title: "First Name", cellType: .textField),
//      .init(title: "Last Name", cellType: .textField),
//      .init(title: "Mobile Number", cellType: .textField),
//      .init(title: "Email", cellType: .textField)
//    ],
//    [
//      .init(title: "Zoom", cellType: .textField),
//      .init(title: "Experience", cellType: .textField),
//      .init(title: "Languages", cellType: .textField)
//    ],
//    [
//      .init(title: "Description", cellType: .textArea)
//    ],
//  ]
  
  func getCell(indexPath: IndexPath) -> InformationCell {
    let cell = tableView.cellForRow(at: indexPath) as! InformationCell
    return cell
  }
  
  @IBAction func saveButton(_ sender: Any) {
    let updatedProfile = DoctorModel(id: doctorProfile.id,
                                     firstName: getCell(indexPath: IndexPath(row: 0, section: 0)).textField.text!,
                                     lastName: getCell(indexPath: IndexPath(row: 1, section: 0)).textField.text!,
                                     mobileNumber: getCell(indexPath: IndexPath(row: 2, section: 0)).textField.text!,
                                     
                                     imageURL: doctorProfile.imageURL,
                                     zoom: getCell(indexPath: IndexPath(row: 0, section: 1)).textField.text!,
                                     experience: Int(getCell(indexPath: IndexPath(row: 1, section: 1)).textField.text!)!,
                                     languages: [],
                                     availableDates: [], description: getCell(indexPath: IndexPath(row: 0, section: 0)).textArea.text!,
                                     answers: doctorProfile.answers)
    
    let db = Firestore.firestore()
    do {
      try db.collection("doctors").document(doctorProfile.docID!).setData(from: updatedProfile, merge: true) { error in
        if let error = error {
          fatalError()
        }
      }
    } catch {
      fatalError()
    }
    
  }
  
  
}
extension DoctorInformtionViewController : UITableViewDelegate , UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data[section].count
  }
  
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellData = data[indexPath.section][indexPath.row]
    let cell = InformationCell(style: .default, reuseIdentifier: "cell", cellType: cellData.cellType)
    //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InformationCell
    cell.selectionStyle = .blue
    if cellData.cellType == .textField {
      cell.label.text = cellData.title
      cell.textField.placeholder = cellData.title
    } else if cellData.cellType == .stepper {
      cell.label.text = cellData.title + ": \(doctorProfile.experience)"
      cell.stepper.minimumValue = 0
      cell.stepper.value = Double(doctorProfile.experience)
      cell.stepper.maximumValue = 20
      cell.stepper.stepValue = 1
    } else if cellData.cellType == .textArea {
      cell.label.text = cellData.title
    }
    return cell
  }
  
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    data.count
  }
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let cellData = data[indexPath.section][indexPath.row]
    if cellData.cellType == .textArea {
      return 150
    } else {
      return 50
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    let cellData = data[indexPath.section][indexPath.row]
    let cell = tableView.cellForRow(at: indexPath) as! InformationCell
    if cellData.cellType == .textField {
      cell.textField.becomeFirstResponder()
    } else if cellData.cellType == .stepper {
      
    } else if cellData.cellType == .textArea {
      cell.textArea.becomeFirstResponder()
    }
  }
  
}
