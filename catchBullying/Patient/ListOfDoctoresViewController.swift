//
//  ListOfDoctoresViewController.swift
//  catchBullying
//
//  Created by apple on 15/05/1443 AH.
//

import UIKit
import SwiftUI

class ListOfDoctoresViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var arryListOfDoctores : [ListOfDoctores] = [ListOfDoctores(name:"name" , emil: "emil" , zoom:"zome" ,image: UIImage(named: "")       ),
     ListOfDoctores(name:"name" , emil: "emil" , zoom: "zoom"),
     ListOfDoctores(name:"name" , emil: "emil" , zoom: "zoom"),
     ListOfDoctores(name:"name" , emil: "emil" , zoom: "zoom"),
     ListOfDoctores(name:"name" , emil: "emil" , zoom: "zoom"),
     ListOfDoctores(name:"name" , emil: "emil" , zoom: "zoom")
  ]
  
  var currentDescription: String = ""
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
    
    
    }

}

extension ListOfDoctoresViewController : UITableViewDelegate , UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arryListOfDoctores.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath) as! listTableViewCell
    let data = arryListOfDoctores[indexPath.row]
    cell.listTableViewCell(name: data.name, email: data.emil, zoom: data.zoom)
//
//   cell.textLabel?.text = arryListOfDoctores[indexPath.row].name
//   cell.textLabel?.text = arryListOfDoctores[indexPath.row].emil
//   cell.textLabel?.text = arryListOfDoctores[indexPath.row].zoom
    cell.imageView?.image = arryListOfDoctores[indexPath.row].image
//   cell.textLabel?.text = "nada"
//    cell.imageViewDoctor.layer.cornerRadius = 
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   print(indexPath.row)
  }


 
  
//  let vc = UIStoryboard?.instantiateViewController(withIdentifier: "profileDoctor")
  
  
  
}
