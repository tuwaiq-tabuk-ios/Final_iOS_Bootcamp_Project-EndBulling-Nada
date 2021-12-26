//
//  PsicologistQuestionsViewController.swift
//  catchBullying
//
//  Created by apple on 11/05/1443 AH.
//

import UIKit

class PsicologistQuestionsViewController: UIViewController {
  var currentQuestionIndex: Int = 0
  var noCorrect = 0
  
  let arryPsicologistQuestions : [PsicologistQuestions] = [
    PsicologistQuestions(question: "Gender", answers:["Male" , "Female" ,"Other"]),
    PsicologistQuestions(question: "Do you currentiy have a job?", answers:["yes" , "No" ,"prefer not answer"]),
  PsicologistQuestions(question: "Have you taken a psychiatric medication befor?", answers: ["yes" , "No" ,"prefer not answer"]),
  PsicologistQuestions(question: "Does your family have a history of psychiatrist counseling?", answers: ["yes" , "No" ,"prefer not answer"]),
  PsicologistQuestions(question: "Were you subjected to domestic violence (verbal , psychological, physical, sexual , negligence ...)?", answers: ["yes" , "No" ,"prefer not answer"]),
  PsicologistQuestions(question: "Do you think of hurting yourself or have suicidal thoughts ?", answers: ["yes" , "No" ,"prefer not answer"]),
  PsicologistQuestions(question: "Do you plan on committing suicide ??", answers: ["yes" , "No" ,"prefer not answer"])
  
  ]
  
  
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!
  @IBOutlet weak var otherButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
      questionLabel.text=arryPsicologistQuestions[currentQuestionIndex].question
      configureButtons()
    }
  
   
  @IBAction func nextButton(_ sender: Any) {
    let vc = storyboard?.instantiateViewController(withIdentifier: "loginuser")
    navigationController?.pushViewController(vc!, animated: true)
  
  
}
 
  
  @IBAction func answuer(_ sender: Any) {
  }
  
  
  
  
  func configureButtons() {
    yesButton.layer.cornerRadius = 20
    yesButton.layer.borderWidth = 3
    yesButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
    
    noButton.layer.cornerRadius = 20
    noButton.layer.borderWidth = 3
    noButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
    
    otherButton.layer.cornerRadius = 20
    otherButton.layer.borderWidth = 3
    otherButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
    
    
  }
  

  
  
}
