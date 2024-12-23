//
//  AutoLayoutController.swift
//  Test
//
//  Created by pkh on 2018. 8. 14..
//  Copyright © 2018년 pkh. All rights reserved.
//

import UIKit
import EasyConstraints

class AutoLayoutController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var textField6: UITextField!
    @IBOutlet weak var textField7: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultConstrains()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setDefaultConstrains()  {
        // default test
        textField1.text = "\(view1.ec.leadingDefault)"
        textField2.text = "\(view1.ec.trailingDefault)"
        textField7.text = "\(view1.ec.bottom)"
        textField3.text = "\(view2.ec.topDefault)"
        textField4.text = "\(view2.ec.trailingDefault)"
        textField5.text = "\(view2.ec.widthDefault)"
        textField6.text = "\(view2.ec.heightDefault)"


        // rest test
        view1.ec.reset(.leading, .trailing)
        view2.ec.reset(.top, .trailing, .width, .height)


        // left test
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .red
        v.addSuperView(self.view4)
        v.ec.make()
            .top(view4.topAnchor, 0)
            .left(view4.leftAnchor, 10)
            .width(50)
            .height(50)

        print(v.ec.left)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            v.ec.left(50)
        }


    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onView1Leading(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view1.ec.leading(value)
        }
    }
    
    @IBAction func onView1Trailing(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view1.ec.trailing = value
        }
    }

    @IBAction func onView1Bottom(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view1.ec.bottom = value
        }
    }

    @IBAction func onView2Top(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view2.ec.top = value
        }
    }
    
    @IBAction func onView2Trailing(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view2.ec.trailing = value
        }
    }
    
    @IBAction func onView2Width(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view2.ec.width = value
        }
    }
    
    @IBAction func onView2Height(_ sender: UITextField) {
        if let value = sender.text?.toCGFloat() {
            view2.ec.height = value
        }
    }
    
    @IBAction func onDefaultContraints(_ sender: Any) {
        setDefaultConstrains()
    }
    
    @IBAction func onGone(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        view3.ec.gone = sender.isSelected
        
        if sender.isSelected {
            sender.setTitle("No Gone", for: .normal)
        }
        else {
            sender.setTitle("Gone", for: .normal)
        }
    }
}

extension String {
    public func toCGFloat() -> CGFloat {
        if let num = NumberFormatter().number(from: self) {
            return CGFloat(num.floatValue)
        }
        else {
            return 0
        }
    }
}
