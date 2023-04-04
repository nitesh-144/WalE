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
        viewModel.getImageOfTheDay()
    }
}
extension LandingViewController: LandingViewModelDelegateProtocol{
    func renderRecordToUI() {
        print("\n\nIn Landing View Controller")
        print(viewModel.todayImageRecord)
    }
}
