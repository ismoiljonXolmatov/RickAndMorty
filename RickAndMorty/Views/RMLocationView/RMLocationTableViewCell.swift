//
//  RMLocationTableViewCell.swift
//  RickAndMorty
//
//  Created by Apple on 27.07.1444 (AH).
//

import UIKit

class RMLocationTableViewCell: UITableViewCell {
    
    private let namelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typelabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 19, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dimensionlabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let identifier = "RMLocationTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(namelabel)
        contentView.addSubview(typelabel)
        contentView.addSubview(dimensionlabel)
        accessoryType = .disclosureIndicator
        addConstraints()

    }
    
    private func  addConstraints() {
        NSLayoutConstraint.activate([
            namelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            namelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            namelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            typelabel.topAnchor.constraint(equalTo: namelabel.bottomAnchor, constant: 10),
            typelabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            typelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            dimensionlabel.topAnchor.constraint(equalTo: typelabel.bottomAnchor, constant: 10),
            dimensionlabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dimensionlabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dimensionlabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        namelabel.text = nil
        typelabel.text = nil
        dimensionlabel.text = nil
    }
    
    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
        namelabel.text = viewModel.name
        typelabel.text = viewModel.type
        dimensionlabel.text = viewModel.dimention

    }
    
  
}
