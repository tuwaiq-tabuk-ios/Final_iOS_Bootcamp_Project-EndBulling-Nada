//
//  ListOfPatient.swift
//  catchBullying
//
//  Created by apple on 01/06/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class PatientsListViewController: UIViewController {
  
  @IBOutlet weak var tabelView: UITableView!
  
  var patients: [PatientModel] = []
  var selectedProfile: PatientModel?
  
  func getIds(_ completion: @escaping ([String]) -> ()) {
    var conversations: [ConversationModel] = []
    var ids: Set<String> = []
    let db = Firestore.firestore()
    
    db.collection("conversations").whereField("usersIDs", arrayContainsAny: [user.id]).getDocuments { snapshot, error in
      if let error = error {
        fatalError()
      }
      guard let docs = snapshot?.documents else { return }
      for doc in docs {
        do {
          try conversations.append(doc.data(as: ConversationModel.self)!)
        } catch {
          fatalError()
        }
      }
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
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let db = Firestore.firestore()
    getIds { ids in
      print(ids)
      self.patients.removeAll()
      db.collection("patients").whereField("id", in: ids).getDocuments { snapshot, error in
        if let error = error {
          fatalError()
        }
        print(snapshot?.documents.count)
        guard let docs = snapshot?.documents else { return }
        for doc in docs {
          do {
            try self.patients.append(doc.data(as: PatientModel.self)!)
          } catch {
            fatalError()
          }
        }
        self.tabelView.reloadData()
      }
    }
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "patientDetails" {
      let vc = segue.destination as! PatientProfileDetailsViewController
      vc.selectedProfile = selectedProfile
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tabelView.delegate = self
    tabelView.dataSource = self
  }

}

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
    
    cell.birtDay.text = dateFormatter.string(from: patients[indexPath.row].dateOfBirth!)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedProfile = patients[indexPath.row]
    self.performSegue(withIdentifier: "patientDetails", sender: self)
  }
}
