//
//  ChattViewController.swift
//  catchBullying
//
//  Created by apple on 30/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class ChattViewController: UIViewController {
  
  var conversation: ConversationModel?
  
  @IBOutlet weak var senderName: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextField: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // if there is a converasion fetch it,
    // else create new one.
    if let conversation = conversation {
      //fetchData()
    } else {
      // create new conversation
    }
  }
  
  func fetchData() {
    let db = Firestore.firestore()
    db.collection("conversations").document(conversation!.docID!).getDocument { snapshot, error in
      if let error = error {
        fatalError()
      }

      print("result")
      
      do {
        guard let data = try snapshot?.data(as: ConversationModel.self) else { return }
        self.conversation = data
      } catch {
        fatalError()
      }
//      self.messages.sort(by: { $0.sentAt > $1.sentAt })
      self.tableView.reloadData()
    }
  }
  
  
  
  @IBAction func signOutButtonPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func sendButtonPressed(_ sender: Any) {
    guard let message = messageTextField.text else { return }
    print(message)
    
    let db = Firestore.firestore()
    
    let messageModel = MessageModel(id: UUID(),
                                    content: message,
                                    received: false,
                                    sender: user.id,
                                    sentAt: Date())
    
    conversation?.messages.append(messageModel)
    do {
      try db.collection("conversations").document(conversation!.docID!).setData(from: conversation, merge: true, completion: { error in
        if let error = error {
          fatalError()
        }
        self.messageTextField.text = ""
        self.fetchData()
      })
      
    } catch {
      fatalError()
    }
    
  }
  
}

extension ChattViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    conversation!.messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCellTableViewCell
    //cell.messageLabel.text = messages[indexPath.row].message
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = conversation!.messages[indexPath.row].content
    return cell
  }
  
}
