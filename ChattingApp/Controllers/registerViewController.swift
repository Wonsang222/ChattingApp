//
//  registerViewController.swift
//  ChattingApp
//
//  Created by 황원상 on 2022/07/08.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class registerViewController: UIViewController {
    
    let register = registerView()
    
    override func loadView() {
        view = register
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        setupRegisterButton()
        register.idTextField.delegate = self
        register.passwordTextField.delegate = self

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
    
    func setupRegisterButton(){
        register.registerButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
}

extension registerViewController:UITextFieldDelegate{
    @objc func signupButtonTapped(){
        if let email = register.idTextField.text,
           let password = register.passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e)  // 얼럿창 띄우기로 변환
                }else{
                    let next = chattingViewController()
                    self.navigationController?.pushViewController(next, animated: true)
                }
            }
        }

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        register.idTextField.endEditing(true)
        register.passwordTextField.endEditing(true)
        let next = chattingViewController()
        self.navigationController?.pushViewController(next, animated: true)
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
