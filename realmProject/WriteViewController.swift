//
//  WriteViewController.swift
//  realmProject
//
//  Created by 澤田昂明 on 2017/12/05.
//  Copyright © 2017年 澤田昂明. All rights reserved.
//

import UIKit


class WriteViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var contentsTextView:UITextView!
    
    @IBOutlet var imageView:UIImageView!
    var inputImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        imageView.image = inputImage
    }
    
    func post(){
        
        let user = Person.create()
        //値の代入
        if let tmpTitle = titleTextField.text{
            user.title = tmpTitle
        }
        if let tmpContents = contentsTextView.text{
            user.contents = tmpContents
        }
        if let tmpImage = inputImage{
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
    
    


}
