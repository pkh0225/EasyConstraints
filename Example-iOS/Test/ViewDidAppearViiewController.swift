//
//  viewDidAppearViiewController.swift
//  EasyConstraintTest
//
//  Created by 박길호(파트너) - 서비스개발담당App개발팀 on 2022/10/31.
//  Copyright © 2022 pkh. All rights reserved.
//

import UIKit

class ViewDidAppearViiewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UITest2Cell", for: indexPath) as! UITest2Cell
            cell.collectioinView.backgroundColor = .random
            cell.tag = indexPath.row
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UITestCell", for: indexPath) as! UITestCell
            
            cell.label.text = "\(indexPath.row)"
            cell.backgroundColor = .random
            cell.tag = indexPath.row
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let viewDidAppear = cell.viewDidAppear {
            cell.viewDidAppearIsVisible = true
            viewDidAppear(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let viewDidAppear = cell.viewDidAppear {
            cell.viewDidAppearIsVisible = false
            viewDidAppear(false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "AutoLayoutController") as! AutoLayoutController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.frame.size.width, height: 128)
        }
        return CGSize(width: collectionView.frame.size.width, height: 300)
    }
}

class UITestCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.viewDidAppear = { isShow in
            print("\n111 viewDidAppear: \(self.tag) : \(isShow)")
        }
        self.isImpressionCheckZone = true
        self.impressionLog = {
            print("222 impressionLog: \(self.tag)")
        }
    }
}

class UITest2Cell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectioinView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UITest2SubCell", for: indexPath) as! UITest2SubCell
        
        cell.label.text = "\(indexPath.row)"
        cell.backgroundColor = .random
        cell.tag = indexPath.row
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let viewDidAppear = cell.viewDidAppear {
            cell.viewDidAppearIsVisible = true
            viewDidAppear(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let viewDidAppear = cell.viewDidAppear {
            cell.viewDidAppearIsVisible = false
            viewDidAppear(false)
        }
    }
    
}

class UITest2SubCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.viewDidAppear = { isShow in
            print("\n333 viewDidAppear: \(self.tag) : \(isShow)")
        }
        self.isImpressionCheckZone = true
        self.impressionLog = {
            print("444 impressionLog: \(self.tag)")
        }
    }
}



extension UIColor {
    public class var random: UIColor {
        let r: CGFloat = CGFloat(arc4random() % 11) / 10.0
        let g: CGFloat = CGFloat(arc4random() % 11) / 10.0
        let b: CGFloat = CGFloat(arc4random() % 11) / 10.0
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
