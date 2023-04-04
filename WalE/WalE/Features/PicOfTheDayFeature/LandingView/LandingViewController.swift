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
    
    //MARK:- UIElements
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    //Top section
    private let lblCaption: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 28)
        return lbl
    }()
    private let topContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5.0
        view.clipsToBounds = true
        return view
    }()
    private let topBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    
    // Bottom section
    private let lblDescription: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 18.0)
        return lbl
    }()
    private lazy var btnReadMore: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(self.showPicOfTheDayInFullScreen), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        btn.setTitle("View Picture of the day", for: .normal)
        return btn
    }()
    private let bottomContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5.0
        view.clipsToBounds = true
        return view
    }()
    private let bottomBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    
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
        setupUI()
        viewModel.getImageOfTheDay()
    }
    
    //MARK:- Utility methods
    func setupUI(){
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - Button Actions
    @objc func showPicOfTheDayInFullScreen(){
        print("\nShow full pic of the day - action")
    }
}
extension LandingViewController: LandingViewModelDelegateProtocol{
    func renderRecordToUI() {
        print("\n\nIn Landing View Controller")
        print(viewModel.todayImageRecord)
    }
}
