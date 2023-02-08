//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Apple on 18.07.1444 (AH).
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    
    static let indentifier: String = "RMCharacterInfoCollectionViewCell"
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel ) {
        
    }
    private func setUpConstraints() {
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }

}
