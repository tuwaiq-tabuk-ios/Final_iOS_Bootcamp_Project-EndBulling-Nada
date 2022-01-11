//
//  PatientInformtionViewController.swift
//  catchBullying
//
//  Created by apple on 29/05/1443 AH.
//

import UIKit

class PatientInformtionViewController: UIViewController {
  
  let data : [[InformationCellModel]] = [
    [
      .init(title: "First Name", cellType: .textField),
      .init(title: "Last Name", cellType: .textField),
      .init(title: "Mobile Number", cellType: .textField),
      .init(title: "Email", cellType: .textField)
    ],
    [
      .init(title: "Zoom", cellType: .textField),
      .init(title: "Experience", cellType: .stepper),
      .init(title: "Languages", cellType: .textField)
    ],
    [
      .init(title: "Description", cellType: .textArea)
    ],
  ]
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
 

    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(InformationCell.self, forCellReuseIdentifier: "cell")
  }
}

extension PatientInformtionViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    data.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InformationCell
    //cell.selectionStyle = .none
    cell.textField.placeholder = data[indexPath.section][indexPath.row].title
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("select")
    let cell = tableView.cellForRow(at: indexPath) as! InformationCell
    cell.textField.becomeFirstResponder()
  }
  
}
