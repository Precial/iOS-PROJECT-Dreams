//
//  ViewController.swift
//  Dreams
//
//  Created by 장성구 on 2020/07/06.
//  Copyright © 2020 com.sg. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class ViewController: UIViewController {

    
    @IBOutlet weak var userEMAIL: UITextField!
    @IBOutlet weak var userPW: UITextField!
    @IBOutlet weak var bgEMAIL: UILabel!
    @IBOutlet weak var bgPW: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* 구글로그인 연동 컨트롤러 연결을해당 현재 컨트롤로 값으로 부여 */
        GIDSignIn.sharedInstance()?.presentingViewController = self
            
        
        userEMAIL.attributedPlaceholder = NSAttributedString(string: "이메일을 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        userPW.attributedPlaceholder = NSAttributedString(string: "비밀번호를 입력하세요.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        self.bgEMAIL.layer.borderWidth = 1.0
        self.bgEMAIL.layer.borderColor = UIColor.white.cgColor
       // self.bgEMAIL.layer.cornerRadius = 15
        
      
        self.bgPW.layer.borderWidth = 1.0
        self.bgPW.layer.borderColor = UIColor.white.cgColor
       // self.bgPW.layer.cornerRadius = 15
        
        
        /*
         [로그인 핸들러]
         로그인 상태가 변경 되면 다음 화면으로 이동.
         */
        Auth.auth().addStateDidChangeListener { (auth, user) in
        if let user = user {
        self.performSegue(withIdentifier: "login", sender: self) // 현재 사용자가 로그인 된 상태가 맞다면 다음 화면으로 이동
                }
        }
        
/* 데이터 베이스 생성 코드 */
//                Database.database().reference().child("agree").child("DefaultAgree").child("title").setValue("test", withCompletionBlock: { (err,ref) in
//
//                        if(err==nil) {
//
//                        }
//
//                    })
//
        
        
        
    }
    
    
    /* 키보드창 내리기 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
               self.view.endEditing(true)
    }
    
    /* 로그인 화면으로 다시 되돌아 왔을 때 */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        try! Auth.auth().signOut()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true // 다시 초기화면으로 돌아 왔을때 네이게이션 바 제거
        try! Auth.auth().signOut()
    }


    @IBAction func googleLoginBtn(_ sender: Any) {
           GIDSignIn.sharedInstance().signIn() // 구글 로그인 불러오기
    }
    
    @IBAction func facebookLoginBtn(_ sender: Any) {
        facebookLogin()
    }
    
    
        func facebookLogin(){
            let fbLoginManager: LoginManager = LoginManager()
            fbLoginManager.logIn(permissions: ["email"], from: self){
                (result,error) -> Void in
                
                if error != nil {
                    print("Process error")
                }
                
                else if result?.isCancelled == true {
                    print("Cancelled")
                }
                
                else {
                    print("Logged in")
                    self.getFBUserData()
                }
                
            }
        }
        
        func getFBUserData(){
            if((AccessToken.current) != nil) {
                GraphRequest(graphPath:"me",parameters:["fields":"id,name,first_name,last_name,picture.type(large),email"]).start(completionHandler:{ (connection,result,error) -> Void in
                    if(error == nil){
                  
                }
            })
        }
        
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with:credential,completion:{(user,error) in })
            LoginManager().logOut();
        
    }
    
    
    
    @IBAction func loginBtn(_ sender: Any) {
         loginEvent()
    }
    
    
    
    func loginEvent(){
       /* 테스트 모드 */
            // self.performSegue(withIdentifier: "loginNext", sender: self)
            
            
        
            /* 상용모드 */
            Auth.auth().signIn(withEmail: userEMAIL.text!, password: userPW.text!){ // 입력한 ID,PW로 로그인 인증하는 부분
                (user, error) in if user != nil {
                    print("로그인 성공")
                    // 로그인시 ID,PW 입력창 초기화
                    self.userEMAIL.text!=""
                    self.userEMAIL.text!=""
                } else {
                    print("로그인 불가")
                    self.loginFailMessage() // 로그인 실패시 에러 알림창 출력 함수 호출
                }
            }
    }

    /* 로그인 실패시 알람창 띄우는 함수 */
    func loginFailMessage() {
         let message = "아이디/ 비밀번호가 맞지 않습니다."
         let alert = UIAlertController(title: "로그인 실패", message: message, preferredStyle:.alert)
         let action = UIAlertAction(title: "확인", style: .default, handler: nil)
         alert.addAction(action)
         present(alert,animated: true, completion: nil)
     }
    
    
}

