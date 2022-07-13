//
//  ViewController.swift
//  ChattingApp
//
//  Created by 황원상 on 2022/07/08.
//

import UIKit

class ViewController: UIViewController {
    
    let first = firstView()
    
    override func loadView() {
        view = first
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        setupButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func setupButton(){
        first.logButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        first.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped(){
        let next = loginViewController()
        navigationController?.pushViewController(next, animated: true)
    }
    
    @objc func registerButtonTapped(){
        let next = registerViewController()
        navigationController?.pushViewController(next, animated: true)
    }
    
    func makeUI() {
        let appearance = UINavigationBarAppearance()
              appearance.configureWithOpaqueBackground()  // 불투명으로
              //appearance.backgroundColor = .brown     // 색상설정
              
              //appearance.configureWithTransparentBackground()  // 투명으로
              
              navigationController?.navigationBar.tintColor = .blue
              navigationController?.navigationBar.standardAppearance = appearance
              navigationController?.navigationBar.compactAppearance = appearance
              navigationController?.navigationBar.scrollEdgeAppearance = appearance
              title = "Main"
        }
}

