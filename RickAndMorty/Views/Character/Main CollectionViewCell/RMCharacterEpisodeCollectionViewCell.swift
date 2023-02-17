//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Apple on 18.07.1444 (AH).
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "RMCharacterEpisodeCollectionViewCell"
    
    private let SeasonLb: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()
    private let nameLb: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .secondaryLabel

        return label
    }()
    private let airDateLb: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = .secondaryLabel

        return label
    }()

 
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            SeasonLb.topAnchor.constraint(equalTo: contentView.topAnchor),
            SeasonLb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            SeasonLb.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            SeasonLb.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            nameLb.topAnchor.constraint(equalTo: SeasonLb.bottomAnchor),
            nameLb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLb.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            nameLb.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            airDateLb.topAnchor.constraint(equalTo: nameLb.bottomAnchor),
            airDateLb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            airDateLb.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
            airDateLb.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),

            
        ])
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        addSubViews()
        setUpLayer()
        setUpConstraints()
    }
    
    private func addSubViews() {
        contentView.addSubview(nameLb)
        contentView.addSubview(SeasonLb)
        contentView.addSubview(airDateLb)
   
    }
    
    private func setUpLayer() {
        contentView.layer.borderWidth = 2
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.4
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLb.text = nil
        SeasonLb.text = nil
        airDateLb.text = nil

    }
    
    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] date in
            self?.nameLb.text = date.name
            self?.SeasonLb.text = "Episode "+date.episode
            self?.airDateLb.text = "Aired on "+date.air_date
            
           }
        viewModel.fetchEpisode()
        contentView.layer.borderColor = viewModel.borderColor.cgColor

        
    }
    

}
