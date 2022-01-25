//
//  ListOfPatient.swift
//  catchBullying
//
//  Created by apple on 01/06/1443 AH.
//

import UIKit

class PatientsListViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var tabelView: UITableView!
  
  // MARK: - Properties
  var patients: [Patient] = []
  var selectedProfile: Patient?
  
  
  // MARK: - Methods
  func getIds(_ completion: @escaping ([String]) -> ()) {
    var conversations: [ConversationModel] = []
    var ids: Set<String> = []
    
    FirestoreRepository.shared.read(collection: K.Collections.conversations, field: "usersIDs", valueAny: [user.id]) { (items: [ConversationModel]) in
      conversations = items
      
      for conversation in conversations {
        conversation.usersIDs.forEach {
          if $0 != user.id {
            ids.insert($0)
          }
        }
      }
      completion(Array(ids))
    }
  }
  
  
  
  // MARK: - View controller lifecycle
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.startLoading()
    getIds { ids in
      if ids.count == 0 { return }
      self.patients.removeAll()
      FirestoreRepository.shared.read(collection: K.Collections.patients, field: "id", values: ids) { (items: [Patient]) in
        self.patients = items
        self.tabelView.reloadData()
        self.stopLoading()
      }
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()


    tabelView.delegate = self
    tabelView.dataSource = self
    
    
    
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == K.Segues.go_to_PatientProfileDetailsViewController {
      let vc = segue.destination as! PatientProfileDetailsViewController
      vc.selectedProfile = selectedProfile
    }
  }
  


}

// MARK: - Delegats , DataSource
extension PatientsListViewController : UITableViewDelegate , UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return patients.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PatientsListCell
    cell.nickname.text = patients[indexPath.row].nickname
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    
    if let dob = patients[indexPath.row].dateOfBirth {
      cell.birtDay.text = dateFormatter.string(from: dob)
    }
    
    if patients[indexPath.row].imageURL != "" {
      cell.profileImageView.load(url: URL(string: patients[indexPath.row].imageURL)!)
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedProfile = patients[indexPath.row]
    self.performSegue(withIdentifier: K.Segues.go_to_PatientProfileDetailsViewController, sender: self)
  }
}
