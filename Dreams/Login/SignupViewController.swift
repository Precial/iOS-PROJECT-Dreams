//
//  SignupViewController.swift
//  Dreams
//
//  Created by 장성구 on 2020/07/06.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func cancleBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
