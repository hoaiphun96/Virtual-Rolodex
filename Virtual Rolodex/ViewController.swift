//
//  ViewController.swift
//  Virtual Rolodex
//
//  Created by Jamie Nguyen on 2/6/18.
//  Copyright © 2018 Jamie Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!

    var currentCardIndex: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        //load Data into Model
        currentCardIndex = UserDefaults.standard.integer(forKey: "currentIndex")
        Card.loadCards()
  
        loadNewCard()
        setUpSwipeRecognizer()
    }
    
    func setUpSwipeRecognizer(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        view.addGestureRecognizer(swipeLeft)
        
    }
    
    @objc func swiped(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                // next card
                if currentCardIndex == 0 {
                    currentCardIndex = Model.sharedInstance.count - 1
                } else {
                    currentCardIndex = currentCardIndex - 1
                }
                print("prevcard")
            case UISwipeGestureRecognizerDirection.left:
                //prev card
                if currentCardIndex == Model.sharedInstance.count - 1 {
                    currentCardIndex = 0
                } else {
                    currentCardIndex = currentCardIndex + 1
                }
                print("nextcard")
                    
            default:
                break
        }
        UserDefaults.standard.set(currentCardIndex, forKey: "currentIndex")
        UserDefaults.standard.synchronize()
        loadNewCard()
        
    }
    
    func loadNewCard() {
        let newCard = Model.sharedInstance[currentCardIndex] as Card
        
        let _ = newCard.downloadImage(imagePath: (Model.sharedInstance[currentCardIndex] as Card).avatar, completionHandler: { [weak self] (data, errorString) in
            if errorString == nil {
                DispatchQueue.main.async {
                    self?.avatarImageView.image = UIImage(data: data!)
                    self?.nameLabel.text = newCard.firstName + " " + newCard.lastName
                    self?.infoLabel.text = "Email:\n\(newCard.email!)\n\nCompany:\n\(newCard.company!)\n\nStart Date:\n\(newCard.startDate!.prefix(10))\n\nBio:\n\(newCard.bio!)"
                }
            }
        })

       
    }

    

}

