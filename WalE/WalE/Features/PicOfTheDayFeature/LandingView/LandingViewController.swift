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
        view.backgroundColor = .lightGray
        setupUI()
        viewModel.getImageOfTheDay()
    }
    
    //MARK:- Utility methods
    func setupUI(){
        
        view.addSubview(containerView)
        self.navigationController?.isNavigationBarHidden = true
        
        containerView.addSubview(imageView)
        containerView.addSubview(topContainerView)
        containerView.addSubview(bottomContainerView)
        
        topContainerView.addSubview(topBaseView)
        topContainerView.addSubview(lblCaption)
        
        bottomContainerView.addSubview(bottomBaseView)
        bottomContainerView.addSubview(lblDescription)
        bottomContainerView.addSubview(btnReadMore)
        
        containerView.anchor(topAnchor: view.topAnchor, leftAnchor: view.leftAnchor, bottomAnchor: view.bottomAnchor, rightAnchor: view.rightAnchor)
        imageView.anchor(topAnchor: containerView.topAnchor, leftAnchor: containerView.leftAnchor, bottomAnchor: containerView.bottomAnchor, rightAnchor: containerView.rightAnchor)
        
        topContainerView.anchor(topAnchor: containerView.topAnchor, topPadding: 50, leftAnchor: containerView.leftAnchor, leftPadding: 20, rightAnchor: containerView.rightAnchor, rightPadding: 20)
        topBaseView.anchor(topAnchor: topContainerView.topAnchor, leftAnchor: topContainerView.leftAnchor, bottomAnchor: topContainerView.bottomAnchor, rightAnchor: topContainerView.rightAnchor)
        lblCaption.anchor(topAnchor: topContainerView.topAnchor, topPadding: 10, leftAnchor: topContainerView.leftAnchor, leftPadding: 10,bottomAnchor: topContainerView.bottomAnchor, bottomPadding: 10, rightAnchor: topContainerView.rightAnchor, rightPadding: 10)
        
        bottomContainerView.anchor(leftAnchor: containerView.leftAnchor, leftPadding: 20, bottomAnchor: containerView.bottomAnchor, bottomPadding: 50, rightAnchor: containerView.rightAnchor, rightPadding: 20)
        bottomBaseView.anchor(topAnchor: bottomContainerView.topAnchor,leftAnchor: bottomContainerView.leftAnchor, bottomAnchor: bottomContainerView.bottomAnchor, rightAnchor: bottomContainerView.rightAnchor)
        btnReadMore.anchor(leftAnchor: bottomContainerView.leftAnchor, leftPadding: 20, bottomAnchor: bottomContainerView.bottomAnchor, bottomPadding: 20, rightAnchor: bottomContainerView.rightAnchor, rightPadding: 20, height: 40)
        lblDescription.anchor(topAnchor: bottomContainerView.topAnchor, topPadding: 20, leftAnchor: bottomContainerView.leftAnchor, leftPadding: 20, bottomAnchor: btnReadMore.topAnchor, bottomPadding: 10, rightAnchor: bottomContainerView.rightAnchor, rightPadding: 20)
        
    }
    
    //MARK: - Button Actions
    @objc func showPicOfTheDayInFullScreen(){
        print("\nShow full pic of the day - action")
    }
}
extension LandingViewController: LandingViewModelDelegateProtocol{
    func renderRecordToUI() {
        if let record = viewModel.todayImageRecord{
            lblCaption.text = record.title
            lblDescription.text = "Description: \n\(Utlity.getShortDescription(fromContent: record.explanation!))..."
            if let imageData = record.imageContentData{
                imageView.image = UIImage(data: imageData)
            }else{
                guard let url = URL(string: record.url!) else { return }
                if let imgData = try? Data(contentsOf: url){
                    DispatchQueue.main.async {[weak self] in
                        self?.imageView.image = UIImage(data: imgData)
                    }
                }
            }
        }
    }
}
