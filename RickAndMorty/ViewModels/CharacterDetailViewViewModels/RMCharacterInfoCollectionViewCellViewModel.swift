//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMorty
//
//  Created by Apple on 18.07.1444 (AH).
//

import UIKit
final class RMCharacterInfoCollectionViewCellViewModel {
    
    // y-MM-dd H:mm:ss.SSSS
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
         return formatter
    }()
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        formatter.timeZone = .current
         return formatter
    }()

    public let type: `Type`
    private let value: String
    
    public var title: String {
        type.displayTitle
    }
    public var displayValue: String {
        if value.isEmpty {
            return "Not found"
        }
         if let date = Self.dateFormatter.date(from: value), type == .created {
             return Self.shortDateFormatter.string(from: date)
            
        }
        return value
    }
    public var iconImage: UIImage? {
        return  type.iconImage
    }
    public var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColor: UIColor {
           switch self {
           case .status:
               return .systemGray
           case .gender:
               return.systemRed
           case .type:
               return .systemBlue
           case .species:
               return .systemCyan
           case .origin:
               return .systemMint
           case .created:
               return .systemPink
           case .location:
               return .systemTeal
           case . episodeCount:
               return .orange
           }
           
       }
        var iconImage: UIImage? {
           switch self {
           case .status:
               return UIImage(systemName: "person")
           case .gender:
               return UIImage(systemName: "allergens")
           case .type:
               return UIImage(systemName: "t.square.fill")
           case .species:
               return UIImage(systemName: "circle.grid.cross.down.fill")
           case .origin:
               return UIImage(systemName: "arrow.up.right.and.arrow.down.left.rectangle")
           case .created:
               return UIImage(systemName: "tray.and.arrow.down")
           case .location:
               return UIImage(systemName: "map")
           case . episodeCount:
               return UIImage(systemName: "person.2.crop.square.stack")
           }
           
       }
        
        var displayTitle: String {
            switch self {
            case .status,
             .gender,
             .type,
             .species,
             .origin,
             .created,
             .location:
                return rawValue.uppercased()
             case .episodeCount:
                return "Episode count in".uppercased()
            }
            
        }

    }
    
    init(type: `Type` ,value: String) {
        self.value = value
        self.type = type
    }
    
}
