//
//  BaseViewController.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 22.11.2022.
//

import UIKit
import MaterialActivityIndicator
import SwiftAlertView
 
class BaseViewController: UIViewController {
    
    let indicator = MaterialActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
        // Alert
    }
    
    private func setupActivityIndicatorView() {
        view.addSubview(indicator)
        indicator.color = .systemGray
        setupActivityIndicatorViewConstraints()
    }
    
    private func setupActivityIndicatorViewConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func showErrorAlert(message: String, completion: @escaping () -> Void) {
        SwiftAlertView.show(title: "Error",
                            message: message,
                            buttonTitles: ["OK"]).onButtonClicked { _, _ in
            completion()
        }
    }
    
    func showSuccesAlert(message: String, completion: @escaping () -> Void) {
        SwiftAlertView.show(title: "Succesfull",
                            message: message,
                            buttonTitles: ["OK"]).onButtonClicked { _, _ in
            completion()
        }
    }
    
    func showAlert(title: String,
                   message: String? = nil,
                   completion: @escaping(UIAlertAction.Style) -> Void) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let yesButton = UIAlertAction(title: "YES", style: .default){ _ in
            completion(.destructive)
        }
    
        let noButton = UIAlertAction(title: "NO", style: .destructive){ _ in
            completion(.cancel)
        }
        alert.addAction(yesButton)
        alert.addAction(noButton)
        present(alert,animated: true)
       
    }
  
    
}
