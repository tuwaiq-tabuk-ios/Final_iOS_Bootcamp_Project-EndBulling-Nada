//
//  ChatRoomTableViewController.swift
//  catchBullying
//
//  Created by apple on 26/05/1443 AH.
//

import UIKit

class ChatTableViewController: UITableViewController {
  
  // MARK: - Properties
  var conversations: [ConversationModel] = []
  var selectedConversation: ConversationModel?
  
  
  // MARK: - View controller lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    fetchData()
  }
  
  
  
  // MARK: - View controller lifecycle
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == K.Segues.go_to_ChatViewController {
      let vc = segue.destination as! ChatViewController
      vc.conversation = selectedConversation
    }
  }
  
  // MARK: - Methods
  func fetchData() {
    self.startLoading()
    conversations.removeAll()
    FirestoreRepository.shared.read(collection: K.Collections.conversations,
                             field: "usersIDs",
                             valueAny: [user.id]) { (items: [ConversationModel]) in
      self.conversations = items
      self.tableView.reloadData()
      self.stopLoading()
    }
  }
  
  // MARK: - Table   Delegate, Datasource
  
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
    performSegue(withIdentifier: K.Segues.go_to_ChatViewController, sender: self)
  }

}
