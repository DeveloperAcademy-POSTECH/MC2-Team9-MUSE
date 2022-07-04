//
//  File.swift
//  Muse
//
//  Created by kwon ji won on 2022/06/23.
//

import SwiftUI
import UIKit
import MessageUI

struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    private let reportMessage: String = """
    
    
    We will reply in 24 hours.
    """
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?
        
        init(presentaiton: Binding<PresentationMode>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            self._presentation = presentaiton
            self._result = result
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer { self.$presentation.wrappedValue.dismiss() }
            if let error = error {
                self.result = .failure(error)
                return
            }
            self.result = .success(result)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentaiton: presentation, result: self.$result)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = MFMailComposeViewController()
        viewController.mailComposeDelegate = context.coordinator
        viewController.setToRecipients(["wonny@naver.com"])
        viewController.setSubject("Muse User Report")
        viewController.setMessageBody(self.reportMessage, isHTML: false)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}



