//
//  RMSettingsOption.swift
//  RickAndMorty
//
//  Created by Apple on 26.07.1444 (AH).
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUP
    case terms
    case privacy
    case apiReferences
    case viewSeries
    case viewCode
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUP:
            return URL(string: "https://rickandmortyshop.com/contact-us/")
        case .terms:
            return URL(string: "https://rickandmortyshop.com/term-of-service/")
        case .privacy:
            return URL(string: "https://rickandmortyshop.com/privacy-policy/")
        case .apiReferences:
            return URL(string: "https://rickandmortyapi.com/documentation/#get-a-single-character")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/playlist?list=PL5PR3UyfTWvdl4Ya_2veOB6TM16FXuv4y")
        case .viewCode:
            return URL(string: "https://github.com/AfzarCodes/RickAndMortyiOSApp")

            
        }
    }
    
    var displaytitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUP:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReferences:
            return "API References"
        case .viewSeries:
            return "View Video Series"
        case .viewCode:
            return "View App Code"
            
        }
     }
    var iconcontainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUP:
            return .systemIndigo
        case .terms:
            return .systemMint
        case .privacy:
            return .systemGreen
        case .apiReferences:
            return .systemOrange
        case .viewSeries:
            return .systemPink
        case .viewCode:
            return .systemBrown

            
        }
    }
    var iconImage: UIImage?  {
        switch self {
        case .rateApp: return UIImage(systemName: "star.fill")
        case .contactUP: return UIImage(systemName: "paperplane.fill")
        case .terms: return UIImage(systemName: "doc.fill")
        case .privacy: return UIImage(systemName: "lock.fill")
        case .apiReferences: return UIImage(systemName: "list.bullet.clipboard")
        case .viewSeries: return UIImage(systemName: "tv.fill")
        case .viewCode: return UIImage(systemName: "hammer.fill")
            
        }
    }
}
