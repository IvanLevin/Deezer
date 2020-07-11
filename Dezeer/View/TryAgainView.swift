//
//  TryAgainView.swift
//  Dezeer
//
//  Created by Levin Ivan on 11.07.2020.
//  Copyright © 2020 Levin Ivan. All rights reserved.
//
//
//@objc internal protocol TryAgainDelegate: class {
//    @objc optional func floatButtonTap(_ tryAgainView: TryAgainView)
//    @objc optional func tryAgainViewWillDisplay(_ tryAgainView: TryAgainView)
//}
//
//import UIKit
//import TinyConstraints
//
//enum ContentType {
//    case text(String)
//    case image(type: EmptyStateType, text: String, title: String?)
//}
//
//class TryAgainView: UIView {
//
//    weak var delegate: TryAgainDelegate?
//    var floatButton: FloatButton!
//
//    var titleText: String? {
//        get {
//            return titleLabel.text
//        }
//        set {
//            titleLabel.text = newValue
//        }
//    }
//    var descText: String? {
//        get {
//            return descLabel.text
//        }
//        set {
//            descLabel.text = newValue
//        }
//    }
//
//    fileprivate var titleLabel: UILabel!
//    fileprivate var descLabel: UILabel!
//    fileprivate var didButtonTapped: (() -> Void)?
//    var shouldDestroyWhenHidden = false
//
//    private var labelWrapper: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.utkBackground
//        view.isHidden = true
//        return view
//    }()
//    private lazy var wrapper: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.utkBackground
//        return view
//    }()
//    private var emptyStateView: EmptyStateView = {
//        let view = EmptyStateView(type: .cry)
//        view.isHidden = true
//        return view
//    }()
//
//    init(view: UIView) {
//        super.init(frame: CGRect.zero)
//
//        setup(false)
//
//        view.addSubview(self)
//        self.edges(to: view)
//    }
//
//    init(view: UIView, tabBarVisible: Bool) {
//        super.init(frame: CGRect.zero)
//
//        setup(tabBarVisible)
//
//        view.addSubview(self)
//        self.edges(to: view)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setup(_ tabBarVisible: Bool) {
//        self.backgroundColor = UIColor.utkBackground
//        self.isHidden = true
//
//        let scrollView = UIScrollView()
//        scrollView.bounces = true
//        scrollView.alwaysBounceVertical = true
//        scrollView.alwaysBounceHorizontal = false
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.backgroundColor = UIColor.utkBackground
//        scrollView.isUserInteractionEnabled = true
//        scrollView.isExclusiveTouch = true
//        scrollView.canCancelContentTouches = true
//        scrollView.delaysContentTouches = true
//
//        self.addSubview(scrollView)
//        scrollView.edges(to: self)
//
//        scrollView.addSubview(wrapper)
//        wrapper.edges(to: scrollView)
//        wrapper.width(to: self)
//
//        if #available(iOS 11, *) {
//            wrapper.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([wrapper.heightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.heightAnchor,
//                                                                         multiplier: 1)])
//        } else {
//            wrapper.height(to: self)
//        }
//
//        initialLayoutTextState()
//        initialLayoutImageState()
//
//        floatButton = FloatButton(attachTo: self, title: "Попробовать снова", tabBarVisible: tabBarVisible, addInset: false)
//        floatButton.addTarget(self, action: #selector(self.floatButtonTap(_:)), for: .touchUpInside)
//    }
//
//    private func initialLayoutTextState() {
//        wrapper.addSubview(labelWrapper)
//        labelWrapper.leading(to: wrapper, offset: 32)
//        labelWrapper.trailing(to: wrapper, offset: -32)
//        labelWrapper.center(in: wrapper)
//
//        titleLabel = UILabel()
//        titleLabel.text = "Ошибка"
//        titleLabel.font = ConstantsFont.boldFont(of: 17)
//        titleLabel.textColor = UIColor.utkTextSecondary
//        titleLabel.textAlignment = .center
//        titleLabel.backgroundColor = UIColor.utkBackground
//        titleLabel.numberOfLines = 0
//
//        labelWrapper.addSubview(titleLabel)
//        titleLabel.top(to: labelWrapper)
//        titleLabel.leading(to: labelWrapper)
//        titleLabel.trailing(to: labelWrapper)
//
//        descLabel = UILabel()
//        descLabel.text = "Произошла ошибка"
//        descLabel.font = ConstantsFont.regularFont(of: 15)
//        descLabel.textColor = UIColor.utkTextTertiary
//        descLabel.textAlignment = .center
//        descLabel.backgroundColor = UIColor.utkBackground
//        descLabel.numberOfLines = 0
//
//        labelWrapper.addSubview(descLabel)
//        descLabel.top(to: titleLabel, offset: 32)
//        descLabel.leading(to: labelWrapper)
//        descLabel.trailing(to: labelWrapper)
//        descLabel.bottom(to: labelWrapper)
//    }
//
//    private func initialLayoutImageState() {
//        wrapper.addSubview(emptyStateView)
//        emptyStateView.centerY(to: wrapper, offset: -40)
//        emptyStateView.width(to: wrapper)
//    }
//
//    @objc fileprivate func floatButtonTap(_ sender: FloatButton) {
//        delegate?.floatButtonTap?(self)
//        didButtonTapped?()
//        sender.hide(animated: true)
//        hide()
//    }
//
//    deinit {
//        print("TRY AGAIN DESTROYED!!!!")
//        removeNotificationsObserver()
//    }
//
//    func hide() {
//        guard !isHidden || alpha > 0 else { return }
//
//        UIView.animate(withDuration: 0.2, delay: 0.1, options: UIView.AnimationOptions(), animations: {
//            self.alpha = 0
//        }) { _ in
//            self.isHidden = self.alpha == 0
//            if self.shouldDestroyWhenHidden {
//                self.removeFromSuperview()
//            }
//        }
//    }
//
//    func show() {
//        guard isHidden || alpha < 1 else { return }
//
//        superview?.bringSubviewToFront(self)
//        self.alpha = 0
//        self.isHidden = false
//        floatButton.hide()
//        delegate?.tryAgainViewWillDisplay?(self)
//        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions(), animations: {
//            self.alpha = 1
//        }) { _ in
//            self.floatButton.show(animated: true)
//        }
//    }
//
//    func show(with text: String, didButtonTapped: (() -> Void)? = nil) {
//        guard text != "отменен" else { return }
//
//        if text == ConstantsText.serverError {
//            show(type: .image(type: .phone, text: text, title: nil), didButtonTapped: didButtonTapped)
//        } else {
//            show(type: .text(text), didButtonTapped: didButtonTapped)
//        }
//    }
//
//    func show(type: ContentType, didButtonTapped: (() -> Void)? = nil) {
//        switch type {
//        case .text(let text):
//            guard text != "отменен" else { return } // на всякий
//            if text == ConstantsText.serverError {
//                configureImageType(type: .phone, text: text, title: nil)
//            } else {
//                configureTextType(text: text)
//            }
//        case .image(let emptyStatetype, let text, let title):
//            guard text != "отменен" else { return } // на всякий
//            configureImageType(type: emptyStatetype, text: text, title: title)
//        }
//        show()
//
//        self.didButtonTapped = didButtonTapped
//    }
//
//    private func configureTextType(text: String) {
//        titleText = "Ошибка"
//        descText = text
//        emptyStateView.isHidden = true
//        labelWrapper.isHidden = false
//    }
//
//    private func configureImageType(type: EmptyStateType, text: String, title: String?) {
//        titleText = nil
//        descText = nil
//        labelWrapper.isHidden = true
//        emptyStateView.isHidden = false
//        emptyStateView.type = type
//        emptyStateView.titleText = title ?? "Ой-ой"
//        emptyStateView.descText = text
//    }
//
//}
