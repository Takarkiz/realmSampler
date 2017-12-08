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
    @objc dynamic private var imageData: NSData? = nil
    
    //画像をSetすればdata型に変換する
    //画像を取得しよとするとdataから変換して返す
    @objc dynamic var image: UIImage? {
        set{
            self._image = newValue
            if let value = newValue {
                self.imageData = UIImagePNGRepresentation(value)! as NSData
            }
        }
        get{
            if let image = self._image {
                return image
            }
            if let data = self.imageData {
                self._image = UIImage(data: data as Data)
                return self._image
            }
            return nil
        }
    }
    
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
        return ret
    }
    
    // addのみ
    func save() {
        try! Person.realm.write {
            Person.realm.add(self)
        }
    }
    
    func update(method: (() -> Void)) {
        try! Person.realm.write {
            method()
        }
    }
    
}
