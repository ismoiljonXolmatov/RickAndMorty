//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 12.07.1444 (AH).
//

import UIKit 

final class RMCharacterDetailViewViewModel {
    
    public var episodes: [String] {
        character.episode
    }
    
    private let character: RMCharacter
    
    enum SectionType {
        case photo(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
        case episode(viewModels: [RMCharacterEpisodeCollectionViewCellViewModel])
    }
    public var sections: [SectionType] = []
    
    
    // MARK: - Init
    init(character: RMCharacter) {
        self.character = character
        setUPSections()
    }
    private func setUPSections() {
          sections = [
            .photo(viewModel: .init(imageUrl: URL(string: character.image))),
            .information(viewModels: [
                .init(type: . status,value: character.status.text),
                .init(type: .gender ,value: character.gender.rawValue),
                .init(type: .type ,value: character.type ?? "Not found"),
                .init(type: .species ,value: character.species),
                .init(type: .origin ,value: character.origion?.name ?? "Not found"),
                .init(type: .location ,value: character.location.name),
                .init(type: .created ,value: character.created),
                .init(type: .episodeCount ,value: "\(character.episode.count)"),
            ]),
            .episode(viewModels: character.episode.compactMap({
                return RMCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0))
            }))
        ]
 
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }

    public var title: String {
        character.name.uppercased()
    }
    
    // MARK: - Layouts
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item  = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
       )
    )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
    let group = NSCollectionLayoutGroup.vertical(layoutSize:  NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(0.5)
        ),
        subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    // MARK: - InfoSection
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item  = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
        heightDimension: .fractionalHeight(1.0)
       )
    )
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
    let group = NSCollectionLayoutGroup.horizontal(layoutSize:  NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(120)
        ),
        subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    // MARK: - EpisodeSection
    
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        let item  = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
       )
    )
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:  NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.7),
            heightDimension: .absolute(170)
        ),
        subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
}
