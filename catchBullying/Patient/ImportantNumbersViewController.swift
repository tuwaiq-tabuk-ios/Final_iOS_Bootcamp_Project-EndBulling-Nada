//
//  ImportantNumbersViewController.swift
//  catchBullying
//
//  Created by apple on 25/05/1443 AH.
//

import UIKit

class ImportantNumbersViewController: UIViewController {

  @IBOutlet weak var tabelView: UITableView!
  
  var importantNumbersarray : [ImportantNumbers] = [
    ImportantNumbers( title: "Child HelpLine "      , phoneNumber: "116111"    , icon: "phone"),
    
    ImportantNumbers( title: "Receiving Communications Center Against Violence and Abuse"      , phoneNumber: "1919"   , icon: "phone"),
    
    ImportantNumbers( title: "Protection Committee in Riyadh Province"      , phoneNumber: "0112075242"    , icon: "phone"),
    
    ImportantNumbers( title: "ProtectProtection Committee in Makkah Province"      , phoneNumber: "144235048"    , icon: "phone"),
    
    ImportantNumbers( title: "ProtectProtection Committee in Tabuk Province"      , phoneNumber: "14423504845"    , icon: "phone"),

    
    ImportantNumbers( title: "Protection Committee in Al-Baha Province"      , phoneNumber: "146629932"    , icon: "phone")

                                                    
  ]
  
  
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

    tabelView.dataSource = self
    tabelView.delegate = self
    }
    

  

}

extension ImportantNumbersViewController : UITableViewDelegate , UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return importantNumbersarray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//    let data = importantNumbersarray[indexPath.row]
    cell.imageView?.image = UIImage(systemName:importantNumbersarray[indexPath.row].icon)
    cell.textLabel?.text = importantNumbersarray[indexPath.row].title
    cell.textLabel?.text = importantNumbersarray[indexPath.row].phoneNumber

    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
}
