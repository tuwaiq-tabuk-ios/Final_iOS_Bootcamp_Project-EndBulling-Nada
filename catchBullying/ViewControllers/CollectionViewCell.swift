//
//  CollectionViewCell.swift
//  catchBullying
//
//  Created by apple on 19/05/1443 AH.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var slideIamgeView: UIImageView!
  @IBOutlet weak var slideTitleLbl: UILabel!
  @IBOutlet weak var slideDescriptionLbl: UILabel!
  
  func setup(_ slide : PageOnboarding ){
    
    slideIamgeView.image = slide.image
    slideTitleLbl.text = slide.title
    slideDescriptionLbl.text = slide.description
    
    
  }
  
  
}
