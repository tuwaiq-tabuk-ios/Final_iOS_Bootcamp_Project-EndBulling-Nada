//
//  InformationCellModel.swift
//  catchBullying
//
//  Created by apple on 29/05/1443 AH.
//

import UIKit

enum CellType {
  case textField
  case stepper
  case textArea
}

struct InformationCellModel {
  var title: String
  var cellType: CellType
}
