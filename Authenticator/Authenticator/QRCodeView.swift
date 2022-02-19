//
//  QRCodeView.swift
//  Authenticator
//
//  Created by YUKITO on 2022/02/18.
//

import Foundation
import SwiftUI
import UIKit

struct QRCodeViewController: UIViewControllerRepresentable {
    
    final class Coordinator {
        let onRead: (String) -> Void
        
        init(onRead: @escaping (String) -> Void) {
            self.onRead = onRead
        }
        
        func didRead(_ str: String) {
            onRead(str)
        }
    }
    
    let onRead: (String) -> Void
    
    init(onRead: @escaping (String) -> Void) {
        self.onRead = onRead
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onRead: onRead)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        return QRCamera(onRead: onRead) 
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
}

