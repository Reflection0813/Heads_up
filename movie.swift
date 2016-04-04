//
//  movie.swift
//  Heads_up
//
//  Created by inada on 2015/12/07.
//  Copyright © 2015年 inada. All rights reserved.
//

//
//  ViewController.swift
//  AVFoundation006
//

import UIKit
import MediaPlayer

class movie: UIViewController {
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as!AppDelegate //AppDelegateのインスタンスを取得
    
    var moviePlayer:MPMoviePlayerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url:NSURL = appDelegate.path!
        
        self.moviePlayer = MPMoviePlayerController(contentURL: url)
        self.moviePlayer.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:
            self.view.frame.height)
        self.view.addSubview(moviePlayer.view)
        
        self.moviePlayer.fullscreen = true
        self.moviePlayer.controlStyle = MPMovieControlStyle.Fullscreen
        self.moviePlayer.repeatMode = MPMovieRepeatMode.None
        /*
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerPlaybackDidFinishNotificationReceived:", name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerLoadStateDidChangeNotificationReceived:", name: MPMoviePlayerLoadStateDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerWillEnterFullscreenNotificationReceived:", name: MPMoviePlayerWillEnterFullscreenNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMPMoviePlayerWillExitFullscreenNotificationReceived:", name: MPMoviePlayerWillExitFullscreenNotification, object: nil)
        */
        // 動画の再生が終了した時のNotification.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "moviePlayBackDidFinish:",
            name: MPMoviePlayerPlaybackDidFinishNotification,
            object: self.moviePlayer)
    }
    
    func onMPMoviePlayerPlaybackDidFinishNotificationReceived(notification: NSNotification){
        let userInfo: NSDictionary = notification.userInfo!
        let reason = userInfo[MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as! Int
        print("onMPMoviePlayerPlaybackDidFinishNotificationReceived = " + String(reason))
    }
    
    func onMPMoviePlayerLoadStateDidChangeNotificationReceived(notification: NSNotification){
        let state = self.moviePlayer.loadState
        print("onMPMoviePlayerLoadStateDidChangeNotificationReceived = " + String(state.rawValue))
        
    }
    
    func onMPMoviePlayerWillEnterFullscreenNotificationReceived(notification: NSNotification){
      
    }

    
    func onMPMoviePlayerWillExitFullscreenNotificationReceived(notification: NSNotification){
        
        //go to next page
        

        print("Done")
        /*
        let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("result")
        self.presentViewController(nextVC!,animated:true,completion:nil)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(nextVC!, animated: true, completion: nil)
        })*/

        
    }
    func moviePlayBackDidFinish(notification: NSNotification) {
        print("movieさいせいおわり")
        /*
        let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("result")
        self.presentViewController(nextVC!,animated:true,completion:nil)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(nextVC!, animated: true, completion: nil)
        })
        */
        // 通知があったらnotificationを削除.
        NSNotificationCenter.defaultCenter().removeObserver(self, name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
        
        let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("result")
       
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(nextVC!, animated: true, completion: nil)
        })

        
    }
    
    
}