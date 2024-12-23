//
//  EasyConstraints+ECPriority.swift
//  EasyConstraints
//
//  Created by 박길호(파트너) - 서비스개발담당App개발팀 on 12/23/24.
//

import UIKit

@MainActor
extension EasyConstraints {
    @MainActor
    public struct ECPriority {
        public weak var ec: EasyConstraints?

        init(ec: EasyConstraints?) {
            ec?.view?.translatesAutoresizingMaskIntoConstraints = false
            self.ec = ec
        }

        @discardableResult
        public func leading(_ priority: UILayoutPriority) -> Self {
            ec?.getLayoutConstraint(.leading)?.priority = priority
            return self
        }

        @discardableResult
        public func trailing(_ priority: UILayoutPriority) -> Self {
            ec?.getLayoutConstraint(.trailing)?.priority = priority
            return self
        }

        @discardableResult
        public func left(_ priority: UILayoutPriority) -> Self {
            ec?.getLayoutConstraint(.left)?.priority = priority
            return self
        }

        @discardableResult
        public func right(_ priority: UILayoutPriority) -> Self {
            ec?.getLayoutConstraint(.right)?.priority = priority
            return self
        }

        @discardableResult
        public func top(_ priority: UILayoutPriority) -> Self {
            ec?.getLayoutConstraint(.top)?.priority = priority
            return self
        }

        @discardableResult
        public func bottom(_ priority: UILayoutPriority) -> Self {
            ec?.getLayoutConstraint(.bottom)?.priority = priority
            return self
        }

        @discardableResult
        public func centerX(_ priority: UILayoutPriority) -> Self {
            ec?.getLayoutConstraint(.centerX)?.priority = priority
            return self
        }

        @discardableResult
        public func centerY(_ priority: UILayoutPriority) -> Self {
            ec?.getLayoutConstraint(.centerY)?.priority = priority
            return self
        }

        @discardableResult
        public func firstBaseline(_ priority: UILayoutPriority) -> Self {
            ec?.getLayoutConstraint(.firstBaseline)?.priority = priority
            return self
        }

        @discardableResult
        public func lastBaseline(_ priority: UILayoutPriority) -> Self {
            ec?.getLayoutConstraint(.lastBaseline)?.priority = priority
            return self
        }

        @discardableResult
        public func width(_ priority: UILayoutPriority) -> Self {
            ec?.getLayoutConstraint(.width)?.priority = priority
            return self
        }

        @discardableResult
        public func height(_ priority: UILayoutPriority) -> Self {
            ec?.getLayoutConstraint(.height)?.priority = priority
            return self
        }
    }

    public func priority() -> ECPriority {
        return ECPriority(ec: self)
    }
}
