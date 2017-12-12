//
//  WriteViewController.swift
//  realmProject
//
//  Created by 澤田昂明 on 2017/12/05.
//  Copyright © 2017年 澤田昂明. All rights reserved.
//

import UIKit


class WriteViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate {

    let user = Person.create()
    
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var contentsTextView:UITextView!
    
    @IBOutlet var imageView:UIImageView!
    var inputImage:UIImage?
    var resizeImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        contentsTextView.delegate = self

        //textViewに薄文字を表示さえておく(まだわからん)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //フォトライブラリでの選択終了後に呼ばれる
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //選択した画像を代入
        inputImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        //フォトライブラリを閉じる
        self.dismiss(animated: true, completion: nil)
        resizeImage = resize(image: inputImage!, width: 50, height: 50)
        imageView.image = resizeImage
        
    }
    
    //フォトライブラリを開く準備をする．
    func prepareForPhotoLibrary(){
        //UIImagePickerControllerのインスタンスを作る
        let imagePickerController:UIImagePickerController = UIImagePickerController()
        
        //フォトライブラリを使う設定をする
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        //フォトライブラリを呼び出す
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func choiceImage(){
        prepareForPhotoLibrary()
        
    }
    
    func post(){
        //値の代入
        if let tmpTitle = titleTextField.text{
            user.title = tmpTitle
        }
        if let tmpContents = contentsTextView.text{
            user.contents = tmpContents
        }
        if let tmpImage = resizeImage{
            user.image = tmpImage
        }
        
        user.save()
    }
    
    //送信ボタンを押した処理
    @IBAction func uploadData(){
        post()
        self.performSegue(withIdentifier: "back", sender: nil)
    }
    
    //同じIdだった場合にアップデートの処理を行う
    func update(){
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //画像のリサイズを行う
    func resize(image: UIImage, width: Int, height: Int) -> UIImage {
        
        //let imageRef: CGImage = image.cgImage!
//        var sourceWidth: Int = CGImageGetWidth(imageRef)!
//        var sourceHeight: Int = CGImageGetHeight(imageRef)!
        //var sourceWidth: Int = CGImageSource
        
        let size: CGSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(size)
        
        let _rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        image.draw(in: _rect)
        
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizeImage!
    }
    
    


}
