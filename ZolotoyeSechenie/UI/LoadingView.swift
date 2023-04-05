//
//  LoadingView.swift
//  ZolotoyeSechenie
//
//  Created by Someone on 03.04.2023.
//

import UIKit

final class LoadingView: UIView {
    private lazy var activityIndicator = UIActivityIndicatorView()
    private lazy var containerView = UIView()
    init(withBackground: Bool = false) {
        super.init(frame: .zero)
        layout()
        if withBackground {
            self.backgroundColor = .white
        }
        self.isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        activityIndicator.color = K.Colors.prettyGold
        activityIndicator.scaleIndicator(factor: 1.2)
        containerView.layer.cornerRadius = K.cornerRadius
        containerView.layer.masksToBounds = true

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = containerView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.addSubview(containerView)
        containerView.addSubview(blurEffectView)
        containerView.addSubview(activityIndicator)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: 100),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }

    public func startLoading() {
        activityIndicator.startAnimating()
//        self.alpha = 0
        self.isHidden = false
//        UIView.animate(withDuration: 0.3) { [weak self] in
//            self?.alpha = 1
//        }
    }

    public func endLoading() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.alpha = 0
        }) { [weak self] finished in
            self?.isHidden = finished
        }
        
    }
}


