//
//  ScrollableView.swift
//  FunnyRingtones
//
//  Created by Thanh Vu on 22/08/2022.
//


import SwiftUI

struct ScrollableView<Content: View>: UIViewControllerRepresentable, Equatable {

	// MARK: - Coordinator
	final class Coordinator: NSObject, UIScrollViewDelegate {
		
		// MARK: - Properties
		private let scrollView: UIScrollView
		var offset: Binding<CGPoint>

		// MARK: - Init
		init(_ scrollView: UIScrollView, offset: Binding<CGPoint>) {
			self.scrollView          = scrollView
			self.offset              = offset
			super.init()
			self.scrollView.delegate = self
		}
		
		// MARK: - UIScrollViewDelegate
		func scrollViewDidScroll(_ scrollView: UIScrollView) {
			DispatchQueue.main.async {
				self.offset.wrappedValue = scrollView.contentOffset
			}
		}
	}
	
	// MARK: - Type
	typealias UIViewControllerType = UIScrollViewController<Content>
	
	// MARK: - Properties
	var offset: Binding<CGPoint>
	var showsScrollIndicator: Bool
	var axis: Axis
	var content: () -> Content
	var onScale: ((CGFloat)->Void)?
	var disableScroll: Bool
	var forceRefresh: Bool
	var stopScrolling: Binding<Bool>
	private let scrollViewController: UIViewControllerType

	// MARK: - Init
	init(_ offset: Binding<CGPoint>, axis: Axis = .vertical, onScale: ((CGFloat)->Void)? = nil, disableScroll: Bool = false, forceRefresh: Bool = false, stopScrolling: Binding<Bool> = .constant(false),  @ViewBuilder content: @escaping () -> Content) {
		self.offset               = offset
		self.onScale              = onScale
		self.content              = content
		self.showsScrollIndicator = false
		self.axis                 = axis
		self.disableScroll        = disableScroll
		self.forceRefresh         = forceRefresh
		self.stopScrolling        = stopScrolling
		self.scrollViewController = UIScrollViewController(rootView: self.content(), offset: self.offset, axis: self.axis, onScale: self.onScale)
	}
	
	// MARK: - Updates
	func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> UIViewControllerType {
		self.scrollViewController
	}

	func updateUIViewController(_ viewController: UIViewControllerType, context: UIViewControllerRepresentableContext<Self>) {
		
		viewController.scrollView.showsVerticalScrollIndicator   = self.showsScrollIndicator
		viewController.scrollView.showsHorizontalScrollIndicator = self.showsScrollIndicator
		viewController.updateContent(self.content)

		let newValue: CGPoint                     = self.offset.wrappedValue
		viewController.scrollView.isScrollEnabled = !self.disableScroll
		
		if self.stopScrolling.wrappedValue {
			viewController.scrollView.setContentOffset(viewController.scrollView.contentOffset, animated:false)
			return
		}
		
		viewController.scrollView.contentOffset = newValue
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self.scrollViewController.scrollView, offset: self.offset)
	}
	
	// MARK: - Equatable
	static func == (lhs: ScrollableView, rhs: ScrollableView) -> Bool {
		return !lhs.forceRefresh && lhs.forceRefresh == rhs.forceRefresh
	}
}

final class UIScrollViewController<Content: View> : UIViewController, ObservableObject {

	// MARK: - Properties
	var offset: Binding<CGPoint>
	var onScale: ((CGFloat)->Void)?
	let hostingController: UIHostingController<Content>
	private let axis: Axis
	lazy var scrollView: UIScrollView = {
		
		let scrollView                                       = UIScrollView()
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.canCancelContentTouches                   = true
		scrollView.delaysContentTouches                      = true
		scrollView.scrollsToTop                              = false
		scrollView.backgroundColor                           = .clear
		
		if self.onScale != nil {
			scrollView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(self.onGesture)))
		}
		
		return scrollView
	}()
	
	@objc func onGesture(gesture: UIPinchGestureRecognizer) {
		self.onScale?(gesture.scale)
	}

	// MARK: - Init
	init(rootView: Content, offset: Binding<CGPoint>, axis: Axis, onScale: ((CGFloat)->Void)?) {
		self.offset                                 = offset
		self.hostingController                      = UIHostingController<Content>(rootView: rootView)
		self.hostingController.view.backgroundColor = .clear
		self.axis                                   = axis
		self.onScale                                = onScale
		super.init(nibName: nil, bundle: nil)
	}
	
	// MARK: - Update
	func updateContent(_ content: () -> Content) {
		
		self.hostingController.rootView = content()
		self.scrollView.addSubview(self.hostingController.view)
		
		var contentSize: CGSize = self.hostingController.view.intrinsicContentSize
		
		switch axis {
			case .vertical:
				contentSize.width = self.scrollView.frame.width
			case .horizontal:
				contentSize.height = self.scrollView.frame.height
		}
		
		self.hostingController.view.frame.size = contentSize
		self.scrollView.contentSize            = contentSize
		self.view.updateConstraintsIfNeeded()
		self.view.layoutIfNeeded() 
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(self.scrollView)
		self.createConstraints()
		self.view.setNeedsUpdateConstraints()
		self.view.updateConstraintsIfNeeded()
		self.view.layoutIfNeeded()
	}
	
	// MARK: - Constraints
	fileprivate func createConstraints() {
		NSLayoutConstraint.activate([
			self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
			self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
		])
	}
}
