//
//  Card.swift
//  Virtual Rolodex
//
//  Created by Jamie Nguyen on 2/6/18.
//  Copyright © 2018 Jamie Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct Card {
    var lastName: String!
    var firstName: String!
    var email: String!
    var company: String!
    var startDate: String!
    var bio: String!
    var avatar: String!
    
    static func loadCards() {
        if let path = Bundle.main.path(forResource: "CardData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: AnyObject]] {
                    var cards = [Card]()
                
                    for cardData in jsonResult {
                        cards.append(Card(dictionary: cardData))
                    }
                    Model.sharedInstance = cards
                }
            } catch {
                // handle error
                print("Error loading Json data")
            }
        }
    }
    
    // MARK: Initializers
    
    // construct a Card from a dictionary
    init(dictionary: [String:AnyObject]) {
        lastName = dictionary["lastName"] as? String
        firstName = dictionary["firstName"] as? String
        email = dictionary["email"] as? String
        company = dictionary["company"] as? String
        startDate = dictionary["startDate"] as? String
        bio = dictionary["bio"] as? String
        avatar = dictionary["avatar"] as? String
      
    }
   
    func downloadImage( imagePath:String, completionHandler: @escaping (_ imageData: Data?, _ errorString: String?) -> Void) -> URLSessionDataTask {
        let session = URLSession.shared
        let imgURL = NSURL(string: imagePath)
        let request: NSURLRequest = NSURLRequest(url: imgURL! as URL)
        
        let task = session.dataTask(with: request as URLRequest) {data, response, downloadError in
            if data == nil {
                completionHandler(nil, "Could not download image \(imagePath)")
            } else {
                completionHandler(data, nil)
            }
        }
        
        task.resume()
        return task
    }
}
