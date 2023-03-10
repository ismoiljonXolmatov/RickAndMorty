//
//  RMEpisodeListViewViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 21.07.1444 (AH).
//

import UIKit

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didLoadMoreEpsides(with newIndexPaths: [IndexPath])
    func didEpisodeSelect(_ episode: RMEpisode)
}


/// ViewModel to handle episode list view logic
final class RMEpisodeListViewViewModel: NSObject {
    
    public weak var delegate: RMEpisodeListViewViewModelDelegate?
            
    private var  isLoadingMoreCharacter = false
    
    private let borderColors: [UIColor] = [
        .systemIndigo,
        .systemIndigo,
        .systemIndigo,
        .systemIndigo,
        .systemIndigo,
        .systemIndigo,
        .systemIndigo,
        .systemIndigo
    ]
    
    private var episodes: [RMEpisode] = [] {
        didSet {
            for episode in episodes  {
                let viewModel = RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: episode.url), bordercolor: borderColors.randomElement() ?? .systemIndigo)
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
            
        }
    }
    private var cellViewModels: [RMCharacterEpisodeCollectionViewCellViewModel] = []

    private var apiInfo: RMGetAllEpsiodesResponse.Info? = nil

    
        /// Fetch initial set of episode  (20)
    public func fetchREpisodes() {
        RMService.shared.exacute(.listEpisodesRequest, expecting: RMGetAllEpsiodesResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.episodes = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialEpisodes()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    //Faginate if additional episodes are needed
    public func fetchAdditionalEpisode(url: URL) {
        guard !isLoadingMoreCharacter else {
            return
        }
        isLoadingMoreCharacter = true
        guard let request = RMRequest(url: url) else {
            isLoadingMoreCharacter = false
            return
        }
        
        RMService.shared.exacute(
            request,
            expecting: RMGetAllEpsiodesResponse.self) { [weak self ] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let responseModel):
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.apiInfo = info
                    
                      
                    let originalCount = strongSelf.episodes.count
                    let newCount = moreResults.count
                    let total = originalCount+newCount
                    let startingindex = total-newCount
                    let indexPathToAdd: [IndexPath] = Array(startingindex..<(startingindex+newCount)).compactMap({
                        return IndexPath(row: $0, section: 0)
                    })
                    strongSelf.episodes.append(contentsOf: moreResults)
                    DispatchQueue.main.async {
                        strongSelf.delegate?.didLoadMoreEpsides(with: indexPathToAdd)

                    
                      strongSelf.isLoadingMoreCharacter = false
                    }
                case .failure(let failure):
                    print(String(describing: failure))
                    
                    strongSelf.isLoadingMoreCharacter = false


                }
            }

        // fetch episodes
    }
    
    public var shouldShowLoadMoreIndicators: Bool {
        return  apiInfo?.next != nil
    }
 }

//MARK: - CollectionView
extension RMEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.identifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
            fatalError("Unsupported cell")
        }
            
        cell.configure(with: cellViewModels[indexPath.row])
        cell.layer.cornerRadius = 4
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
              ofKind: kind,
              withReuseIdentifier: RMFootLoadCollectionReusableView.identifier,
              for: indexPath) as? RMFootLoadCollectionReusableView else {
            fatalError("UnSupported")
        }
        
        footer.startAnimating()
        return footer
     }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicators else {
            return .zero
        }
        
             return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 20)
        return CGSize(width: width, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let selectin =  episodes[indexPath.row]
        delegate?.didEpisodeSelect(selectin)
    }
}

extension RMEpisodeListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicators,
              !isLoadingMoreCharacter,
              !cellViewModels.isEmpty,
              let nextURLString = apiInfo?.next,
              let url = URL(string: nextURLString) else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] t in
            let offSet = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeigt = scrollView.frame.size.height
            
            if offSet >= (totalContentHeight - totalScrollViewFixedHeigt - 120 ) {
                self?.fetchAdditionalEpisode(url: url)
            }
            t.invalidate()

            
          }
      }
}

     
