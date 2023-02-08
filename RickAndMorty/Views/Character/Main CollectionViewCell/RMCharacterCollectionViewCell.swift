//
//  RMCharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Apple on 10.07.1444 (AH).
//

import UIKit

class RMCharacterCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "RMCharacterCollectionViewCell"
    private let ImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        imageview.layer.cornerRadius = 8
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK:  -  Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(ImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        setUpShadow()
         addConstraints()
        }
    
    private func setUpShadow() {
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.4
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 8

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addConstraints() { NSLayoutConstraint.activate([
        ImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
        ImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ImageView.heightAnchor.constraint(equalToConstant: contentView.bounds.height/1.3),
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -5),
        nameLabel.heightAnchor.constraint(equalToConstant: 27),
        statusLabel.heightAnchor.constraint(equalToConstant: 27),
        statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
        statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
     ])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
         ImageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
      }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpShadow()
    }
    
    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self? .ImageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
        
    }
}

