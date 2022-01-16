//
//  listTableViewCell.swift
//  catchBullying
//
//  Created by apple on 24/05/1443 AH.
//

import UIKit

class DoctorsListCell: UITableViewCell {

  // MARK: - IBOutlets
  @IBOutlet weak var imageViewDoctor: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!  
  @IBOutlet weak var zoomLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   

    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  // MARK: - Methods
  func listTableViewCell( name:String , email : String , zoom : String 
  ){
//    imageViewDoctor.image = photo
    nameLabel.text = name
    emailLabel.text = email
    zoomLabel.text = zoom
  }
  
  

}
