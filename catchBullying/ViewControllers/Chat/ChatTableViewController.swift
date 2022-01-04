//
//  ChatRoomTableViewController.swift
//  catchBullying
//
//  Created by apple on 26/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class ChatTableViewController: UITableViewController {
  
  var conversations: [ConversationModel] = []
  var selectedConversation: ConversationModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ChatTableToChat" {
      let vc = segue.destination as! ChattViewController
      vc.conversation = selectedConversation
    }
  }
  
  func fetchData() {
    conversations.removeAll()
    let db = Firestore.firestore()
    db.collection("conversations").whereField("usersIDs", arrayContainsAny: [user.id]).getDocuments { snapshot, error in
      guard let docs = snapshot?.documents else {
        print("no conversations")
        return
      }
      for doc in docs {
        do {
          try self.conversations.append(doc.data(as: ConversationModel.self)!)
        } catch {
          fatalError()
        }
      }
      // sort convesation by last message sentAt
      //self.messages.sort(by: { $0.sentAt > $1.sentAt })
      self.tableView.reloadData()
      
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return conversations.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatTableViewCell
    let conversation = conversations[indexPath.row]
    cell.configure(conversation: conversation)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    selectedConversation = conversations[indexPath.row]
    performSegue(withIdentifier: "ChatTableToChat", sender: self)
  }
  
  
  
}
