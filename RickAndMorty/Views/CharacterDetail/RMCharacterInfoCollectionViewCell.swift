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
    
    private let valueLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .light)
        label.text = "Earth"
        return label
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Location"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .orange
        label.font = .systemFont(ofSize: 19, weight: .medium)
        return label
    }()
    
    private let iconImage: UIImageView = {
       let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(systemName: "globe.asia.australia")
        return icon
    }()
    private let titleContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.33),
  
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            iconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            iconImage.widthAnchor.constraint(equalToConstant: 60),
            iconImage.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            valueLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 12),
            valueLabel.heightAnchor.constraint(equalToConstant: 20)
            
            
        ])
    }
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.addSubview(iconImage)
        contentView.addSubview(valueLabel)
        contentView.addSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        valueLabel.center = iconImage.center
          setUpConstraints()
        
        
    }
        required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImage.image = nil
        titleLabel.text = nil
       valueLabel.text = nil
        
    }
 }
