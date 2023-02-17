//
//  RMCharacterPhotoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Apple on 18.07.1444 (AH).
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    
    static let indentifier: String = "RMCharacterPhotoCollectionViewCell"
    
    private let CharacterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    public func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.CharacterImage.image = UIImage(data: data)
                }
            case .failure:
                break
            }
        }
        
    }
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            CharacterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            CharacterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            CharacterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            CharacterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(CharacterImage)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        CharacterImage.image = nil
    }
}
