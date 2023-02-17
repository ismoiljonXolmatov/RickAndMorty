//
//  RmEpisodeViewController.swift
//  RickAndMorty
//
//  Created by Apple on 07.07.1444 (AH).
//

import UIKit

///Controller to show and search Episode
final class RMEpisodeViewController: UIViewController, RMEpisodeListViewDelegate {
    
    
    private let episodeListView = RMEpisodeListView()
    override func viewDidLoad() {
        super.viewDidLoad()
       view.addSubview(episodeListView)
        episodeListView.delegate = self
        view.backgroundColor = .systemBackground
        title = "Episode"
        addSearchButton()
        setUpView()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    @objc
    private func didTapSearch() {
        let vc = RMSearchViewController(config: RMSearchViewController.Config(type: .episode))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationBar.topItem?.backButtonTitle = ""

    }
 
    
    private func setUpView() {
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            episodeListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            episodeListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
    }
    // MARK:  - RMEpisodeListViewDelegate
    
    func rmEpisodeListView(_ episodelistview: RMEpisodeListView, didSelectEpisode epsiode: RMEpisode) {
        let vc = EpisodeDetailViewController(url: URL(string: epsiode.url))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}




