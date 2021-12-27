//
//  OnboardingViewController.swift
//  catchBullying
//
//  Created by apple on 19/05/1443 AH.
//

import UIKit

class OnboardingViewController: UIViewController {
  let defaults = UserDefaults.standard
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var pageController: UIPageControl!
  
  var arrayOfPages : [PageOnboarding] = []
  
  var currentPage = 0 {
    didSet {
      pageController.currentPage = currentPage
      if currentPage == arrayOfPages.count - 1 {
        nextButton.setTitle("Get Started", for: .normal)
      }else{
        nextButton.setTitle("Next", for: .normal)
      }
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if defaults.bool(forKey: "launched") {
      print("Not First run")
      let controller = self.storyboard?.instantiateViewController(identifier: "MainVC") as! UINavigationController
      controller.modalPresentationStyle = .fullScreen
      controller.modalTransitionStyle = .flipHorizontal
      //UserDefaults.standard.hasOnboarded = true
      self.present(controller, animated: false, completion: nil)
    } else {
      print("first run")
      defaults.set(true, forKey: "launched")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    arrayOfPages = [ PageOnboarding(title: "EndBullying...", description: "A social application that helps you to get rid of the psychological effects of bullying ", image: UIImage(named: "Image")!) ,
                     
                     PageOnboarding(title: "end", description: "You can communicate with an experienced psychologist in complete confidentiality without disclosing your personal information", image: UIImage(named: "Image")!) ,
                     
                     PageOnboarding(title: "why", description: "You can communicate with an experienced psychologist in complete confidentiality without disclosing your personal information", image: UIImage(named: "Image")!)
                     
    ]
    
    pageController.numberOfPages = arrayOfPages.count
    
    
  }
  
  
  @IBAction func nextBtnCliked(_ sender: Any) {
    if currentPage == arrayOfPages.count - 1 {
      let controller = storyboard?.instantiateViewController(identifier: "MainVC") as! UINavigationController
      controller.modalPresentationStyle = .fullScreen
      controller.modalTransitionStyle = .flipHorizontal
      //UserDefaults.standard.hasOnboarded = true
      present(controller, animated: true, completion: nil)
    } else {
      currentPage += 1
      let indexPath = IndexPath(item: currentPage, section: 0)
      collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
  }
  
}

extension OnboardingViewController : UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayOfPages.count
    
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!CollectionViewCell
    cell.setup(arrayOfPages[indexPath.row])
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width, height: 600)
    //return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let width = scrollView.frame.width
    currentPage = Int(scrollView.contentOffset.x / width)
  }
  
}
