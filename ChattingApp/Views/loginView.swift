//
//  loginView.swift
//  ChattingApp
//
//  Created by 황원상 on 2022/07/08.
//

import UIKit

class loginView: UIView {
    
    let idTextField:UITextField = {
       let tf = UITextField()
        tf.placeholder = "ID"
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .always
        tf.returnKeyType = .go
        tf.textColor = .black
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.autocapitalizationType = .none
        tf.text = "wonsang222@naver.com"
        return tf
    }()
    
    let passwordTextField:UITextField = {
       let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .always
        tf.returnKeyType = .go
        tf.textColor = .black
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.autocapitalizationType = .none
        tf.text = "A1s1d1f1!!"
        return tf
    }()
    
    let signinButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stack:UIStackView = {
       let st = UIStackView(arrangedSubviews: [idTextField, passwordTextField])
        st.spacing = 10
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stack)
        self.addSubview(signinButton)
        self.backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
        stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        stack.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -30),
        
        signinButton.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 20),
        signinButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        super.updateConstraints()
    }
}



