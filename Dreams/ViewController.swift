//
//  ViewController.swift
//  Dreams
//
//  Created by 장성구 on 2020/07/06.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userEMAIL: UITextField!
    @IBOutlet weak var userPW: UITextField!
    @IBOutlet weak var bgEMAIL: UILabel!
    @IBOutlet weak var bgPW: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEMAIL.attributedPlaceholder = NSAttributedString(string: "이메일을 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        userPW.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        self.bgEMAIL.layer.borderWidth = 1.0
        self.bgEMAIL.layer.borderColor = UIColor.white.cgColor
       // self.bgEMAIL.layer.cornerRadius = 15
        
      
        self.bgPW.layer.borderWidth = 1.0
        self.bgPW.layer.borderColor = UIColor.white.cgColor
       // self.bgPW.layer.cornerRadius = 15
        
    }
    
    
    /* 키보드창 내리기 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
               self.view.endEditing(true)
    }


    @IBAction func loginBtn(_ sender: Any) {
         self.performSegue(withIdentifier: "loginNext", sender: self)
    }
}

