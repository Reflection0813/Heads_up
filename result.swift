//
//  result.swift
//  Heads_up
//
//  Created by inada on 2015/12/03.
//  Copyright © 2015年 inada. All rights reserved.
//

import UIKit
import AssetsLibrary
import Social
import Photos
import GoogleMobileAds

class result: UIViewController,GADBannerViewDelegate,GADInterstitialDelegate,UIDocumentInteractionControllerDelegate{
    //insta
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as!AppDelegate
    
    //variables
    var count = 0
    var conAlert:UIAlertController = UIAlertController(title: "保存", message: "動画を保存しますか？", preferredStyle: UIAlertControllerStyle.Alert)

    
    
    //Outlets
    @IBOutlet weak var movie: UIImageView!
    @IBOutlet weak var bannerView: GADBannerView!
    var _interstitial:GADInterstitial?
    
    @IBAction func inter(sender: AnyObject) {
        if let isReady = _interstitial?.isReady {
            _interstitial?.presentFromRootViewController(self)
        }
        print("インター")
    }
    
    
    
    @IBAction func detail(sender: AnyObject) {
        let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("detail")
        nextVC?.modalTransitionStyle = .CrossDissolve
        presentViewController(nextVC!, animated:true, completion:nil)
    }
    
    @IBAction func download(sender: AnyObject) {
        self.presentViewController(conAlert, animated: true, completion: {
        })
        
    }
    
    func save(){
        let albumTitle = "heads up"
        var theAlbum: PHAssetCollection?
        
        let myAlbum = NSMutableArray()
       
        let list = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Album, subtype: PHAssetCollectionSubtype.Any, options: nil)
        
        // リストの中にあるオブジェクトに対して１つずつ呼び出す.
        list.enumerateObjectsUsingBlock { (album, index, isStop) -> Void in
            
            // アルバムのタイトル名をコレクションする.
            myAlbum.addObject(album.localizedTitle)
            
        }
        
        let index:NSInteger = myAlbum.indexOfObject("heads up")
        
        // 要素があったか?
        if (index != NSNotFound) { // yes
            print("%lu番目にありました．", index)
        } else { // no
            try! PHPhotoLibrary.sharedPhotoLibrary().performChangesAndWait({
                PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle("heads up")
            })
        }
        
            
        let changeBlock: () -> Void = {
            PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle("heads up")
        }
        
        
        let result = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Album, subtype: PHAssetCollectionSubtype.Any, options: nil)
        result.enumerateObjectsUsingBlock({(object, index, stop) in
            if let theCollection = object as? PHAssetCollection where
                theCollection.localizedTitle == albumTitle
            {
                theAlbum = theCollection
            }
        })
        
        
        if let anAlbum = theAlbum {             PHPhotoLibrary.sharedPhotoLibrary().performChanges({
                let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromVideoAtFileURL(self.appDelegate.path!)
                let assetPlaceholder = createAssetRequest!.placeholderForCreatedAsset!
                let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: anAlbum)
                albumChangeRequest!.addAssets([assetPlaceholder])
                }, completionHandler: nil)
            print("heads up に保存しました")
        }
    
        
        
        /*
        PHPhotoLibrary.sharedPhotoLibrary().performChanges(changeBlock) { success, error in
            //AssetsLibraryを生成する.
            let assetsLib = ALAssetsLibrary()
            
            //動画のパスから動画をフォトライブラリに保存する.
            assetsLib.writeVideoAtPathToSavedPhotosAlbum(self.appDelegate.path, completionBlock: nil)
        }
        */
    
    
        
        
        let alert = UIAlertView()
        alert.title = "保存完了"
        alert.message = "動画を保存しました。"
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
    
    
    @IBAction func twitter(sender: AnyObject) {
        
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            // make controller to share on twitter
            let controller = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            // add link to the controller
            
            
            // add text to the controller
            let title: String = "一緒にジェスチャーゲームやろう！　アプリDLはこちら→goo.gl/LBmAAh"
            controller.setInitialText(title)
            controller.addImage(UIImage(named: "snspost.png"))
            
            // show twitter post screen
            presentViewController(controller, animated: true, completion: {})
        }
    }
    
    @IBAction func line(sender: AnyObject) {
        
        var str:String = String(format: "一緒にジェスチャーゲームやろう！　アプリDLはこちら→goo.gl/LBmAAh")
        let encodedQuery: String = str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())!
            
            
            //stringByAddingPercentEncodingWithAllowedCharacters(NSUTF8StringEncoding)!
        var LineUrlString:String = String(format: "line://msg/text/%@",encodedQuery)
        let url = NSURL(string: LineUrlString)
        
        
        UIApplication.sharedApplication().openURL(url!)
        
        
        
    }
    
    @IBAction func insta(sender: AnyObject) {
        
        var filePath: NSURL = appDelegate.path!
        
        //imageData.writeToFile(filePath, atomically: true)
        
        var interactionController: UIDocumentInteractionController!
        
       
        interactionController = UIDocumentInteractionController(URL: filePath)
        
        interactionController.UTI = "com.instagram.exclusivegram"

        interactionController.delegate = self
        
        var present: Bool = interactionController.presentOpenInMenuFromRect(self.view.frame, inView: self.view, animated: true)
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var name = "Result"
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)
        
        var builder = GAIDictionaryBuilder.createScreenView()
        
        /*
        var delay = 0.5
        let d = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(d, dispatch_get_main_queue()) {
            
            if let isReady = self._interstitial?.isReady {
                self._interstitial?.presentFromRootViewController(self)
            }
            print("インター")
        }
*/
    }
    

override func viewDidLoad() {
    super.viewDidLoad()
    //バナー広告
    self.bannerView.adUnitID = "ca-app-pub-9818638593780439/6972715503"
    bannerView.delegate = self
    bannerView.rootViewController = self
    let gadRequest:GADRequest = GADRequest()
    gadRequest.testDevices = [kGADSimulatorID]  // テスト時のみ
    bannerView.loadRequest(gadRequest)
    
    _interstitial = createAndLoadInterstitial()
    
    /*
    var delay = 0.5
    let d = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    dispatch_after(d, dispatch_get_main_queue()) {
        
        if let isReady = self._interstitial?.isReady {
            self._interstitial?.presentFromRootViewController(self)
        }
        print("インター")
    }
    */
    
    let cancel = UIAlertAction(title: "キャンセル", style: .Default, handler: nil)
    conAlert.addAction(cancel)
    
    let movieAction = UIAlertAction(title: "保存する", style: .Default){(action) in
        self.save()
    }
    conAlert.addAction(movieAction)
    
    
    //サムネイルの作成
    var asset:AVAsset = AVAsset(URL: appDelegate.path!)
    var assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
    var time: CMTime = asset.duration
    time.value = 0
    do{
        var imageRef: CGImage! = try assetImgGenerate.copyCGImageAtTime(time, actualTime: nil)
        var frameImage:UIImage = UIImage(CGImage: imageRef)
        
        movie.image = frameImage
    
    }catch {}
    
    self.movie.userInteractionEnabled = true
    let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapGesture:")
    self.movie.addGestureRecognizer(Tap)
    // radianで回転角度を指定(30度)する.
    let angle:CGFloat = CGFloat((90.0 * M_PI) / 180.0)
    // 回転用のアフィン行列を生成する.
    movie.transform = CGAffineTransformMakeRotation(angle)
   
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
    
    
    func tapGesture(sender:UITapGestureRecognizer){
        let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("movie")
        nextVC?.modalTransitionStyle = .CrossDissolve
        presentViewController(nextVC!, animated:true, completion:nil)
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

   
    
    

    




    
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

}


