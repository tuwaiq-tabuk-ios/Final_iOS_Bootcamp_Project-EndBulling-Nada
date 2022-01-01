//
//  PsicologistQuestionsViewController.swift
//  catchBullying
//
//  Created by apple on 11/05/1443 AH.
//

import UIKit

class QuestionsViewController: UIViewController {
  var currentQuestionIndex: Int = 0
  var answers: [String] = []
  
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
    configureButtons()
    questionLabel.text=arryPsicologistQuestions[currentQuestionIndex].question
  }
  
  func setupQuestion() {
    questionLabel.text = arryPsicologistQuestions[currentQuestionIndex].question
  }
  
  func nextQuestion() {
    print(answers)
    if currentQuestionIndex < arryPsicologistQuestions.count - 1 {
      currentQuestionIndex += 1
      setupQuestion()
    } else {
      print("dismiss")
      if isUpdating {
        self.dismiss(animated: true, completion: nil)
      } else {
        if user.isDoctor {
          let controller = self.storyboard?.instantiateViewController(identifier: "DoctorHomeVC") as! DoctorHomeViewController
          controller.modalPresentationStyle = .fullScreen
          controller.modalTransitionStyle = .flipHorizontal
          self.present(controller, animated: false, completion: nil)
        } else {
          let controller = self.storyboard?.instantiateViewController(identifier: "UserHomeVC") as! UserHomeViewController
          controller.modalPresentationStyle = .fullScreen
          controller.modalTransitionStyle = .flipHorizontal
          self.present(controller, animated: false, completion: nil)
        }
      }
      
      
    }
  }
  
  
  @IBAction func nextButton(_ sender: Any) {
    nextQuestion()
  }
  
  
  @IBAction func answuer(_ sender: UIButton) {
    answers.append(sender.titleLabel!.text!)
    nextQuestion()
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
