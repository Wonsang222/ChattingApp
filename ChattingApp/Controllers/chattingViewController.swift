//
//  chattingViewController.swift
//  ChattingApp
//
//  Created by 황원상 on 2022/07/11.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore


class chattingViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var array:[Message] = []
    
    
    private let tableView = UITableView()
    
    let tf:UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.returnKeyType = .done
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.textColor = .black
        tf.text = "well it is just start"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    let sendButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.setTitle("SEND", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stack:UIStackView = {
        let st = UIStackView(arrangedSubviews: [tf, sendButton])
        st.spacing = 5
        st.axis = .horizontal
        st.distribution = .fill
        st.alignment = .top
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        makeUI()
        tableView.addSubview(stack)
        tableView.rowHeight = 50
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        loadmessages()
    }
    
    @objc private func sendButtonTapped(){
        if let messageBody = tf.text, let sender = Auth.auth().currentUser?.email{
            db.collection(Constants.Fstore.collectionName).addDocument(data: [Constants.Fstore.senderField : sender, Constants.Fstore.bodyField:messageBody, Constants.Fstore.dateField : Date().timeIntervalSince1970]) { error in
                if let e = error{
                    print(e.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.tf.text = ""
                }
                
                }
            }
        }
    
    private func setupTableView(){
        tableView.register(chattingTableViewCell.self, forCellReuseIdentifier: Constants.tableView.reusablecell)
        tableView.dataSource = self
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        view.backgroundColor = .white
        
    }
    
    private func makeUI() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        title = "Have a nice conversation😊"
    }
    
    private func loadmessages(){
     
        db.collection(Constants.Fstore.collectionName)
                .order(by: Constants.Fstore.dateField)
            .addSnapshotListener { querySnapshot, error in
            if let e = error{
                print(e.localizedDescription)
            }else{
                self.array = []
                if let querydocument = querySnapshot?.documents{
                    for i in querydocument{
                        let data = i.data()
                        if let sender = data[Constants.Fstore.senderField] as? String, let messageBody = data[Constants.Fstore.bodyField] as? String{
                            let newMessage = Message(sender: sender, message: messageBody)
                            self.array.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.array.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                            
                        }
                    }
                }
            }
            
        }
        
    }
    
    
    override func updateViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            
            sendButton.topAnchor.constraint(equalTo: stack.topAnchor),
            sendButton.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            sendButton.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 50),
            
            tf.topAnchor.constraint(equalTo: stack.topAnchor),
            tf.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            tf.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            tf.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30),
            
            
            stack.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        super.updateViewConstraints()
    }
    
}

extension chattingViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = array[indexPath.row]
    
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableView.reusablecell, for: indexPath) as! chattingTableViewCell
        
        if message.sender == Auth.auth().currentUser?.email{
            cell.meImage.isHidden = false
            cell.youImage.isHidden = true
        }else{
            cell.meImage.isHidden = true
            cell.youImage.isHidden = false
            cell.message.backgroundColor = .darkGray
        }
        
        cell.message.text = array[indexPath.row].message
 
        return cell
    }
}

