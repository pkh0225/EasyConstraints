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
        public func leading(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
            case .lessThanOrEqual:
                ec?.view?.leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func trailing(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
            case .lessThanOrEqual:
                ec?.view?.trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func left(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.leftAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.leftAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
            case .lessThanOrEqual:
                ec?.view?.leftAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func right(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.rightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.rightAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
            case .lessThanOrEqual:
                ec?.view?.rightAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func top(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
            case .lessThanOrEqual:
                ec?.view?.topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func bottom(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
            case .lessThanOrEqual:
                ec?.view?.bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func centerX(_ anchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.centerXAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
            case .lessThanOrEqual:
                ec?.view?.centerXAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func centerY(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.centerYAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
            case .lessThanOrEqual:
                ec?.view?.centerYAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func firstBaseline(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.firstBaselineAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.firstBaselineAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
            case .lessThanOrEqual:
                ec?.view?.firstBaselineAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func lastBaseline(_ anchor: NSLayoutYAxisAnchor, _ constant: CGFloat = 0, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.lastBaselineAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.lastBaselineAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
            case .lessThanOrEqual:
                ec?.view?.lastBaselineAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func width(_ constant: CGFloat, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.widthAnchor.constraint(equalToConstant: constant).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
            case .lessThanOrEqual:
                ec?.view?.widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func height(_ constant: CGFloat, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.heightAnchor.constraint(equalToConstant: constant).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
            case .lessThanOrEqual:
                ec?.view?.heightAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func widthAnchor(_ anchor: NSLayoutDimension, multiplier: CGFloat = 1, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.widthAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier).isActive = true
            case .lessThanOrEqual:
                ec?.view?.widthAnchor.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier).isActive = true
            @unknown default:
                return self
            }
            return self
        }

        @discardableResult
        public func heightAnchor(_ anchor: NSLayoutDimension, multiplier: CGFloat = 1, _ relation: NSLayoutConstraint.Relation = .equal) -> Self {
            switch relation {
            case .equal:
                ec?.view?.heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
            case .greaterThanOrEqual:
                ec?.view?.heightAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier).isActive = true
            case .lessThanOrEqual:
                ec?.view?.heightAnchor.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier).isActive = true
            @unknown default:
                return self
            }
            return self
        }
    }

    public func make() -> ECMakeAnchor {
        return ECMakeAnchor(ec: self)
    }
}
