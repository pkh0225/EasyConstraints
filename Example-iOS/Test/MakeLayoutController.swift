//
//  MakeLayoutController.swift
//  EasyConstraintTest
//
//  Created by 박길호(파트너) - 서비스개발담당App개발팀 on 11/4/24.
//  Copyright © 2024 pkh. All rights reserved.
//

import UIKit

class MakeLayoutController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let safeView = UIView()
        safeView.backgroundColor = randomColor()
        self.view.addSubViewSafeArea(subView: safeView)

        let bodyView = UIView()
        bodyView.backgroundColor = randomColor()
        self.view.addSubViewSafeArea(subView: bodyView, insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))


        var hViews: [UIView] = []
        for _ in 0..<5 {
            let horizontal = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            horizontal.backgroundColor = randomColor()
            horizontal.layer.borderColor = UIColor.black.cgColor
            horizontal.layer.borderWidth = 5
            hViews.append(horizontal)

            var hSubViews: [UIView] = []
            for _ in 0..<5 {
                let view = UIView()
                view.backgroundColor = randomColor()
                hSubViews.append(view)
            }
            horizontal.addSubViewAutoLayout(subviews: hSubViews,
                                            addType: .horizontal,
                                            edgeInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                                            itemSpacing: 5,
                                            isSquare: true)

        }


        bodyView.addSubViewAutoLayout(subviews: hViews,
                                      addType: .vertical,
                                      edgeInsets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                                      itemSpacing: 20,
                                      isSquare: true)

    }
}
