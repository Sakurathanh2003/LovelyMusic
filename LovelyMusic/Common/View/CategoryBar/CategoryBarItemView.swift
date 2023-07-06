//
//  CategoryBarItemView.swift
//  Wallpaper
//
//  Created by Thanh Vu on 25/02/2022.
//

import Foundation
import UIKit
import SDWebImage

class CategoryBarItemView: TapableView {
    var item: CategoryBarItem

    override var isSelected: Bool {
        didSet {
            self.nameLabel.textColor = UIColor(rgb: isSelected ? 0xFFFFFF : 0x8D8D8D)
        }
    }
    // MARK: - UI
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x8D8D8D)
        return label
    }()

    init(item: CategoryBarItem) {
        self.item = item
        super.init(frame: .zero)

        self.backgroundColor = .clear
        self.addSubview(self.stackView)
        self.stackView.fitSuperviewConstraint(edgeInset: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))

        self.nameLabel.text = item.name
        self.stackView.addArrangedSubview(self.nameLabel)
        if let imageURL = item.imageURL {
            self.iconImageView.sd_setImage(with: imageURL)
            self.stackView.addArrangedSubview(self.iconImageView)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
