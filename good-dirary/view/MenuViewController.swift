//
//  MenuViewController.swift
//  good-dirary
//
//  Created by high on 2018. 1. 27..
//  Copyright © 2018년 high. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
}
