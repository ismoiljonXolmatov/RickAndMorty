//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 09.07.1444 (AH).
//

import UIKit

protocol UICharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacter(with newIndexPaths: [IndexPath])
    func didCharacterSelect(_ character: RMCharacter)
}


/// ViewModel to handle character list view logic
final class UICharacterListViewViewModel: NSObject {
    
    public weak var delegate: UICharacterListViewViewModelDelegate?
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
    
    private var  isLoadingMoreCharacter = false
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters  {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatusText: character.status,
                    characterImageURL: URL(string: character.image))
                
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)

                }
            }
            
        }
    }
    
    /// Fetch initial set of character  (20)
    public func fetchCharacters() {
        RMService.shared.exacute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.characters = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    //Faginate if additional characters are needed
    public func fetchAdditionalCharacters(url: URL) {
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
            expecting: RMGetAllCharactersResponse.self) { [weak self ] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let responseModel):
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.apiInfo = info
                    
                      
                    let originalCount = strongSelf.characters.count
                    let newCount = moreResults.count
                    let total = originalCount+newCount
                    let startingindex = total-newCount
                    let indexPathToAdd: [IndexPath] = Array(startingindex..<(startingindex+newCount)).compactMap({
                        return IndexPath(row: $0, section: 0)
                    })
                    strongSelf.characters.append(contentsOf: moreResults)
                    DispatchQueue.main.async {
                        strongSelf.delegate?.didLoadMoreCharacter(with: indexPathToAdd)

                    
                      strongSelf.isLoadingMoreCharacter = false
                    }
                case .failure(let failure):
                    print(String(describing: failure))
                    
                    strongSelf.isLoadingMoreCharacter = false


                }
            }

        // fetch characters
    }
    
    public var shouldShowLoadMoreIndicators: Bool {
        return  apiInfo?.next != nil
    }
 }

//MARK: - CollectionView
extension UICharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier, for: indexPath) as? RMCharacterCollectionViewCell else {
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
              withReuseIdentifier: RMFootLoadCollectionReusableView.indentifier,
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
        let width = (bounds.width - 30)/2
        return CGSize(width: width, height: width*1.4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character =  characters[indexPath.row]
        delegate?.didCharacterSelect(character)
    }
}

extension UICharacterListViewViewModel: UIScrollViewDelegate {
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
                self?.fetchAdditionalCharacters(url: url )
            }
            t.invalidate()

            
          }
      }
}

       
