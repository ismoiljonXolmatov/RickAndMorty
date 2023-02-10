//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Apple on 18.07.1444 (AH).
//
import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    
    static let indentifier: String = "RMCharacterInfoCollectionViewCell"
    
     
    private let valueLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .light)
        return label
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
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
        return icon
    }()
    private let titleContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.33),
  
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            iconImage.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor),
            iconImage.widthAnchor.constraint(equalToConstant: 30),
            iconImage.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            valueLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 5),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor)
            
            
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
        iconImage.tintColor = .label
        titleLabel.textColor = .label
 
        
    }
    
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconImage.image = viewModel.iconImage
        iconImage.tintColor = viewModel.tintColor
        titleLabel.textColor = viewModel.tintColor
        
        
    }
  }
 
