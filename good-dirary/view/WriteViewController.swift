//
//  WriteViewController.swift
//  good-dirary
//
//  Created by high on 2018. 1. 21..
//  Copyright © 2018년 high. All rights reserved.
//
import UIKit

class WriteViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func configureView() {
        // Update the user interface for the detail item.
        let saveButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContent(contents:)))
       navigationItem.rightBarButtonItem = saveButton
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
    
    @objc func addContent(contents:Any) {
        
    }
    
}

