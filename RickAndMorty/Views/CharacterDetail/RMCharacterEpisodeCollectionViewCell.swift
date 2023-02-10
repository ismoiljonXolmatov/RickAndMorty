//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Apple on 18.07.1444 (AH).
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    static let indentifier: String = "RMCharacterEpisodeCollectionViewCell"
    
    private let SeasonLb: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    private let nameLb: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    private let airDateLb: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()

    public func configure(with viewModel: RMCharacterEpisodeCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] date in
            self?.nameLb.text = date.name
            self?.SeasonLb.text = "Episode "+date.episode
            self?.airDateLb.text = "Aired on "+date.air_date

            
           }
        viewModel.fetchEpisode() 
    }
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
        ])
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .systemBackground
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 8
        contentView.addSubview(nameLb)
        contentView.addSubview(SeasonLb)
        contentView.addSubview(airDateLb)
        setUPContentView()
        setUpConstraints()
        

    }
    private func setUPContentView() {
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

}
