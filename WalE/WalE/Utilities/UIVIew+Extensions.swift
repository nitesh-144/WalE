//
//  UIVIew+Extensions.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import UIKit

extension UIView{
    
    func anchor(topAnchor: NSLayoutYAxisAnchor? = nil, topPadding: CGFloat = 0, leftAnchor: NSLayoutXAxisAnchor? = nil,leftPadding: CGFloat = 0, bottomAnchor: NSLayoutYAxisAnchor? = nil, bottomPadding: CGFloat = 0, rightAnchor: NSLayoutXAxisAnchor? = nil, rightPadding: CGFloat = 0, width: CGFloat? = nil, height: CGFloat? = nil){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let topAnchor = topAnchor{
            self.topAnchor.constraint(equalTo: topAnchor, constant: topPadding).isActive = true
        }
        if let leftAnchor = leftAnchor{
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: leftPadding).isActive = true
        }
        if let bottomAnchor = bottomAnchor{
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomPadding).isActive = true
        }
        if let rightAnchor = rightAnchor{
            self.rightAnchor.constraint(equalTo: rightAnchor, constant: -rightPadding).isActive = true
        }
        if let width = width{
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height{
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
