//
//  RMSearchresultsView.swift
//  RickAndMorty
//
//  Created by Apple on 14.08.1444 (AH).
//

import UIKit

class RMSearchresultsView: UIView {
    
    private var viewModel: RMSearchResultViewViewModel? {
        didSet {
            self.prossesViewModel()
        }
    }
      
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        return tableView
    }()
    
    private var locationCellViewModel: [RMLocationTableViewCellViewModel] = []
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemIndigo
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
        
    }
    public func configure(with viewModel: RMSearchResultViewViewModel) {
        
    }
    
    private func prossesViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        switch viewModel {
        case .characters(let viewModels):
            setUpCollectionView()
        case .episode(let viewModels):
            setUpCollectionView()
        case .locations(let viewModels):
            setUpTableView(viewModels: viewModels)
        }
        
    }
    private func setUpCollectionView() {
        
    }
    
    private func setUpTableView(viewModels: [RMLocationTableViewCellViewModel]) {
        addSubview(tableView)
        tableView.backgroundColor = .systemGreen
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        tableView.delegate = self
        tableView.dataSource = self
        self.locationCellViewModel = viewModels
        tableView.reloadData()
        print(viewModels.count)
        
    }
    private func addConstraints() {
    }
}

extension RMSearchresultsView: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locationCellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationTableViewCell.identifier, for: indexPath) as? RMLocationTableViewCell else {
            fatalError(" failed to dequeu RMLocationTableViewCell")
        }
        cell.configure(with: locationCellViewModel[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

