//
//  EasyConstraints+UIView.swift
//  EasyConstraints
//
//  Created by 박길호(파트너) - 서비스개발담당App개발팀 on 12/23/24.
//

import UIKit

extension UIView {
    public enum VIEW_ADD_TYPE  {
        case horizontal
        case vertical
    }

    private struct EasyConstraintsKey {
        nonisolated(unsafe) static var easyConstraints: UInt8 = 0
    }

    public var ec: EasyConstraints {
        return easyConstraints
    }

    private var easyConstraints: EasyConstraints {
        get {
            if let info = objc_getAssociatedObject(self, &EasyConstraintsKey.easyConstraints) as? EasyConstraints {
                return info
            }
            let info = EasyConstraints(view: self)
            objc_setAssociatedObject(self, &EasyConstraintsKey.easyConstraints, info, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return info
        }
        set {
            objc_setAssociatedObject(self, &EasyConstraintsKey.easyConstraints, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @discardableResult
    public func addSubViewAutoLayout(_ subview: UIView, edgeInsets: UIEdgeInsets = .zero) -> Self {
        self.addSubview(subview)
        return self.setSubViewAutoLayout(subview, edgeInsets: edgeInsets)
    }

    @discardableResult
    public func addSubViewAutoLayout(insertView: UIView, subview: UIView, edgeInsets: UIEdgeInsets = .zero, isFront: Bool) -> Self {
        if isFront {
            self.insertSubview(insertView, belowSubview: subview)
        }
        else {
            self.insertSubview(insertView, aboveSubview: subview)
        }
        return self.setSubViewAutoLayout(insertView, edgeInsets: edgeInsets)
    }

    @discardableResult
    private func setSubViewAutoLayout(_ subview: UIView, edgeInsets: UIEdgeInsets) -> Self {
        subview.translatesAutoresizingMaskIntoConstraints = false

        let views: Dictionary = ["subview": subview]
        let edgeInsetsDic: Dictionary = [
            "top": (edgeInsets.top),
            "left": (edgeInsets.left),
            "bottom": (edgeInsets.bottom),
            "right": (edgeInsets.right)
        ]

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(left)-[subview]-(right)-|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: edgeInsetsDic,
                                                           views: views))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(top)-[subview]-(bottom)-|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: edgeInsetsDic,
                                                           views: views))
        return self
    }

    @discardableResult
    public func addSubViewAutoLayout(subviews: [UIView],
                                     addType: VIEW_ADD_TYPE,
                                     equally: Bool,
                                     edgeInsets: UIEdgeInsets = .zero,
                                     itemSpacing: CGFloat = 0.0) -> Self {
        guard !subviews.isEmpty else { return self }

        subviews.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        if addType == .horizontal {
            if equally {
                for i in 1..<subviews.count {
                    NSLayoutConstraint.activate([
                        subviews[i].widthAnchor.constraint(equalTo: subviews.first!.widthAnchor)])
                }
            }

            NSLayoutConstraint.activate([
                subviews[0].topAnchor.constraint(equalTo: self.topAnchor, constant: edgeInsets.top),
                subviews[0].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeInsets.left),
                subviews[0].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -edgeInsets.bottom),
            ])

            for i in 1..<subviews.count {
                NSLayoutConstraint.activate([
                    subviews[i].leadingAnchor.constraint(equalTo: subviews[i-1].trailingAnchor, constant: itemSpacing),
                    subviews[i].topAnchor.constraint(equalTo: self.topAnchor, constant: edgeInsets.top),
                    subviews[i].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -edgeInsets.bottom)
                ])
            }

            NSLayoutConstraint.activate([
                subviews.last!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -edgeInsets.right)
            ])
        }
        else {
            if equally {
                for i in 1..<subviews.count {
                    NSLayoutConstraint.activate([
                        subviews[i].heightAnchor.constraint(equalTo: subviews.first!.heightAnchor)])
                }
            }

            NSLayoutConstraint.activate([
                subviews[0].topAnchor.constraint(equalTo: self.topAnchor, constant: edgeInsets.top),
                subviews[0].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeInsets.left),
                subviews[0].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -edgeInsets.right),
            ])

            for i in 1..<subviews.count {
                NSLayoutConstraint.activate([
                    subviews[i].topAnchor.constraint(equalTo: subviews[i-1].bottomAnchor, constant: itemSpacing),
                    subviews[i].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: edgeInsets.left),
                    subviews[i].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -edgeInsets.right)
                ])
            }

            NSLayoutConstraint.activate([
                subviews.last!.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -edgeInsets.bottom)
            ])
        }
        return self
    }

    @discardableResult
    public func removeSuperViewAllConstraints() -> Self {
        guard let superview: UIView = self.superview else { return self }

        for c: NSLayoutConstraint in superview.constraints {
            if c.firstItem === self || c.secondItem === self {
                superview.removeConstraint(c)
            }
        }
        return self
    }

    @discardableResult
    public func removeConstraint(attribute: NSLayoutConstraint.Attribute) -> Self {
        guard let superview: UIView = self.superview else { return self }

        for c: NSLayoutConstraint in superview.constraints {
            if c.firstItem === self && c.firstAttribute == attribute {
                superview.removeConstraint(c)
            }
            else if c.secondItem === self && c.secondAttribute == attribute {
                superview.removeConstraint(c)
            }
        }
        return self
    }

    @discardableResult
    public func removeAllConstraints() -> Self {
        self.removeSuperViewAllConstraints()
        self.removeConstraints(self.constraints)
        return self
    }

    @discardableResult
    public func addSubViewSafeArea(subView: UIView, insets: UIEdgeInsets = .zero, safeBottom: Bool = true) -> Self {
        subView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subView)

        if safeBottom {
            NSLayoutConstraint.activate([
                self.safeLeftAnchor.constraint(equalTo: subView.leftAnchor, constant: -insets.left),
                self.safeRightAnchor.constraint(equalTo: subView.rightAnchor, constant: insets.right),
                self.safeTopAnchor.constraint(equalTo: subView.topAnchor, constant: -insets.top),
                self.safeBottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: insets.bottom)
            ])
        }
        else {
            NSLayoutConstraint.activate([
                self.safeLeftAnchor.constraint(equalTo: subView.leftAnchor, constant: -insets.left),
                self.safeRightAnchor.constraint(equalTo: subView.rightAnchor, constant: insets.right),
                self.safeTopAnchor.constraint(equalTo: subView.topAnchor, constant: -insets.top),
                self.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: insets.bottom)
            ])
        }
        return self
    }
}

extension UIView {
    public var topParentViewView: UIView {
        guard let superview: UIView = superview else {
            return  self
        }
        return superview.topParentViewView
    }

    @discardableResult
    public func addSuperView(_ superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
}

// MARK: - UIView Extension SafeArea
extension UIView {
    public var safeTopAnchor: NSLayoutYAxisAnchor {
        return self.safeAreaLayoutGuide.topAnchor
    }

    public var safeLeftAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.leftAnchor
    }

    public var safeLeadingAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.leadingAnchor
    }

    public var safeRightAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.rightAnchor
    }

    public var safeTrailingAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.trailingAnchor
    }

    public var safeBottomAnchor: NSLayoutYAxisAnchor {
        return self.safeAreaLayoutGuide.bottomAnchor
    }
}
