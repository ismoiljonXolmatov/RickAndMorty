//
//  RMNoSearchReslutsView.swift
//  RickAndMorty
//
//  Created by Apple on 30.07.1444 (AH).
//

import UIKit

class RMNoSearchReslutsView: UIView {
    
    private let viewModel = RMNoSearchReslutsViewViewModel()
    
    private let iconView: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .systemGray
        return icon
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        isHidden = true
        addSubview(label)
        configure()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 100),
            iconView.heightAnchor.constraint(equalToConstant: 100),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
             label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
        ])
        
    }
    private func configure() {
        iconView.image = viewModel.image
        label.text = viewModel.title
        
    }
 
}
