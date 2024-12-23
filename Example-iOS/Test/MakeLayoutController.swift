//
//  MakeLayoutController.swift
//  EasyConstraintTest
//
//  Created by 박길호(파트너) - 서비스개발담당App개발팀 on 11/4/24.
//  Copyright © 2024 pkh. All rights reserved.
//

import UIKit
import EasyConstraints

class MakeLayoutController: UIViewController {
    lazy var safeView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()

    lazy var bodyView: DeinitTestView = {
        let v = DeinitTestView()
        v.backgroundColor = .gray

        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addNavigationButtons()

        self.view.addSubViewSafeArea(subView: safeView)
        self.safeView.addSubViewAutoLayout(bodyView, edgeInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))


        testEqually()
//        testNonEqually()
    }

    func addNavigationButtons() {
        if #available (iOS 13.0, *) {
            // 이미지 버튼 추가
            let image = UIImage(systemName: "equal.circle") // SF Symbols 이미지
            let firstButton = UIBarButtonItem(image: image,
                                              style: .plain,
                                              target: self,
                                              action: #selector(firstButtonTapped(_:)))

            // 두 번째 이미지 버튼
            let image2 = UIImage(systemName: "automatic.brakesignal")
            let secondButton = UIBarButtonItem(image: image2,
                                               style: .plain,
                                               target: self,
                                               action: #selector(secondButtonTapped(_:)))

            // 버튼 배열 추가
            self.navigationItem.rightBarButtonItems = [firstButton, secondButton]
        }

    }

    @objc func firstButtonTapped(_ sender: UIBarButtonItem) {
        bodyView.subviews.forEach { $0.removeFromSuperview() }
        testEqually()
    }

    @objc func secondButtonTapped(_ sender: UIBarButtonItem) {
        bodyView.subviews.forEach { $0.removeFromSuperview() }
        testAutoSize()
    }

    func testEqually() {
        var hViews: [UIView] = []
        for _ in 0..<5 {
            let horizontal = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            horizontal.backgroundColor = #colorLiteral(red: 0, green: 0.6771108508, blue: 0.3271353841, alpha: 1)
            horizontal.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            horizontal.layer.borderWidth = 3
            hViews.append(horizontal)

            var hSubViews: [UIView] = []
            for _ in 0..<5 {
                let view = UIView(frame: CGRect(x: 20, y: 20, width: 50, height: 50))
                view.backgroundColor = randomColor()
                view.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor
                view.layer.borderWidth = 1
                view.layer.cornerRadius = 10
                view.layer.masksToBounds = true
                view.translatesAutoresizingMaskIntoConstraints = false
                hSubViews.append(view)
            }
            horizontal.addSubViewAutoLayout(
                subviews: hSubViews,
                addType: .horizontal,
                equally: true,
                edgeInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                itemSpacing: 5
            )

        }

        bodyView.addSubViewAutoLayout(
            subviews: hViews,
            addType: .vertical,
            equally: true,
            edgeInsets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
            itemSpacing: 20
        )
    }

    func testAutoSize() {
        let autoSizeView = UIView()
        autoSizeView.backgroundColor = .red
        autoSizeView.addSuperView(bodyView)
            .ec.make()
            .leading(bodyView.leadingAnchor, 10)
            .top(bodyView.topAnchor, 10)

        var hViews: [UIView] = []
        for _ in 0..<5 {
            let horizontal = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            horizontal.backgroundColor = #colorLiteral(red: 0, green: 0.6771108508, blue: 0.3271353841, alpha: 1)
            horizontal.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            horizontal.layer.borderWidth = 3
            hViews.append(horizontal)

            var hSubViews: [UIView] = []
            for _ in 0..<5 {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                view.backgroundColor = randomColor()
                view.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor
                view.layer.borderWidth = 1
                view.layer.cornerRadius = 10
                view.layer.masksToBounds = true

                view.ec.make()
                    .width(view.frame.width)
                    .height(view.frame.height)

                hSubViews.append(view)
            }

            horizontal.addSubViewAutoLayout(
                subviews: hSubViews,
                addType: .horizontal,
                equally: false,
                edgeInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                itemSpacing: 5
            )

        }


        autoSizeView.addSubViewAutoLayout(
            subviews: hViews,
            addType: .vertical,
            equally: false,
            edgeInsets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
            itemSpacing: 20
        )

        let sizeCheckerView = UIView(frame: CGRect(x: 10, y: 500, width: 50, height: 50))
        sizeCheckerView.backgroundColor = .green
        sizeCheckerView.isUserInteractionEnabled = true // 사용자 인터랙션 활성화

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        sizeCheckerView.addGestureRecognizer(panGesture)
        self.bodyView.addSubview(sizeCheckerView)
    }

    // UIPanGestureRecognizer 이벤트 핸들러
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let draggedView = gesture.view else { return }

        // 드래그된 위치 계산
        let translation = gesture.translation(in: self.view)

        // 뷰의 중심점을 이동
        draggedView.center = CGPoint(
            x: draggedView.center.x + translation.x,
            y: draggedView.center.y + translation.y
        )

        // 제스처의 translation을 초기화 (누적 이동을 방지)
        gesture.setTranslation(.zero, in: self.view)
    }
}

class DeinitTestView: UIView {
    deinit {
        print("\(String(describing: type(of: self))) \(#function)")
    }
}
