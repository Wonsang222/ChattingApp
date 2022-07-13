//
//  loginViewController.swift
//  ChattingApp
//
//  Created by 황원상 on 2022/07/08.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class loginViewController: UIViewController {
    
    let login = loginView()
    
    override func loadView() {
        view = login
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        setupSigninButton()
        login.idTextField.delegate = self
        login.passwordTextField.delegate = self
        
    }
    
    func makeUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        title = "Sign In"
    }
    
    func setupSigninButton(){
        login.signinButton.addTarget(self, action: #selector(signinButtonTapped), for: .touchUpInside)
    }
}

extension loginViewController:UITextFieldDelegate{
    @objc func signinButtonTapped(){
        login.passwordTextField.endEditing(true)
        if let email = login.idTextField.text, let password = login.passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)  // 각종 에러별 분기 처리 요망!
                }else{
                    let next = chattingViewController()
                    self.navigationController?.pushViewController(next, animated: true)
                    print(authResult ?? "None")
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        login.idTextField.endEditing(true)
        login.passwordTextField.endEditing(true)
        //Firebase로 networking 시작
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            // 여기에 시작
            return true
        }else{
            textField.placeholder = "Type Something Plz"
            return false
        }
    }
}
