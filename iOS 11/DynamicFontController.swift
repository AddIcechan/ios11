//
//  DynamicFontController.swift
//  iOS 11
//
//  Created by ADDICE on 2017/8/9.
//  Copyright © 2017年 ADDICE. All rights reserved.
//

import UIKit

class DynamicFontController: UIViewController {

    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel! {
        didSet {
            lbl2.font = UIFont.preferredFont(forTextStyle: .body)
            lbl2.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet weak var lbl3: UILabel! {
        didSet {
            let metrics = UIFontMetrics(forTextStyle: .body)
            lbl3.font = metrics.scaledFont(for: UIFont.systemFont(ofSize: 10))
            lbl3.adjustsFontForContentSizeCategory = true
        }
    }
    
    @IBOutlet weak var lbl4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if UIApplication.shared.preferredContentSizeCategory > .accessibilityExtraExtraLarge {
            
        } else {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
