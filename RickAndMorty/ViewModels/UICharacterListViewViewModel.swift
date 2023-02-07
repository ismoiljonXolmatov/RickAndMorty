//
//  CharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 09.07.1444 (AH).
//

import UIKit

protocol UICharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didChacacterSelect(_ character: RMCharacter)
}

/// ViewModel to handle character list view logic
final class UICharacterListViewViewModel: NSObject {
    
    public weak var delegate: UICharacterListViewViewModelDelegate?
    
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    private var characters: [RMCharacter] = [] {
       didSet  {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(characterName: character.name, characterStatusText: character.status, characterImageURL: URL(string: character.image ))
                cellViewModels.append(viewModel )
            }
        }
    }
    private var cellViewModels: [RMCharacterCollectionViewCellViewModel] = []
        
    /// Fetch initial set of character  (20)
   public func fetchCharacters() {
        RMService.shared.exacute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                 self?.characters = responseModel.results
                self?.apiInfo? = responseModel.info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchdditionalCharacters() {
    }

    private var shouldShowLoadMoreIndicator: Bool {
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
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
            return CGSize(width: collectionView.frame.width, height: 100 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(width: width, height: width*1.4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character =  characters[indexPath.row]
        delegate?.didChacacterSelect(character)
    }
}


extension UICharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator else {
            return
        }
        let offset = scrollView.contentOffset.y
        let totalContentHeight = scrollView.contentSize.height
        let totalScrollViewFixedHeight = scrollView.frame.size.height
        print("Offset:  \(offset)")
        print("totalContentHeight:  \(totalContentHeight)")
        print("totalScrollViewFixedHeight:  \(totalScrollViewFixedHeight)")
     }
}
