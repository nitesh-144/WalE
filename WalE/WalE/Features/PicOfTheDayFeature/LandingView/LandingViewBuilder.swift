//
//  LandingViewBuilder.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import Foundation

protocol LandingViewBuilderProtocol{
    func build() -> LandingViewControllerProtocol
}

class LandingViewBuilder: LandingViewBuilderProtocol{
    func build() -> LandingViewControllerProtocol {
        LandingViewController()
    }
}
