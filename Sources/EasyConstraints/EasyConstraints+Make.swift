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
        private weak var view: UIView?

        init(view: UIView?) {
            view?.translatesAutoresizingMaskIntoConstraints = false
            self.view = view
        }

        @discardableResult
        public func leading(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat) -> Self {
            view?.leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func trailing(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat) -> Self {
            view?.trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func left(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat) -> Self {
            view?.leftAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func right(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat) -> Self {
            view?.rightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func top(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat) -> Self {
            view?.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func bottom(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat) -> Self {
            view?.bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func centerX(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat) -> Self {
            view?.centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func centerY(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat) -> Self {
            view?.centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func firstBaseline(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat) -> Self {
            view?.firstBaselineAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func lastBaseline(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat) -> Self {
            view?.lastBaselineAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            return self
        }

        @discardableResult
        public func width(_ width: CGFloat) -> Self {
            view?.widthAnchor.constraint(equalToConstant: width).isActive = true
            return self
        }

        @discardableResult
        public func height(_ height: CGFloat) -> Self {
            view?.heightAnchor.constraint(equalToConstant: height).isActive = true
            return self
        }

        @discardableResult
        public func widthAnchor(_ anchor: NSLayoutDimension, multiplier: CGFloat) -> Self {
            view?.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
            return self
        }

        @discardableResult
        public func heightAnchor(_ anchor: NSLayoutDimension, multiplier: CGFloat) -> Self {
            view?.heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
            return self
        }
    }

    public func make() -> ECMakeAnchor {
        return ECMakeAnchor(view: self.view)
    }
}
