//
//  RMFootLoadCollectionReusableView.swift
//  RickAndMorty
//
//  Created by Apple on 12.07.1444 (AH).
//

import UIKit

class RMFootLoadCollectionReusableView:  UICollectionReusableView {
    static let indentifier = "RMFootLoadCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
           addSubview(spinner)
        backgroundColor = .systemBackground
        startAnimating()
        addConstraints()
  
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

    }
    
    public func startAnimating() {
        spinner.startAnimating()
        
    }
    
}
