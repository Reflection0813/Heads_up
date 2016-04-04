//
//  write.swift
//  Heads_up
//
//  Created by inada on 2016/01/26.
//  Copyright © 2016年 inada. All rights reserved.
//

import Foundation
import UIKit
import GoogleMobileAds

class write:UIViewController, UITextFieldDelegate,GADBannerViewDelegate{
    
    var temp:[String] = []
    var cateMode = 0
    var cateMode_2 = 0
    var flag = 0
    var arr1:[String] = []
    var arr3:[String] = []
    
    var regAL:UIAlertController = UIAlertController(title: "登録", message: "登録しますか？", preferredStyle: UIAlertControllerStyle.Alert)
    var catAL:UIAlertController = UIAlertController(title: "カテゴリー", message: "カテゴリ名を入力してください", preferredStyle: UIAlertControllerStyle.Alert)
    var comAL:UIAlertController = UIAlertController(title: "完了", message: "作業が完了しました", preferredStyle: UIAlertControllerStyle.Alert)
    var choAL:UIAlertController = UIAlertController(title: "カテゴリー", message: "カテゴリー名を選択してください", preferredStyle: UIAlertControllerStyle.Alert)
    var disAL:UIAlertController = UIAlertController(title: "削除", message: "削除するカテゴリー名を選択してください", preferredStyle: UIAlertControllerStyle.Alert)
    let cancelAction = UIAlertAction(title: "キャンセル", style: .Default, handler: nil)
    
    /*let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("detail")
    nextVC?.modalTransitionStyle = .CrossDissolve
    presentViewController(nextVC!, animated:true, completion:nil)*/
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var box1: UITextField!
    @IBOutlet weak var box2: UITextField!
    @IBOutlet weak var box3: UITextField!
    @IBOutlet weak var box4: UITextField!
    @IBOutlet weak var box5: UITextField!
    @IBOutlet weak var box6: UITextField!
    @IBOutlet weak var box7: UITextField!
    @IBOutlet weak var box8: UITextField!
    @IBOutlet weak var box9: UITextField!
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBAction func regist(sender: AnyObject) {
        
        /*
        for var i = 1;i <= 9; i++ {
            temp.append(box\(i).text)
        }*/
        
        if box1.text != ""{
            temp.append(box1.text!)}
        if box2.text != ""{
            temp.append(box2.text!)}
        if box3.text != ""{
            temp.append(box3.text!)}
        if box4.text != ""{
            temp.append(box4.text!)}
        if box5.text != ""{
            temp.append(box5.text!)}
        if box6.text != ""{
            temp.append(box6.text!)}
        if box7.text != ""{
            temp.append(box7.text!)}
        if box8.text != ""{
            temp.append(box8.text!)}
        if box9.text != ""{
            temp.append(box9.text!)}
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        /*
        var currentCount = defaults.integerForKey("count")
        currentCount++

        defaults.setInteger(currentCount, forKey:"count")
        defaults.synchronize()

        
        // 各配列を個別に持つパターン
        defaults.setObject(temp, forKey: "questions_\(currentCount)") //"questions_" + currentCount
        defaults.synchronize()
        var all:[[String]] = []
        for var i = 0; i < currentCount; i++ {
            var arr = defaults.objectForKey("questions_\(currentCount)") as! [String]
            all.append(arr)
        }
        
        print(all)

        */
        /*
        // 二重配列を持つバターン
        var arr2:[[String]]!
        if var _arr2 = defaults.objectForKey("questions") as? [[String]] {
            arr2 = _arr2
        } else {
            arr2 = []
        }
        arr2.append(temp)
        defaults.setObject(arr2, forKey: "questions")
        defaults.synchronize()
        let newArr = defaults.objectForKey("questions") as! [[String]]
        
        
        //もたないパターン
        var arr3:[String]!
        if let _arr3 = self.defaults.objectForKey("questions") as? [String] {
        arr3 = _arr3
        } else {
        arr3 = []
        }
        
        for t in temp {
        arr3.append(t)
        }
        self.defaults.setObject(arr3, forKey: "questions")
        self.defaults.synchronize()
        
        let newArr = self.defaults.objectForKey("questions") as! [String]
        print("現在の登録内容=\(newArr)")
        
        
        temp.removeAll()
        
        let alert = UIAlertView()
        alert.title = "登録完了"
        alert.message = "問題の登録が完了しました。"
        alert.addButtonWithTitle("OK")
        alert.show()
        
        */
        
        
        
        
        
        
        
        
        self.presentViewController(regAL, animated: true, completion: {
        })
        
    }
    
    
    func discard(mode:Int){
        var arr2:[[String]]!
        if var _arr2 = defaults.objectForKey("question") as? [[String]] {
            arr2 = _arr2
        } else {
            print("削除エラー")
            arr2 = []
        }
        
        var catarr:[String]!
        if let k = defaults.objectForKey("category") as? [String] {
            catarr = k
        } else {
            print("削除エラー")
            catarr = []
        }
        
        arr2.removeAtIndex(mode)
        catarr.removeAtIndex(mode)
        print(arr2)
        print(catarr)
        defaults.setObject(arr2, forKey: "question")
        defaults.setObject(catarr, forKey: "category")
        
        self.presentViewController(self.comAL, animated: true, completion: {
        })
        
        
    }
    
    
    func register(){
        var arr2:[[String]]!
        if var _arr2 = defaults.objectForKey("question") as? [[String]] {
            arr2 = _arr2
        } else {
            print("else通過")
            arr2 = []
        }
        /*
        [["りんご","みかん"]["たぬき","きつね"]]
        */
        //print("register;arr2[self.catemode] = \(arr2[self.cateMode])")
        print("register:cateMode =\(cateMode)")
        if arr2 == []{
            arr2.append(temp)
        }else if flag == 1 {
            print("catemodeが空")
            arr2.append(temp)
            flag = 0
        } else{
            arr2[self.cateMode] += temp
        }
        defaults.setObject(arr2, forKey: "question")
        defaults.synchronize()
        let newArr = defaults.objectForKey("question") as! [[String]]
        
        print("question =\(newArr)")
        
        
        temp.removeAll()
        
        self.presentViewController(self.comAL, animated: true, completion: {
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        box1.delegate = self
        box2.delegate = self
        box3.delegate = self
        box4.delegate = self
        box5.delegate = self
        box6.delegate = self
        box7.delegate = self
        box8.delegate = self
        box9.delegate = self
        
        self.bannerView.adUnitID = "ca-app-pub-9818638593780439/6972715503"
        bannerView.delegate = self
        bannerView.rootViewController = self
        let gadRequest:GADRequest = GADRequest()
        gadRequest.testDevices = [kGADSimulatorID]  // テスト時のみ
        bannerView.loadRequest(gadRequest)
        
        
        //Define registerALert
        //もしすでにカテゴリーが存在するとき、カテゴリー選択のアラートを出す
        //存在しないらば、カテゴリー名を入力させる
        let reg = UIAlertAction(title: "登録する", style: .Default){(action) in
            self.box1.text = ""
            self.box2.text = ""
            self.box3.text = ""
            self.box4.text = ""
            self.box5.text = ""
            self.box6.text = ""
            self.box7.text = ""
            self.box8.text = ""
            self.box9.text = ""
            if self.defaults.objectForKey("category") == nil{
                self.presentViewController(self.catAL, animated: true, completion: {
                })
            }else{
                self.presentViewController(self.choAL, animated: true, completion: {
                })
                
            }
            
        }
        regAL.addAction(self.cancelAction)
        regAL.addAction(reg)
        
        
        //Define chooseAlert
        //カテゴリーをアクションとして追加している
        //cateModeはあとの二重配列の添え字として使う
        if let _arr1 = defaults.objectForKey("category") as? [String]{
            
            arr1 = _arr1
            var i = 0
            for elem in arr1{
                //hoge(i)
                var category = i
                let temp = UIAlertAction(title: elem, style: .Default){[category](action) in
                    self.cateMode = category
                   
                    self.register()
                }
                i++
                
                print("cateMode = \(cateMode)")
                choAL.addAction(temp)
            }
        }
        
        let other = UIAlertAction(title: "新しくカテゴリーを作成する", style: .Default){(action) in
            self.cateMode = self.arr1.count
            self.flag = 1
            print("flag = \(self.flag)")
            self.presentViewController(self.catAL, animated: true, completion: {
            })
            
        }
        if self.defaults.objectForKey("category") == nil || self.defaults.objectForKey("category")!.count <= 4 {
            choAL.addAction(other)
        }
        choAL.addAction(self.cancelAction)
        
        //Define categoryAlert
        //カテゴリー名はユーザデフォルトの配列
        catAL.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
            text.placeholder = "カテゴリー名"
        })
        
        let complete = UIAlertAction(title: "入力完了", style: .Default){(action) in
            let textFields:Array<UITextField>? =  self.catAL.textFields as Array<UITextField>?
            if textFields != nil{
                
                for textField:UITextField in textFields! {
                    var arr2:[String]!
                    if let _arr2 = self.defaults.objectForKey("category") as? [String] {
                        arr2 = _arr2
                    } else {
                        arr2 = []
                    }
                    arr2.append(textField.text!)
                    self.defaults.setObject(arr2, forKey: "category")
                    self.register()
                    
                    let abc = self.defaults.objectForKey("category") as! [String]
                    print("カテゴリーは\(abc)")
                }
            }
        }
        catAL.addAction(cancelAction)
        catAL.addAction(complete)
        
        
        //Define completeAL
        let finish = UIAlertAction(title: "OK", style: .Default){(action) in
            let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("menu")
            nextVC?.modalTransitionStyle = .CrossDissolve
            self.presentViewController(nextVC!, animated:true, completion:nil)
            
        }
        comAL.addAction(finish)
        
        //Define dismissAL
        if let _arr2 = defaults.objectForKey("category") as? [String]{
            
            arr3 = _arr2
            var i = 0
            for elem in arr3{
                //hoge(i)
                var category = i
                let temp = UIAlertAction(title: elem, style: .Default){[category](action) in
                    self.cateMode_2 = category
                    
                    self.discard(self.cateMode_2)
                }
                i++
                
                disAL.addAction(temp)
            }
        }
        disAL.addAction(self.cancelAction)
        
        
        
    }// end of viewdidload
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range:NSRange,replacementString string: String) ->Bool{
        
        var tmpStr = textField.text! as NSString
        tmpStr = tmpStr.stringByReplacingCharactersInRange(range, withString: string)
        print(tmpStr)
        
        return true
    }
    
    
    //Enterを押したときに呼び出される
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder()
        print("enter")
        
        return false
    }
    
    
}

