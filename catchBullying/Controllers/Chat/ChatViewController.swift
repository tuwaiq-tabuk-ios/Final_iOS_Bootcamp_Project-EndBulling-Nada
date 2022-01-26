//
//  ChattViewController.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit

class ChatViewController: UIViewController {
  
  
  // MARK: -IBOutleta
  @IBOutlet weak var senderName: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextField: UITextField!
  
  
  // MARK: - Properties
  var conversation: ConversationModel?
  
  // MARK: - View controller lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()


    self.dismissKeyboard()
    tableView.delegate = self
    tableView.dataSource = self
    fetchData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    senderName.text = conversation?.users.first(where: { $0.id != user.id })!.name
  }
  
  
  // MARK: - Methods
  func fetchData() {
    FirestoreRepository.shared.listen(collection: K.Collections.conversations,
                               documentID: conversation!.docID!) { (item: ConversationModel) in
      self.conversation = item
      //      self.messages.sort(by: { $0.sentAt > $1.sentAt })
      self.tableView.reloadData()
    }
  }
  
  // MARK: -IBActions
  @IBAction func closeButtonPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func sendButtonPressed(_ sender: Any) {
    guard let message = messageTextField.text else { return }
    if message == "" { return }
    let messageModel = Message(id: UUID(),
                                    content: message,
                                    received: false,
                                    sender: user.id,
                                    sentAt: Date())
    
    conversation?.messages.append(messageModel)
    
    FirestoreRepository.shared.update(collection: K.Collections.conversations,
                               documentID: conversation!.docID!,
                               document: conversation) {
      self.messageTextField.text = ""
    }
  }
  
}


// MARK: - Table   Delegate, Datasource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    conversation!.messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageCell
    cell.configure(message: conversation!.messages[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let totalLetters = conversation!.messages[indexPath.row].content.count
    let lines = abs(totalLetters / 40)
    print(totalLetters, lines)
    
    return CGFloat((lines + 1) * 40)
  }
}
