//
//  Color.swift
//  Pods
//
//  Created by YUKITO on 2022/02/17.
//

import Foundation
import UIKit

extension UIColor {
    class var background: UIColor {
        get {
            .init(dynamicProvider: { (traitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(red: 0.10, green: 0.11, blue: 0.13, alpha: 1)
                case .light:
                    return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
                case .unspecified:
                    return .systemBackground
                @unknown default: return .systemBackground
                }
            })
        }
    }
    
    class var contentBackground: UIColor {
        get {
            .init(dynamicProvider: { (traitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(red: 0.15, green: 0.16, blue: 0.18, alpha: 1)
                case .light:
                    return UIColor(red: 0.99, green: 0.99, blue: 0.99, alpha: 1)
                case .unspecified:
                    return .systemBackground
                @unknown default: return .systemBackground
                }
            })
        }
    }
    
    class var barColor : UIColor {
        get {
            .init(dynamicProvider: { (traitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(red: 75/255, green: 141/255, blue: 200/255, alpha: 1)
                case .light:
                    return UIColor(red: 75/255, green: 141/255, blue: 200/255, alpha: 1)
                case .unspecified:
                    return .clear
                @unknown default: return .clear
                }
            })
        }
    }
    
    class var highlightText : UIColor {
        get {
            .init(dynamicProvider: { (traitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
                case .light:
                    return UIColor(red: 75/255, green: 141/255, blue: 200/255, alpha: 1)
                case .unspecified:
                    return .clear
                @unknown default: return .clear
                }
            })
        }
    }
    
    class var distructiveText : UIColor {
        get {
            .init(dynamicProvider: { (traitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(red: 223/255, green: 118/255, blue: 106/255, alpha: 1)
                case .light:
                    return UIColor(red: 223/255, green: 118/255, blue: 106/255, alpha: 1)
                case .unspecified:
                    return .clear
                @unknown default: return .clear
                }
            })
        }
    }
    
    class var codeBackground : UIColor {
        get {
            .init(dynamicProvider: { (traitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return .background
                case .light:
                    return UIColor(red: 75/255, green: 141/255, blue: 200/255, alpha: 0.1)
                case .unspecified:
                    return .clear
                @unknown default: return .clear
                }
            })
        }
    }
    
    class var distructiveBackground : UIColor {
        get {
            .init(dynamicProvider: { (traitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return .background
                case .light:
                    return UIColor(red: 223/255, green: 118/255, blue: 106/255, alpha: 0.1)
                case .unspecified:
                    return .clear
                @unknown default: return .clear
                }
            })
        }
    }
    
    class var shadowColor : UIColor {
        get {
            .init(dynamicProvider: { (traitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                case .light:
                    return UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.2)
                case .unspecified:
                    return .clear
                @unknown default: return .clear
                }
            })
        }
    }
    
}
