//
//  ViewController.swift
//  MyApp
//
//  Created by Deniz Gelir on 12/4/18.
//  Copyright © 2018 Deniz Gelir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func loginPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "goToHome", sender: self)
        
    }
    
    
    
}

