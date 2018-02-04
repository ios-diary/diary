//
//  WriteViewController.swift
//  good-dirary
//
//  Created by high on 2018. 1. 21..
//  Copyright © 2018년 high. All rights reserved.
//
import UIKit

class WriteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var imagePager: UIPageControl!
    
    var itemIndex = 0
    var imageName = "" {
        didSet{
            if let imgView = imageView{
                imgView.image = UIImage(named: imageName)
            }
        }
    }
    var imgList: [UIImage] = []
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        navigationItem.rightBarButtonItem = saveButton
        imageView.image = UIImage(named: imageName)
        picker.delegate = self
        self.imagePager.hidesForSinglePage = true;
    }
    
    @IBAction func addImage(_ sender: Any) {
        let alert =  UIAlertController(title: "이미지", message: "어디서 가져올지 선택해주세요", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) {
            (action) in self.openLibrary()
        }
        let camera =  UIAlertAction(title: "카메라", style: .default) {
            (action) in self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func setPager() {
        if imgList.count > 0 {
            
        }
    }
    
    func openLibrary(){
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        }
        else{
            print("Camera not available")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imgList.append(image);
            imageView.image = image
            print(info)
        }
        self.imageView.animationImages = imgList;
        self.imageView.animationDuration = 60.0
        self.imageView.animationRepeatCount = 0
        self.imageView.startAnimating()
        dismiss(animated: true, completion: nil)
    }
    
    func configureView() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContent(contents:)))
       navigationItem.rightBarButtonItem = saveButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func addContent(contents:Any) {
        
    }
    
}

