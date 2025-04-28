//
//  EasyConstraints+ECMake.swift
//  EasyConstraints
//
//  Created by 박길호(파트너) - 서비스개발담당App개발팀 on 12/23/24.
//

import UIKit

@MainActor
extension EasyConstraints {
    @MainActor
    public struct ECMakeAnchor {
        public weak var ec: EasyConstraints?

        init(ec: EasyConstraints?) {
            self.ec = ec
            self.ec?.view?.translatesAutoresizingMaskIntoConstraints = false
        }

        @discardableResult
        public func edge(_ view: UIView, _ insets: UIEdgeInsets = .zero) -> Self {
            leading(view.leadingAnchor, insets.left)
            trailing(view.trailingAnchor, insets.right)
            top(view.topAnchor, insets.top)
            bottom(view.bottomAnchor, insets.bottom)
            return self
        }

        @discardableResult
        public func leading(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0) -> Self {
            ec?.view?.leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func trailing(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0) -> Self {
            ec?.view?.trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func left(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0) -> Self {
            ec?.view?.leftAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func right(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0) -> Self {
            ec?.view?.rightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func top(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0) -> Self {
            ec?.view?.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func bottom(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0) -> Self {
            ec?.view?.bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func centerX(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0) -> Self {
            ec?.view?.centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func centerY(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0) -> Self {
            ec?.view?.centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func firstBaseline(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0) -> Self {
            ec?.view?.firstBaselineAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func lastBaseline(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0) -> Self {
            ec?.view?.lastBaselineAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func width(_ width: CGFloat) -> Self {
            ec?.view?.widthAnchor.constraint(equalToConstant: width).isActive = true
            return self
        }

        @discardableResult
        public func height(_ height: CGFloat) -> Self {
            ec?.view?.heightAnchor.constraint(equalToConstant: height).isActive = true
            return self
        }

        @discardableResult
        public func widthAnchor(_ anchor: NSLayoutDimension, multiplier: CGFloat = 1) -> Self {
            ec?.view?.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
            return self
        }

        @discardableResult
        public func heightAnchor(_ anchor: NSLayoutDimension, multiplier: CGFloat = 1) -> Self {
            ec?.view?.heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
            return self
        }
    }

    public func make() -> ECMakeAnchor {
        return ECMakeAnchor(ec: self)
    }
}
