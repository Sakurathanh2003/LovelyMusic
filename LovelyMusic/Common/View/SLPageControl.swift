//
//  SLPageControl.swift
//  PulseHeartRate
//
//  Created by Thanh Vu on 31/05/2021.
//  Copyright © 2021 Solar. All rights reserved.
//

import Foundation
import UIKit

class SLPageControlIndicator: UIView {
    
}

class SLPageControl: UIView {
    @IBInspectable var numberOfPage: Int = 1 {
        didSet {
            initPagesIndicator()
            updatePageControlIndicators()
        }
    }
    
    var selectedPageIndex: Int = 0 { didSet { updatePageControlIndicators() }}
    
    private var indicators: [SLPageControlIndicator] = []
    private var stackView: UIStackView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
        initPagesIndicator()
        updatePageControlIndicators()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        initPagesIndicator()
        updatePageControlIndicators()
    }
    
    private func commonInit() {
        self.stackView = UIStackView()
        self.stackView.axis = .horizontal
        self.addSubview(self.stackView)
        self.stackView.fitSuperviewConstraint()
        self.stackView.spacing = 10
        self.stackView.distribution = .equalSpacing
    }
    
    private func initPagesIndicator() {
        if self.indicators.count != self.numberOfPage {
            self.indicators.forEach { indicator in
                indicator.removeFromSuperview()
            }
            
            self.indicators.removeAll()
            
            for _ in 0..<numberOfPage {
                let indicator = SLPageControlIndicator()
                indicator.cornerRadius = 2.5
                indicator.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    indicator.widthAnchor.constraint(equalToConstant: 5),
                    indicator.heightAnchor.constraint(equalToConstant: 5)
                ])
                
                self.indicators.append(indicator)
                self.stackView.addArrangedSubview(indicator)
            }
        }
    }
    
    private func updatePageControlIndicators() {
        self.indicators.enumerated().forEach { index, indicator in
            if index == self.selectedPageIndex {
                indicator.backgroundColor = UIColor.white
                indicator.transform = CGAffineTransform(scaleX: 2, y: 2)
            } else {
                indicator.backgroundColor = UIColor(rgb: 0xF1F1F1)
                indicator.transform = CGAffineTransform.identity
            }
        }
    }
}
