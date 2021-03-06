//
//  listTableViewCell.swift
//  catchBullying
//
//  Created by apple on 01/06/1443 AH.
//

import UIKit
import Firebase

class PatientsListCell: UITableViewCell {

  // MARK: - IBOutlets
  @IBOutlet weak var birtDay: UILabel!
  @IBOutlet weak var nickname: UILabel!
  @IBOutlet weak var profileImageView: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
    }
  
  // MARK: - Properties
  var selectedProfile: Patient?
  
  // MARK: - View controller lifecycle
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
      profileImageView.clipsToBounds = true

      
    }

  
  // MARK: - Methods
  func listTableViewCell( nikcname:String , birtDay: Int){
    nickname.text = nikcname
   
}
}
