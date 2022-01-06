//
//  listTableViewCell.swift
//  catchBullying
//
//  Created by apple on 01/06/1443 AH.
//

import UIKit

class PatientsListCell: UITableViewCell {

  @IBOutlet weak var birtDay: UILabel!
  @IBOutlet weak var nickname: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

  
  
  func listTableViewCell( nikcname:String , birtDay: Int){
//    imageViewDoctor.image = photo
    nickname.text = nikcname
//    birtDay.text = birtDay
//  
   
}
}
