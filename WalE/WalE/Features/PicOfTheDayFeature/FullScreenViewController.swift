//
//  FullScreenViewController.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import UIKit

class FullScreenViewController: UIViewController {

    var imageToShow: UIImage?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    private lazy var btnCross: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(self.dismissVC), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        btn.setTitle("Dismiss", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @objc func dismissVC(){
        self.dismiss(animated: true)
    }
    func setupUI(){
        
        view.backgroundColor = .black
        imageView.image = imageToShow
        
        view.addSubview(containerView)
        
        containerView.addSubview(imageView)
        containerView.addSubview(btnCross)
        
        containerView.anchor(topAnchor: view.topAnchor, leftAnchor: view.leftAnchor, bottomAnchor: view.bottomAnchor, rightAnchor: view.rightAnchor)
        imageView.anchor(topAnchor: containerView.topAnchor, leftAnchor: containerView.leftAnchor, bottomAnchor: containerView.bottomAnchor, rightAnchor: containerView.rightAnchor)
        btnCross.anchor(leftAnchor: containerView.leftAnchor, leftPadding: 20, bottomAnchor: containerView.bottomAnchor, bottomPadding: 20, rightAnchor: containerView.rightAnchor, rightPadding: 20, height: 40)
    }
}
