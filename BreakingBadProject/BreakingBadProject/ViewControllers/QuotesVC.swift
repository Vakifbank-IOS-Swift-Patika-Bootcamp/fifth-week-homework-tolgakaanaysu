//
//  QuotesVC.swift
//  BreakingBadProject
//
//  Created by Tolga Kağan Aysu on 25.11.2022.
//

import UIKit
final class QuotesVC: BaseViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var quotesTextView: UITextView!
    @IBOutlet private weak var navigationBar: UINavigationBar!
    
    //MARK: - Properity
    private var quotes: [QuoteModel] = []{
        didSet{
            quotesTextView.text = quotes.compound()
            navigationBar.topItem?.title = name
            navigationBar.isHidden = false
        }
    }
    private var name: String?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getQuotes()
        navigationBar.isHidden = true
        
    }
    
    //MARK: - IBActions
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    //MARK: - Methods
    func initName(_ name: String){
        self.name = name
    }
    
    
    
    //MARK: - Private Methods
    private func getQuotes(){
        guard let name = name else { return }
        indicator.startAnimating()
        NetworkClient.getQuoteByAuthor(name: name) {[weak self] quotes, error in
            guard let self = self,
                  let quotes = quotes,
                quotes.count > 0 else {
                self?.dismiss(animated: true)
                self?.showErrorAlert(message: "No quotes this character") {}
                return
            }
            self.navigationItem.title = name
            self.quotes = quotes
            self.indicator.stopAnimating()
        }
    }
}

extension Array where Element == QuoteModel {
    func compound() -> String {
        let strArr = self.map{ $0.quote}
        return strArr.joined(separator: " \n \n ")
    }
}
