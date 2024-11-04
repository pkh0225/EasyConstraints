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
        safeView.backgroundColor = .lightGray
        self.view.addSubViewSafeArea(subView: safeView)

        let bodyView = UIView()
        bodyView.backgroundColor = .gray
        self.view.addSubViewSafeArea(subView: bodyView, insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))


        var hViews: [UIView] = []
        for _ in 0..<5 {
            let horizontal = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            horizontal.backgroundColor = #colorLiteral(red: 0, green: 0.6771108508, blue: 0.3271353841, alpha: 1)
            horizontal.layer.borderColor = UIColor.black.cgColor
            horizontal.layer.borderWidth = 3
            hViews.append(horizontal)

            var hSubViews: [UIView] = []
            for _ in 0..<5 {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
                view.backgroundColor = randomColor()
                view.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor
                view.layer.borderWidth = 1
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
