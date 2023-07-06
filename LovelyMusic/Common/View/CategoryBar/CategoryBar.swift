//
//  CategoryBar.swift
//  Wallpaper
//
//  Created by Thanh Vu on 25/02/2022.
//

import Foundation
import UIKit

protocol CategoryBarDelegate: AnyObject {
    func categoryBar(_ bar: CategoryBar, didSelectItem item: CategoryBarItem)
}

final class CategoryBar: UIView {
    weak var delegate: CategoryBarDelegate?
    var items: [CategoryBarItem] = [] {
        didSet {
            self.reloadData()
        }
    }

    var selectedItem: CategoryBarItem? {
        didSet {
            self.updateIndicatorFrame()
        }
    }

    // MARK: - UI
    private var itemViews: [CategoryBarItemView] = []
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9)
        return scrollView
    }()

    private lazy var indicator: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "category_bar_selected_indicator"))
        return imageView
    }()

    private lazy var placeHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x252525)
        view.cornerRadius = 16
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var bottomSeparateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x252525)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.backgroundColor = .clear
        layout()
    }

    private func layout() {
        self.addSubview(self.scrollView)
        self.scrollView.fitSuperviewConstraint()

        self.scrollView.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.trailingAnchor),
            self.stackView.topAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.contentLayoutGuide.bottomAnchor),
            self.stackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor)
        ])

        self.indicator.isHidden = true
        self.scrollView.addSubview(self.indicator)

        self.addSubview(self.placeHolderView)
        self.placeHolderView.fitSuperviewConstraint(edgeInset: UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12))

        self.addSubview(self.bottomSeparateView)
        NSLayoutConstraint.activate([
            self.bottomSeparateView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomSeparateView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomSeparateView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.bottomSeparateView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    private func reloadData() {
        self.stackView.subviews.forEach { view in
            view.removeFromSuperview()
        }

        self.itemViews.removeAll()
        self.items.forEach { item in
            let itemView = CategoryBarItemView(item: item)
            itemView.addTarget(self, action: #selector(itemDidSelect(_:)), for: .touchUpInside)
            self.stackView.addArrangedSubview(itemView)
            self.itemViews.append(itemView)
        }

        self.stackView.layoutIfNeeded()

        if self.selectedItem == nil {
            self.selectedItem = self.items.first
        }
    }

    private func updateIndicatorFrame() {
        guard let selectedItem = selectedItem, let index = self.items.firstIndex(of: selectedItem) else {
            return
        }

        let itemView = self.itemViews[index]
        var frame = CGRect()
        frame.size.width = 34
        frame.size.height = 2
        frame.origin.x = itemView.frame.origin.x + (itemView.frame.width - frame.size.width)/2
        frame.origin.y = self.bounds.height - frame.size.height

        UIView.animate(withDuration: 0.2) {
            self.indicator.frame = frame
        } completion: { _ in
            self.indicator.isHidden = false
        }
    }

    // MARK: - Actions
    @objc private func itemDidSelect(_ itemView: CategoryBarItemView) {
        if let selectedItem = selectedItem, let index = self.items.firstIndex(of: selectedItem) {
            self.itemViews[index].isSelected = false
        }

        itemView.isSelected = true
        if itemView.item == self.selectedItem {
            return
        }

        self.selectedItem = itemView.item
        self.delegate?.categoryBar(self, didSelectItem: itemView.item)

        let visibleRectWillScroll = CGRect(x: max(itemView.frame.origin.x - (self.bounds.width - itemView.frame.width)/2, -self.scrollView.contentInset.left),
                                           y: 0,
                                           width: self.bounds.width - self.scrollView.contentInset.left,
                                           height: 10)
        self.scrollView.scrollRectToVisible(visibleRectWillScroll, animated: true)
    }
}
