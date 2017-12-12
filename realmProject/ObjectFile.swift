//
//  ObjectFile.swift
//  realmProject
//
//  Created by 澤田昂明 on 2017/11/30.
//  Copyright © 2017年 澤田昂明. All rights reserved.
//

import Foundation
import RealmSwift

class Person: Object{
    
    static let realm = try! Realm()
    
    @objc dynamic var title = ""
    @objc dynamic var contents = ""
    @objc dynamic var id = 0
    //@objc dynamic var image:UIImage? = nil
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
    @objc dynamic private var _image: UIImage? = nil
    //@objc dynamic private var imageData: Data? = nil
    @objc dynamic private var encodingString:String = ""
    
    //エンコードデコードを追加したsetter,getterの処理
    //エンコードしても画像が大きすぎるそう
    @objc dynamic var image: UIImage? {
        set{
            self._image = newValue
            if let value = newValue{
                let imageData = UIImagePNGRepresentation(value)! as Data
                encodingString = (imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters))
            }
        }
        get{
            if let image = self._image{
                return image
            }
            //BASE64の文字列をデコードしてNSDataを生成
            //let decodeBase64:Data? = Data(base64EncodedString:encodingString, options:Data.Base64DecodingOptions.IgnoreUnknownCharacters)
            let decodeBase64: Data? = Data(base64Encoded: encodingString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
            
            //NSDataの生成が成功していたら
            if let decodeSuccess = decodeBase64 {
                
                //NSDataからUIImageを生成
                let img = UIImage(data: decodeSuccess)
                
                //結果を返却
                return img
            }
            
            return nil
        }
    }
    
    //画像をSetすればdata型に変換する
    //画像をgetしよとするとdataから変換して返す
//    @objc dynamic var image: UIImage? {
//        set{
//            self._image = newValue
//            if let value = newValue {
//                self.imageData = UIImagePNGRepresentation(value)! as Data
//                //BASE64のStringに変換する
//                //encodingString = (imageData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters))!
//            }
//        }
//        get{
//            if let image = self._image {
//                return image
//            }
//            if let data = self.imageData {
//                self._image = UIImage(data: data as Data)
//                return self._image
//            }
//            return nil
//        }
//    }
    
    //image,_imageの保存を無視する→保持するのはimageDataのみ
    override static func ignoredProperties() -> [String] {
        return ["image", "_image"]
    }
    
    //Idを生成する
    static func lastId() -> Int {
        if let user = realm.objects(Person.self).last {
            return user.id + 1
        } else {
            return 1
        }
    }
    
    //userIdを作成する
    static func create() -> Person {
        let user = Person()
        user.id = lastId()
        return user
    }
    
    //値を取得する
    static func loadAll() -> [Person] {
        let users = realm.objects(Person.self).sorted(byKeyPath: "id", ascending: false)
        var ret: [Person] = []
        for user in users {
            ret.append(user)
        }
        print("LoadDone!")
        return ret
    }
    
    static func loadOneObject() -> [Person]{
        let optionusers = realm.objects(Person.self).filter("title == '宇多田ヒカル'")
        
        var ret: [Person] = []
        for user in optionusers {
            ret.append(user)
        }
        print("LoadDone!")
        return ret
        
    }
    
    // addのみ
    func save() {
        try! Person.realm.write {
            Person.realm.add(self)
        }
        print("SaveDone!")
    }
    
    func update(method: (() -> Void)) {
        try! Person.realm.write {
            method()
        }
    }
    
}
