//
//  EpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Apple on 20.07.1444 (AH).
//

import UIKit
/// VC for to show episode single episode
class EpisodeDetailViewController: UIViewController, RMEpisodeDetailViewModelDelegate {
    
    
    private let viewModel: RMEpisodeDetailViewViewModel

    private let detailView = RMEpisodeDetailView()
    
    // MARK: - Init
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(endPointURL: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifescyle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        view.backgroundColor = .systemBackground
        title = "Episode"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
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
    func didFetchepisodeDetails() {
        detailView.configure(with: viewModel) 
    }


}
