//
//  RMLoctionDetailViewViewController.swift
//  RickAndMorty
//
//  Created by Apple on 17.08.1444 (AH).
//

import UIKit

class RMLocationDetailViewController: UIViewController, RMLocationDetailViewModelDelegate, RMLocationDetailViewDelegate {
    
     private let viewModel: RMLocationDetailViewViewModel

    private let detailView = RMLocationDetailView()
    
    // MARK: - Init
    init(location: RMLocation) {
        let url = URL(string: location.url)
        self.viewModel = RMLocationDetailViewViewModel(endPointURL: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifescyle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        detailView.delegate = self
        view.backgroundColor = .systemBackground
        title = "Location"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        viewModel.delegate = self
        viewModel.fetchLocationData()
        configureConstraints()

    }
    @objc
    private func didTapShare() {
        
    }
    
    private func configureConstraints() {
    NSLayoutConstraint.activate([
        detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor ),
    ])


        }
    
    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
    
     
    func rmEpisodeDetailView(_ detailView: RMLocationDetailView, didselect character: RMCharacter) {
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
   
    

}

