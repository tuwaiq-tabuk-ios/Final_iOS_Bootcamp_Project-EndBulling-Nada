//
//  InformationCell.swift
//  catchBullying
//
//  Created by apple on 29/05/1443 AH.
//

import UIKit

class InformationCell: UITableViewCell {
  
  var cellType: CellType
  var label: UILabel = {
    let lbl = UILabel()
    lbl.font = lbl.font.withSize(10)
    return lbl
  }()
  var textField: UITextField!
  var stepper: UIStepper!
  var textArea: UITextView!
  var validationImageView: UIImageView = {
    let view = UIImageView()
    return view
  }()
  
  init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, cellType: CellType) {
    self.cellType = cellType
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    //self.isUserInteractionEnabled = true
    
    addSubview(label)
    if cellType == .textArea {
      label.anchor(top: topAnchor, leading: leadingAnchor, widthConstant: 100, heightConstant: 20,
                                 padding: .init(top: 10, left: 10, bottom: 0, right: 0))
    } else {
      label.anchor(leading: leadingAnchor, centerY: centerYAnchor, height: heightAnchor, widthConstant: 100,
                                 padding: .init(top: 0, left: 10, bottom: 0, right: 0))
    }
    
    
    addSubview(validationImageView)
    validationImageView.image = UIImage(systemName: "questionmark")
    validationImageView.anchor(trailing: trailingAnchor, centerY: centerYAnchor, widthConstant: 25, heightConstant: 25,
                               padding: .init(top: 0, left: 0, bottom: 0, right: 10))
    
    if cellType == .textField {
      textField = UITextField()
      addSubview(textField)
      textField.anchor(top: topAnchor, leading: label.trailingAnchor, bottom: bottomAnchor, trailing: validationImageView.leadingAnchor,
                       padding: .init(top: 5, left: 10, bottom: 5, right: 10))
    } else if cellType == .stepper {
      stepper = UIStepper()
      //stepper.isUserInteractionEnabled = true
      stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
      addSubview(stepper)
      stepper.anchor(leading: label.trailingAnchor, trailing: validationImageView.leadingAnchor, centerY: centerYAnchor,
                       padding: .init(top: 5, left: 10, bottom: 5, right: 10))
    } else if cellType == .textArea {
      textArea = UITextView()
      addSubview(textArea)
      textArea.anchor(top: topAnchor, leading: label.trailingAnchor, bottom: bottomAnchor, trailing: validationImageView.leadingAnchor,
                       padding: .init(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    
    
  }
  
  @objc func stepperValueChanged(_ stepper: UIStepper) {
      print("Chnaged Value: \(stepper.value)")
      //stepper.value += 2
      print("Chnaged Value: \(stepper.value)")
      
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
