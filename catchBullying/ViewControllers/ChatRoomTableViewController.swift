//
//  ChatRoomTableViewController.swift
//  catchBullying
//
//  Created by apple on 26/05/1443 AH.
//

import UIKit

class ChatRoomTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChatRoomTableViewCell
    let chatRoom = ChatRoom(id: "123", chatRoomId: "444", senderName: "nada", receiverId: "nada", receiverName: "nada", memberId: [], lastMessage: "Hello nada Ilove", unreadCounter: 1, avatarLink: "")
    
    cell.configure(chatRoom: chatRoom)
    return cell
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  
  
}
