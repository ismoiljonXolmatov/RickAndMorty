//
//  RMSettingCellViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 26.07.1444 (AH).
//

import UIKit

struct RMSettingCellViewModel: Identifiable {
    let id = UUID()
    
    //MARK: - Privities
    public let type: RMSettingsOption
    public let onTapHandler: (RMSettingsOption) -> Void

    
    //MARK: - Init
    init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
  
    //MARK: - Publities
    public var image: UIImage? {
        return type.iconImage
    }
    public var title: String {
        return type.displaytitle
    }
    public var iconContainerColor: UIColor {
        return type.iconcontainerColor
    }
    
}
    

