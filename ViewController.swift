//
//  ViewController.swift
//  Heads_up
//
//  Created by inada on 2015/11/25.
//  Copyright © 2015年 inada. All rights reserved.
//

import UIKit
import MobileCoreServices
import GoogleMobileAds

class ViewController: UIViewController, UITextFieldDelegate,GADBannerViewDelegate, ADFmyMovieRewardDelegate,GADInterstitialDelegate{
    //instances
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    //variables
    var AdAlert:UIAlertController = UIAlertController(title: "解放条件", message: "このモードを解放するには動画を見る必要があります", preferredStyle: UIAlertControllerStyle.Alert)
    var catAL:UIAlertController = UIAlertController(title: "カテゴリー", message: "カテゴリーを選択してください", preferredStyle: UIAlertControllerStyle.Alert)
    var disAL:UIAlertController = UIAlertController(title: "削除", message: "削除するカテゴリー名を選択してください", preferredStyle: UIAlertControllerStyle.Alert)
    var comAL:UIAlertController = UIAlertController(title: "完了", message: "作業が完了しました", preferredStyle: UIAlertControllerStyle.Alert)
    let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
    
    var arr1:[String] = []
    var arr3:[String] = []
    var cateMode_2 = 0
    var _interstitial:GADInterstitial?
    
    var params = ["locationid": "32769", "adtype": 0 , "originx":0 , "originy":0]
    
    //Outlets
 

    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var setting: UITextField!
    @IBOutlet weak var btn_all: UIButton!
    @IBOutlet weak var btn_1: UIButton!

    @IBOutlet weak var btn_2: UIButton!
    
    @IBOutlet weak var viewBtns: UIView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var btn_t: UIButton!
    @IBOutlet weak var btn_q: UIButton!


    

   @IBAction func setting1(sender: AnyObject) {
        appDelegate.set = 60
        setting.text = "60"
        label1.text = "時間を設定してください"
        label2.text = "秒"
        appDelegate.radio = 0   //radio button
    btn_t.setImage(UIImage(named:"Select_Time_On"),forState: UIControlState.Normal)
    btn_q.setImage(UIImage(named:"Select_Question_Off"),forState: UIControlState.Normal)
    }


    @IBAction func setting2(sender: AnyObject) {
        appDelegate.set = 5
        setting.text = "5"
        label1.text = "問題数を設定してください"
        label2.text = "問"
        appDelegate.radio = 1   //radio button
        //defaults.setBool(true,forKey: "sw1")
        btn_t.setImage(UIImage(named:"Select_Time_Off"),forState: UIControlState.Normal)
        btn_q.setImage(UIImage(named:"Select_Question_On"),forState: UIControlState.Normal)
        
    }
    
    //動画リワードに応じてボタンのイベントを調整
    func push(sender:UIButton){
        appDelegate.mode = sender.tag - 2
        appDelegate.hozon = appDelegate.set
        
        
        print("ボタンが押される")
        
        if sender.tag == 1{
            appDelegate.mode = 100
            print("tagは1")
            self.presentViewController(self.catAL, animated: true, completion: {
            })
        }
        
        if sender.tag == 2{
            self.presentViewController(self.disAL, animated: true, completion: {
            })
        }
        
        
        if sender.tag >= 3 && sender.tag < 6{
            
            let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("play")
            nextVC?.modalTransitionStyle = .CrossDissolve
            presentViewController(nextVC!, animated:true, completion:nil)
        }
        
        if sender.tag >= 6 && sender.tag < 12 && !defaults.boolForKey("sw1"){
            self.presentViewController(AdAlert, animated: true, completion: {
            })
        }else if sender.tag >= 6 && sender.tag < 12 && defaults.boolForKey("sw1"){
            let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("play")
            nextVC?.modalTransitionStyle = .CrossDissolve
            presentViewController(nextVC!, animated:true, completion:nil)
        }
        
        
        if sender.tag >= 12 && sender.tag < 18 && !defaults.boolForKey("sw2"){
            self.presentViewController(AdAlert, animated: true, completion: {
            })
        }else if sender.tag >= 12 && sender.tag < 18 && defaults.boolForKey("sw2"){
            let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("play")
            nextVC?.modalTransitionStyle = .CrossDissolve
            presentViewController(nextVC!, animated:true, completion:nil)
        }
        
        
        if sender.tag >= 18 && sender.tag < 24 && !defaults.boolForKey("sw3"){
            self.presentViewController(AdAlert, animated: true, completion: {
            })
        }else if sender.tag >= 18 && sender.tag < 24 && defaults.boolForKey("sw3"){
            let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("play")
            nextVC?.modalTransitionStyle = .CrossDissolve
            presentViewController(nextVC!, animated:true, completion:nil)
        }
        
        if sender.tag >= 24 && sender.tag < 30 && !defaults.boolForKey("sw4"){
            self.presentViewController(AdAlert, animated: true, completion: {
            })
        }else if sender.tag >= 24 && sender.tag < 30 && defaults.boolForKey("sw4"){
            let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("play")
            nextVC?.modalTransitionStyle = .CrossDissolve
            presentViewController(nextVC!, animated:true, completion:nil)
        }
        
        
        
        
    }


    //動画を見る
    @IBAction func pickBtn(sender: AnyObject) {
        let sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if !UIImagePickerController.isSourceTypeAvailable(sourceType){
        
            return;
        }
        
        let ipc = UIImagePickerController()
        ipc.sourceType = sourceType
        ipc.mediaTypes = [kUTTypeMovie as String]
        //[ipc setDelegate:self];
        self.presentViewController(ipc, animated: true, completion: nil)
    }
    
    
    
    
    
    
//change the mode depending on which button you pushed

    @IBAction func created(sender: AnyObject) {
        appDelegate.mode = 100
    }
    
   
    
        
    
    
    
    //come back to this page
    @IBAction func comeHome (segue:UIStoryboardSegue){
        print("comehome")
        
        appDelegate.result.removeAll()
        appDelegate.detail.removeAll()
        setting.text = String(appDelegate.hozon)
        appDelegate.set = appDelegate.hozon
        btn_t.setImage(UIImage(named:"Select_Time_On"),forState: UIControlState.Normal)
        btn_q.setImage(UIImage(named:"Select_Question_Off"),forState: UIControlState.Normal)
        
        if appDelegate.radio == 0{
            btn_t.setImage(UIImage(named:"Select_Time_On"),forState: UIControlState.Normal)
            btn_q.setImage(UIImage(named:"Select_Question_Off"),forState: UIControlState.Normal)
            
        }else{
            btn_t.setImage(UIImage(named:"Select_Time_Off"),forState: UIControlState.Normal)
            btn_q.setImage(UIImage(named:"Select_Question_On"),forState: UIControlState.Normal)
            label1.text = "問題数を設定してください"
            label2.text = "問"
        }
        
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setting.keyboardType = UIKeyboardType.NumberPad
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enterForeground:", name:"applicationWillEnterForeground", object: nil)//バックグラウンド通知
        
    
        
        //Alertの設定
        let ins = ADFmyMovieReward.getInstance("56b2fe530d3495e610000421", delegate: self)
        let defaultAction = UIAlertAction(title: "キャンセル", style: .Default, handler: nil)
        AdAlert.addAction(defaultAction)
        
        let movieAction = UIAlertAction(title: "動画を見る", style: .Default){(action) in
            ins.play()
        }
        AdAlert.addAction(movieAction)
        
        
        
        
        print(GADRequest.sdkVersion())
        
        self.bannerView.adUnitID = "ca-app-pub-9818638593780439/6972715503"
        bannerView.delegate = self
        bannerView.rootViewController = self
        let gadRequest:GADRequest = GADRequest()
        gadRequest.testDevices = [kGADSimulatorID]  // テスト時のみ
        bannerView.loadRequest(gadRequest)
       // self.view.addSubview(bannerView)
        
        setting.delegate = self
        setting.text = "60"
        
        for var i = 1; i < 30; i++ {
            if let btn = viewBtns.viewWithTag(i) as? UIButton {
                btn.addTarget(self, action: Selector("push:"), forControlEvents: .TouchUpInside)
            }
        }
        
        print(defaults.boolForKey("sw1"))
        // to set up the button's alpha
        if defaults.boolForKey("sw1"){
            for var i = 6; i < 12; i++ {
                viewBtns.viewWithTag(i)!.alpha = 1
            }
        }
        if defaults.boolForKey("sw2"){
            for var i = 12; i < 18; i++ {
                viewBtns.viewWithTag(i)!.alpha = 1
            }
        }
        if defaults.boolForKey("sw3"){
            for var i = 18; i < 24; i++ {
                viewBtns.viewWithTag(i)!.alpha = 1
            }
        }
        if defaults.boolForKey("sw4"){
            for var i = 24; i < 30; i++ {
                viewBtns.viewWithTag(i)!.alpha = 1
            }
        }
        
        if let _arr1 = defaults.objectForKey("category") as? [String]{
            
            arr1 = _arr1
            var i = 0
            for elem in arr1{
                //hoge(i)
                var category = i
                let temp = UIAlertAction(title: elem, style: .Default){[category](action) in
                    self.appDelegate.cMode = category
                    
                    let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("play")
                    nextVC?.modalTransitionStyle = .CrossDissolve
                    self.presentViewController(nextVC!, animated:true, completion:nil)
                }
                i++
                
                print("cateMode = \(self.appDelegate.cMode)")
                catAL.addAction(temp)
            }
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .Default, handler: nil)
        catAL.addAction(cancel)
        
        
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
        disAL.addAction(cancel)
        
        //Define completeAL
        let finish = UIAlertAction(title: "OK", style: .Default){(action) in
            let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("menu")
            nextVC?.modalTransitionStyle = .CrossDissolve
            self.presentViewController(nextVC!, animated:true, completion:nil)
            
        }
        comAL.addAction(finish)
        
     
        
    }//end of didload
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var name = "Menu"
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)
        
        var builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
        
        
        if !defaults.boolForKey("first"){
            let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("tutorial")
            nextVC?.modalTransitionStyle = .CrossDissolve
            presentViewController(nextVC!, animated:true, completion:nil)
            defaults.setBool(true,forKey: "first")
        }
    }
    
    
    func AdsDidCompleteShow() {
        if defaults.boolForKey("sw1"){
            if defaults.boolForKey("sw2"){
                if defaults.boolForKey("sw3"){
                    if defaults.boolForKey("sw4"){
                    }else{
                        defaults.setBool(true,forKey: "sw4")
                    }
                }else{
                    defaults.setBool(true,forKey: "sw3")
                }
            }else{
                defaults.setBool(true,forKey: "sw2")
            }
        }else{
            defaults.setBool(true,forKey: "sw1")
        }
        
        print(defaults.boolForKey("sw1"))
        // to set up the button's alpha
        if defaults.boolForKey("sw1"){
            for var i = 6; i < 12; i++ {
                viewBtns.viewWithTag(i)!.alpha = 1
            }
        }
        if defaults.boolForKey("sw2"){
            for var i = 12; i < 18; i++ {
                viewBtns.viewWithTag(i)!.alpha = 1
            }
        }
        if defaults.boolForKey("sw3"){
            for var i = 18; i < 24; i++ {
                viewBtns.viewWithTag(i)!.alpha = 1
            }
        }
        if defaults.boolForKey("sw4"){
            for var i = 24; i < 30; i++ {
                viewBtns.viewWithTag(i)!.alpha = 1
            }
        }
    }
    
    /*  to judge the banner is able to be used or not
    
    func adViewDidReceiveAd(bannerView: GADBannerView!) {
        print("success")
    }
    
    func adView(bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("failed")
    }
    */
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range:NSRange,replacementString string: String) ->Bool{

        
        var tmpStr = textField.text! as NSString
        tmpStr = tmpStr.stringByReplacingCharactersInRange(range, withString: string)
        
        
        
        //空欄かどうかの判定
        if tmpStr == ""{
            
            if appDelegate.radio == 0{
                appDelegate.set = 60
            }else{
                appDelegate.set = 5
            }
            
        }else if let num = Int(tmpStr as String){
        
            appDelegate.set = num
        //テキストが空欄じゃなかったらsetにいれる
            
                
            
                
            //時間が上限を超えているかの判定
            if appDelegate.radio == 0 && appDelegate.set > 180 {
                let alert = UIAlertView()
                alert.title = "制限オーバー"
                alert.message = "制限時間の設定は180秒までです。"
                alert.addButtonWithTitle("OK")
                alert.show()
                
                print("上限オーバー")
                
                setting.text = "18"
                appDelegate.set = 18
            }
            
            if appDelegate.radio == 1 && appDelegate.set > 30  {
                let alert = UIAlertView()
                alert.title = "制限オーバー"
                alert.message = "問題数の設定は30問までです。"
                alert.addButtonWithTitle("OK")
                alert.show()
                
                print("上限オーバー")
                setting.text = "3"
                appDelegate.set = 3
            }
            
            if appDelegate.set <= 0{
                let alert = UIAlertView()
                alert.title = "設定エラー"
                alert.message = "１以上の数字を入力してください。"
                alert.addButtonWithTitle("OK")
                alert.show()
            }
            
            
        }else{
            
            let alert = UIAlertView()
            alert.title = "設定エラー"
            alert.message = "半角数字で設定してください"
            alert.addButtonWithTitle("OK")
            alert.show()
            
            print("上限オーバー")
            
            setting.text = "10"
            appDelegate.set = 10
            
        }
        

        print(appDelegate.set)
        
        
       
        
        return true
    }
    
    
    
    //Enterを押したときに呼び出される
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder()
        print("enter")
        
        return false
    }
    
    func enterForeground(notification: NSNotification){
        print("復帰したやで")
        _interstitial = createAndLoadInterstitial()
    }
    
    func interstitialDidReceiveAd(ad: GADInterstitial!){
        print("読まれました")
        
        if let isReady = _interstitial?.isReady {
            _interstitial?.presentFromRootViewController(self)
        }
    }
    
    func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!){
        
        print("インタースティシャル読み込み失敗")
    }
    
    
    func createAndLoadInterstitial()->GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-9818638593780439/8449448706")
        interstitial?.delegate = self
        let gadRequest:GADRequest = GADRequest()
        gadRequest.testDevices = [kGADSimulatorID]  // テスト時のみ
        interstitial?.loadRequest(gadRequest)
        
        print("インタースティシャルを作成しました")
        return interstitial!
    }

    @IBAction func tapView(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


    


}

