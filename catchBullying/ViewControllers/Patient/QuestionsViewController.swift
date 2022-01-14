//
//  PsicologistQuestionsViewController.swift
//  catchBullying
//
//  Created by apple on 11/05/1443 AH.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class QuestionsViewController: UIViewController {
  var current: Int = 0
  var answers: [Int] = []
  
  let questions: [PsicologistQuestionModel] = [
    PsicologistQuestionModel(question: "Gender",
                        answers:["Male" , "Female" ,"Other"]),
    PsicologistQuestionModel(question: "Do you currentiy have a job?",
                        answers:["Yes" , "No" ,"Prefer not answer"]),
    PsicologistQuestionModel(question: "Have you taken a psychiatric medication befor?",
                        answers: ["Yes" , "No" ,"Prefer not answer"]),
    PsicologistQuestionModel(question: "Does your family have a history of psychiatrist counseling?",
                        answers: ["Yes" , "No" ,"Prefer not answer"]),
    PsicologistQuestionModel(question: "Were you subjected to domestic violence (verbal , psychological, physical, sexual , negligence ...)?",
                        answers: ["Yes" , "No" ,"Prefer not answer"]),
    PsicologistQuestionModel(question: "Do you think of hurting yourself or have suicidal thoughts?",
                        answers: ["Yes" , "No" ,"Prefer not answer"]),
    PsicologistQuestionModel(question: "Do you plan on committing suicide?",
                        answers: ["Yes" , "No" ,"Prefer not answer"])
    
  ]
  
  @IBOutlet weak var questionLabel: UILabel!
  @IBOutlet weak var yesButton: UIButton!
  @IBOutlet weak var noButton: UIButton!
  @IBOutlet weak var otherButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    self.isModalInPresentation = true
    self.navigationItem.setHidesBackButton(true, animated: false)
    configureButtons()
    setupQuestion()

  }
  
  func setupQuestion() {
    questionLabel.text = NSLocalizedString(questions[current].question, comment: "")
    yesButton.setTitle(questions[current].answers[0], for: .normal)
    noButton.setTitle(questions[current].answers[1], for: .normal)
    otherButton.setTitle(questions[current].answers[2], for: .normal)

  }
  
  func nextQuestion() {
    if current < questions.count - 1 {
      current += 1
      setupQuestion()
    } else {
      if isUpdating {
        self.dismiss(animated: true, completion: nil)
      } else {
        patientProfile.answers = answers
        
        FirestoreRepository.update(collection: "patients",
                                   documentID: patientProfile.docID!,
                                   document: patientProfile) {
          let controller = self.storyboard?.instantiateViewController(identifier: "UserHomeVC") as! PatientHomeTabBarController
          controller.modalPresentationStyle = .fullScreen
          controller.modalTransitionStyle = .flipHorizontal
          self.present(controller, animated: false, completion: nil)
        }
      }
    }
  }
  
  
  @IBAction func nextButton(_ sender: Any) {
    answers.append(-1)
    nextQuestion()
  }
  
  
  @IBAction func answuer(_ sender: UIButton) {
    answers.append(sender.tag)
    nextQuestion()
  }
  
  
  
  
  func configureButtons() {
    yesButton.tag = 0
    yesButton.layer.cornerRadius = 20
    yesButton.layer.borderWidth = 3
    yesButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
    
    noButton.tag = 1
    noButton.layer.cornerRadius = 20
    noButton.layer.borderWidth = 3
    noButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
    
    otherButton.tag = 2
    otherButton.layer.cornerRadius = 20
    otherButton.layer.borderWidth = 3
    otherButton.layer.borderColor = CGColor(red: 225, green:255, blue: 255, alpha: 1)
  }
  
  
  
  
  
}
