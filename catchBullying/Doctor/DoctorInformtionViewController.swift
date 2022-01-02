//
//  DoctorInformtionViewController.swift
//  catchBullying
//
//  Created by apple on 29/05/1443 AH.
//

import UIKit

class DoctorInformtionViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
 
  let data : [[InformationCellModel]] = [
  
  
    [
      .init(title: "First Name", icon: "circle", color: .red),
      .init(title: "First Name", icon: "circle", color: .red)
    ],
    [
      .init(title: "Mobile Number", icon: "circle", color: .red),
      .init(title: "Address", icon: "circle", color: .red)
    ],
  
  
  ]
  
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(InformationCell.self, forCellReuseIdentifier: "cell")

    }
    
  @IBAction func saveButton(_ sender: Any) {
  }
  
    
}
extension DoctorInformtionViewController : UITableViewDelegate , UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data[section].count
  }
  

  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DoctorInformtionCell
    
    cell.textField.placeholder =
    data[indexPath.section][indexPath.row].title
    return cell
  }
  

  
  func numberOfSections(in tableView: UITableView) -> Int {
    data.count
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
