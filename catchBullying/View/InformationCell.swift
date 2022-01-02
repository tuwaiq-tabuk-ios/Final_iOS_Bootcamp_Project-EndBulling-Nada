//
//  InformationCell.swift
//  catchBullying
//
//  Created by apple on 29/05/1443 AH.
//

import UIKit

class InformationCell: UITableViewCell {
  
  var textField = UITextField()
  var validationImageView: UIImageView = {
    let view = UIImageView()
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(textField)
    addSubview(validationImageView)
    
    validationImageView.image = UIImage(systemName: "questionmark")
    validationImageView.anchor(trailing: trailingAnchor, centerY: centerYAnchor, widthConstant: 50, heightConstant: 50,
                               padding: .init(top: 0, left: 0, bottom: 0, right: 10))
    textField.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: validationImageView.leadingAnchor,
                     padding: .init(top: 5, left: 10, bottom: 5, right: 10))
      }

      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
  
}
