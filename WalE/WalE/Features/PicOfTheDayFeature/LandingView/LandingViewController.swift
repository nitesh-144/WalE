//
//  LandingViewController.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import UIKit

protocol LandingViewControllerProtocol{
    var viewModel: LandingViewModelProtocol { get set }
}

class LandingViewController: UIViewController, LandingViewControllerProtocol {
    
    //MARK: - Properties
    var viewModel: LandingViewModelProtocol
    
    //MARK: - Init Methods
    init(viewModel: LandingViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        ApiClient.shared.getImageOfTheDay { imageData, errorType in
            if errorType == .internetConnectionError{
                print("\nInternet is not connected")
            }else{
                print("\nInternet connected\n")
                print(imageData)
            }
        }
    }
}
extension LandingViewController: LandingViewModelDelegateProtocol{
    
}
