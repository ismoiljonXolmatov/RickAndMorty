//
//  RMSearchView.swift
//  RickAndMorty
//
//  Created by Apple on 30.07.1444 (AH).
//

import UIKit

protocol RMSearchViewdelegate: AnyObject {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption)
}

class RMSearchView: UIView {
    
    weak var delegate: RMSearchViewdelegate?
    
    private let viewModel: RMSearchViewViewModel
    
    //MARK: - SubViews
    
    // SearchInputView(bar, selections buttons)
    
    private let rMSearchInputView = RMSearchInputView()
    
    
    // No results view
     private let noRelustView = RMNoSearchReslutsView()
    
    
    // REsults CollectionView
    
    //MARK: - Init 
      init(frame: CGRect,viewModel: RMSearchViewViewModel) {
        self.viewModel = viewModel
         super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
         backgroundColor = .systemBackground
          addSubview(noRelustView)
          addSubview(rMSearchInputView)
          addConstraints()
          rMSearchInputView.configure(with: RMSearchInputViewViewModel(type: viewModel.config.type))
          rMSearchInputView.delegate = self
          viewModel.registerOptionChangeBlock { tuple in
              self.rMSearchInputView.update(option: tuple.0, value: tuple.1)
          }
          viewModel.registerSearchResultHandler { results in
              print(results)
               
          }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            // input View
            noRelustView.centerYAnchor.constraint(equalTo: centerYAnchor),
            noRelustView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noRelustView.heightAnchor.constraint(equalToConstant: 150),
            noRelustView.widthAnchor.constraint(equalToConstant: 300),
  
            // no reslut
            rMSearchInputView.topAnchor.constraint(equalTo: topAnchor),
            rMSearchInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rMSearchInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rMSearchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55 :150),
    
        ])
    }
    
    public func presentKeyboard() {
        rMSearchInputView.presentKeyboard()
    }
    
 
}

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
    
extension RMSearchView: RMSearchInputViewDelegate {
    
    func rmSearchInputViewDidTapSearchKeyboardButton(_ inputView: RMSearchInputView) {
        viewModel.exacuteSerch()
    }
    
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didChangeSearchText text: String) {
        viewModel.set(query: text)
    }
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didSelectOption option: RMSearchInputViewViewModel.DynamicOption) {
        delegate?.rmSearchView(self, didSelectOption: option)
    }
}
