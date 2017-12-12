//
//  ViewController.swift
//  realmProject
//
//  Created by 澤田昂明 on 2017/11/30.
//  Copyright © 2017年 澤田昂明. All rights reserved.
//
//Realmを用いたサンプルプログラムを示す．

import UIKit


class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var table:UITableView!
    var usersData = [Person]()
    let user = Person()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        table.estimatedRowHeight = 130
        table.rowHeight = UITableViewAutomaticDimension
        self.table.register(UINib(nibName: "RealmTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //読み込み
        usersData = Person.loadAll()
        print(usersData.count)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RealmTableViewCell
        
        //セルにテキストを挿入
        cell.titleLabel?.text = usersData[indexPath.row].title
        cell.contentsLabel?.text = usersData[indexPath.row].contents
        cell.themeImageView?.image = usersData[indexPath.row].image
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //記入画面に遷移する
    @IBAction func toWritingView(){
        self.performSegue(withIdentifier: "writeContents", sender: nil)
    }

    

}


