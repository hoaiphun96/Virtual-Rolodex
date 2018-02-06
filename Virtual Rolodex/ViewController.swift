//
//  ViewController.swift
//  Virtual Rolodex
//
//  Created by Jamie Nguyen on 2/6/18.
//  Copyright © 2018 Jamie Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //load Data into Model
        Card.loadCards()
    }

    

}

