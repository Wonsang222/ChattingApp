//
//  firstView.swift
//  ChattingApp
//
//  Created by 황원상 on 2022/07/08.
//

import UIKit

class firstView: UIView {
    
    
    let mainLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    let logButton:UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    let registerButton:UIButton = {
        let button = UIButton()
        button.setTitle("REGISTER", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    lazy var stack:UIStackView = {
        let st = UIStackView(arrangedSubviews: [logButton, registerButton])
        st.spacing = 5
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(mainLabel)
        self.addSubview(stack)
        self.backgroundColor = .white
        popupLabel()
    }
    
    func popupLabel(){
        let title = "Proto Chatting App❤️"
        var index = 1.0
        for i in title{
            Timer.scheduledTimer(withTimeInterval: 0.1 * index, repeats: false) { timer in
                self.mainLabel.text?.append(i)
            }
            index += 1.0
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            stack.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 50),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        super.updateConstraints()
    }
    
}
