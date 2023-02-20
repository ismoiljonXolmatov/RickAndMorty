//
//  RMLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Apple on 27.07.1444 (AH).
//

import UIKit

class RMLocationTableViewCell: UITableViewCell {
    
    static let identifier = "RMLocationTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
    }
    
  
}
