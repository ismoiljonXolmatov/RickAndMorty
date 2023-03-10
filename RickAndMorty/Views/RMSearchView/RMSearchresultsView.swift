//
//  RMSearchresultsView.swift
//  RickAndMorty
//
//  Created by Apple on 14.08.1444 (AH).
//

import UIKit


protocol RMSearchresultsViewDelegate: AnyObject {
    func rmSearchresultsView(_ searchResultView: RMSearchresultsView, didtapLocationAt index: Int)
}

class RMSearchresultsView: UIView {
    
    public weak var delegate: RMSearchresultsViewDelegate?
    
    private var viewModel: RMSearchResultViewViewModel? {
        didSet {
            self.prossesViewModel()
        }
    }
    
    private var collectionViewCellViewModels: [any Hashable] = []
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        return tableView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMCharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier:  RMCharacterCollectionViewCell.identifier)
        collectionView.register(RMFootLoadCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: RMFootLoadCollectionReusableView.identifier)
        collectionView.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.identifier)
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()
    
    
    private var locationCellViewModel: [RMLocationTableViewCellViewModel] = []
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        addSubview(collectionView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
        
    }
    public func configure(with viewModel: RMSearchResultViewViewModel) {
        self.viewModel = viewModel
        
    }
    
    private func prossesViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        switch viewModel {
        case .characters(let viewModels):
            self.collectionViewCellViewModels = viewModels
            setUpCollectionView()
        case .episode(let viewModels):
            setUpCollectionView()
            self.collectionViewCellViewModels = viewModels
        case .locations(let viewModels):
            setUpTableView(viewModels: viewModels)
        }
        
    }
    private func setUpCollectionView() {
        
        self.tableView.isHidden = true
        self.collectionView.isHidden = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
          
        
    }
    
    private func setUpTableView(viewModels: [RMLocationTableViewCellViewModel]) {
        tableView.isHidden = false
        self.collectionView.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        self.locationCellViewModel = viewModels
        tableView.reloadData()
        print(viewModels)
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
            
            
            
        ])
     }
}

// MARK: - TableView
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
        delegate?.rmSearchresultsView(self, didtapLocationAt: indexPath.row)
    }
}

  // MARK: - ColectionView
extension RMSearchresultsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellViewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentViewModel = collectionViewCellViewModels[indexPath.row]
        if let characterVM = currentViewModel as? RMCharacterCollectionViewCellViewModel {
            // Character cell
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterCollectionViewCell.identifier,
                for: indexPath) as? RMCharacterCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: characterVM)
            return cell
            
        }
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.identifier,
            for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
            fatalError()
        }
        if let episodeVM = currentViewModel as? RMCharacterEpisodeCollectionViewCellViewModel {
            cell.configure(with: episodeVM)
        }
        // Episode cell
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentviewModel = collectionViewCellViewModels[indexPath.row]
        let bounds = collectionView.bounds
        if currentviewModel is RMCharacterCollectionViewCellViewModel {
            // Character cell
            let width = (bounds.width - 30)/2
            return CGSize(width: width, height: width*1.4)
            
        }
        // Episode cell
        let width = (bounds.width - 20)
        return CGSize(width: width, height: 120)
    }
    
    
}
