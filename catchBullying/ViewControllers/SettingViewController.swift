//
//  SettingViewController.swift
//  catchBullying
//
//  Created by apple on 25/05/1443 AH.
//

import UIKit

class SettingViewController: UIViewController {
  @IBOutlet weak var tabelView: UITableView!
  
var  array : [Setting] = [ Setting(title: "Information", icon: "person", color: .blue),
  Setting(title: "Manage My Profile", icon: "person", color: .black),
  Setting(title: "Change Language", icon:"textformat.size.smaller.ja", color: .black),
  Setting(title: "Logout", icon: "person", color: .black),
  Setting(title: "Delete Account", icon: "person", color: .red)]

  
  override func viewDidLoad() {
        super.viewDidLoad()

    tabelView.delegate = self
    tabelView.dataSource = self
    }
    



}

extension SettingViewController : UITableViewDelegate , UITableViewDataSource {
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.imageView?.image = UIImage(systemName:array[indexPath.row].icon)
    cell.textLabel?.text = array[indexPath.row].title
    cell.textLabel?.textColor = array[indexPath.row].color
    
    return cell
  }
  
  
}
