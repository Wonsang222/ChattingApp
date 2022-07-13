//
//  chattingTableViewCell.swift
//  ChattingApp
//
//  Created by 황원상 on 2022/07/11.
//

import UIKit

class chattingTableViewCell: UITableViewCell {
    
    let meImage:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let youImage:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let message:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10)
        label.backgroundColor = .systemBlue
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stack:UIStackView = {
        let st = UIStackView(arrangedSubviews: [meImage, message, youImage])
        st.axis = .horizontal
        st.spacing = 5
        st.distribution = .fill
        st.alignment = .fill
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(stack)
        updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            
            meImage.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            meImage.widthAnchor.constraint(equalToConstant: 30),
            
            youImage.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            youImage.widthAnchor.constraint(equalToConstant: 30),
            
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        super.updateConstraints()
    }
}
