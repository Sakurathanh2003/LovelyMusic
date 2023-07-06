//
//  ShareSheet.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 28/07/2022.
//

import Foundation
import UIKit
import SwiftUI
import RealmSwift

struct ShareSheet: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let activityItems: [Any]
    private let shareSheet: UIActivityViewController

    init(isPresented: Binding<Bool>, activityItems: [Any]) {
        self._isPresented = isPresented
        self.activityItems = activityItems
        self.shareSheet = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.shareSheet.completionWithItemsHandler = { activityType, completed, returnedItems, error in
            isPresented.wrappedValue = false
        }
    }

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isPresented, shareSheet.view.window == nil {
            uiViewController.present(shareSheet, animated: true, completion: nil)
        } else if !isPresented, shareSheet.view.window != nil {
            shareSheet.dismiss(animated: true)
        }
    }
}

extension View {
  func shareSheet(isPresented: Binding<Bool>, activityItems: [Any]) -> some View {
      self.background(
        ShareSheet(isPresented: isPresented, activityItems: activityItems)
      )
  }
}
