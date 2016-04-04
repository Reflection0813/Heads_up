//
//  Play_view.swift
//  Heads_up
//
//  Created by inada on 2015/12/02.
//  Copyright © 2015年 inada. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary

class play: UIViewController,AVCaptureFileOutputRecordingDelegate, AVAudioPlayerDelegate{
    //ビデオアウトプット
    var myVideoOutput:AVCaptureFileOutput!

    
    //instance
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as!AppDelegate //AppDelegateのインスタンスを取得
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()

    let main = ViewController()
    
    //variables
    var countNum = 10
    var countQue = 0
    var timekeeper: NSTimer!
    //let sounds:[NSURL]
    //var list:[String] = ["初期化"]
    var sound:[AVAudioPlayer!] = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
    
    @IBOutlet weak var byou: UILabel!
    
    
    var swi = 0
    var enable = 0 //ボタンを押す前にスワイプさせない
    
    
    var preView:UIView!
    var movView:UIView!
    

    

    
    let scW = Int(UIScreen.mainScreen().bounds.size.width)
    let scH = Int(UIScreen.mainScreen().bounds.size.height)

    //Outlets
    @IBOutlet weak var explain: UILabel!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var explain_i: UIImageView!
    @IBOutlet weak var alpView: UIView!
    
    @IBOutlet weak var nokori: UILabel!
    @IBOutlet weak var tani: UILabel!
    
    @IBOutlet weak var timebg: UIView!
    @IBOutlet weak var TV: UIImageView!
    
    @IBOutlet weak var sousa: UIImageView!
    
    
    let wrong = UIImageView(image: UIImage(named: "wrong"))
    let right = UIImageView(image: UIImage(named: "right"))
    
    //Images


    

    
    
    @IBAction func timekill(sender: AnyObject) {
        print("timekill")
        if enable == 1 && appDelegate.radio == 0{
        timekeeper.invalidate()
            
        }
    }
    
    
    //start button

    @IBAction func start_btn(sender: AnyObject) {
        ///カメラを起動する
        let mySession = AVCaptureSession()
        
        //撮影用のカメラ読み込み
        var myCamera:AVCaptureDevice!
        let devices = AVCaptureDevice.devices()
        for device in devices{
            if(device.position == AVCaptureDevicePosition.Front){
                myCamera = device as! AVCaptureDevice
            }
        }

        
        do{
            //入力元
            let videoInput = try AVCaptureDeviceInput(device: myCamera)
            mySession.addInput(videoInput)
            //出力先
            let myImageOutput : AVCaptureStillImageOutput = AVCaptureStillImageOutput()
            mySession.addOutput(myImageOutput)
            
            // マイクを取得.
            let audioCaptureDevice = AVCaptureDevice.devicesWithMediaType(AVMediaTypeAudio) //as! AVCaptureDevice
            // マイクをセッションのInputに追加.
            let audioInput = try AVCaptureDeviceInput(device:audioCaptureDevice[0] as! AVCaptureDevice)
            
            //動画の保存
            myVideoOutput = AVCaptureMovieFileOutput()
            
            // ビデオ出力をOutputに追加.
            mySession.addOutput(myVideoOutput)
            mySession.addInput(audioInput)
            
            
            movView = UIView(frame: CGRectMake(0.0,0.0,CGFloat(TV.frame.size.width-20),CGFloat(TV.frame.size.height*4/5)))
            movView.frame.origin = CGPoint(x: CGRectGetMinX(TV.frame)+10,y: CGRectGetMinY(TV.frame)+10)
            
            alpView.alpha = 0.5
            alpView.frame = movView.frame
            alpView.frame.origin = movView.frame.origin
            
        
            let myVideoLayer = AVCaptureVideoPreviewLayer(session: mySession)
            myVideoLayer.frame = movView.frame
            myVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            self.view.layer.addSublayer(myVideoLayer)
            self.view.addSubview(alpView)
            
            
            //session開始
            mySession.startRunning()
            
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            
            // フォルダ.
            let documentsDirectory = paths[0]
            // ファイル名.
            let filePath : String? = "\(documentsDirectory)/test.mp4"
            
            // URL.
            let fileURL : NSURL = NSURL(fileURLWithPath: filePath!)
            
            // 録画開始.
            myVideoOutput.startRecordingToOutputFileURL(fileURL, recordingDelegate: self)
            
        }catch {
            print("カメラは使えません")
        }
        sousa.removeFromSuperview()
        appDelegate.right = 0
        appDelegate.wrong = 0
        appDelegate.ind = 0
        explain.alpha = 1
        TV.alpha = 1
        timebg.alpha = 1
        timer.alpha = 1
        swi = 1     //時間設定の時のタイマー起動スウィッチ変数
        enable = 1  //スワイプと長押しを可能にする
        start.enabled = false
        start.alpha = 0
        
        let wid = (TV.layer.frame.width * 9) / 10
        let hei = (((TV.layer.frame.height * 4) / 5) * 9 ) / 10
        print(wid,hei)
        
        
        
        explain_i.removeFromSuperview()
        let defaults = NSUserDefaults.standardUserDefaults()
        var list:[String] = []
        let mode:Int = appDelegate.mode!
        print(mode)
        switch mode{
        case 100:
            
            if let newArr = defaults.objectForKey("question") as? [[String]] {  //newArrayが[[String]]だったら
                for elem in newArr[appDelegate.cMode] {
                    print("リストに追加")
                    list.append(elem)
                }
            }else{
                print("リスト追加エラー")
            }
            
        case 0: list = ["サイ","ライオン","チーター","トラ","ねこ","いぬ","うま","ダンゴ虫","キリン","カンガルー","オオカミ","ひつじ","ゾウ","サル","たぬき","きつね","くま","うさぎ","ねずみ","ミーアキャット","アルパカ","カピバラ","ゴリラ","シカ","ヤギ","バビルサ","バク","リス","ブタ","ウシ","ワンピース","ナルト","ポケットモンスター","プリキュア","セーラームーン","ハンターハンター","幽遊白書","BLEACH","トリコ","銀魂","宇宙兄弟","カイジ","るろうに剣心","蟲師","闇金ウシジマ","マギ","コナン","桜蘭高校ホスト部","ジョジョの奇妙な冒険","フェアりテール","光の碁","DEATHNOTE","バクマン","弱虫ペダル","快感フレーズ","ランマー","フルーツバスケット","ライフ","MAJOR","進撃の巨人","ラグビー","野球","サッカー","ハンドボール","ボーリング","柔道","剣道","乗馬","テニス","空手","卓球","フィギュアースケード","スピードスケート","ホッケー","ゴルフ","ジョギング","マラソン","バスケット","カーリング","スポーツダンス","高跳び","機械体操","床","エアロビクス","ヨガ","レスリング","ドッジボール","ハンマー投げ","水泳","サイクリング","切手集め","株","編み物","料理","アニメ","アクアリウム","アロマテラピ","インテリア","ネットゲーム","ネットサーフィン","ダーツ","読書","自由研究","刺繍","スポーツ観戦","コスプレ","追っかけ","筋トレ","映画鑑賞","カメラ","家庭菜園","コレクション","ケーキ作り","水泳","テニス","スキューバダイビング","キャンプ","カラオケ","釣り","野球"]
        case 1: list = ["サイ","ライオン","チーター","トラ","ねこ","いぬ","うま","ダンゴ虫","キリン","カンガルー","オオカミ","ひつじ","ゾウ","サル","たぬき","きつね","くま","うさぎ","ねずみ","ミーアキャット","アルパカ","カピバラ","ゴリラ","シカ","ヤギ","バビルサ","バク","リス","ブタ","ウシ"]//陸の動物
        case 2: list = ["イルカ","クジラ","サメ","カメ","アシカ","オットセイ","クラゲ","メダカ","ペンギン","大王イカ","タコ","オオグソクムシ","うなぎ","マンボウ","エイ","アザラシ","ヒトデ","なまこ","うなぎ","マグロ","フグ","エビ","カニ","イソギンチャク","セイウチ","シャチ","ネッシー","海蛇","人魚","さんま"]//海の動物
        case 3: list = ["フクロウ","すずめ","カラス","白鳥","アルバトロス","カモ","ツバメ","タカ","ツル","コウノトリ","クジャク","ワシ","トンビ","鷲","鷺","鳩","蝙蝠","キツツキ","オウム","ガン","アホウドリ","はやぶさ","ハチドリ","トキ","鶯","インコ","うこっけい","かもめ","カナリア"]//空の動物
        case 4: list = ["くるま","新幹線","電車","バイク","水上バイク","ヘリコプター","気球","自転車","スケート","スケートボード","船","馬車","飛行機","宇宙船","パラグライダー"]//乗り物
        case 5: list = ["ワンピース","ナルト","ポケットモンスター","プリキュア","セーラームーン","ハンターハンター","幽遊白書","BLEACH","トリコ","銀魂","宇宙兄弟","カイジ","るろうに剣心","蟲師","闇金ウシジマ","マギ","コナン","桜蘭高校ホスト部","ジョジョの奇妙な冒険","フェアリーテール","光の碁","DEATHNOTE","バクマン","弱虫ペダル","快感フレーズ","ランマー","フルーツバスケット","ライフ","MAJOR","進撃の巨人"]//食べ物
        case 6: list = ["西野カナ トリセツ","SMAP 世界に一つだけの花","アナ雪 LET IT GO","宙船","恋するフォーチュンクッキー","もしも運命の人がいるのなら","ぶーしゃかloop","cho cho train","R.Y.U.S.E.I.","Greeeen キセキ","三代目 starting over","唇にBeMyBaby","にんじゃりばんばん","Dragon Night ","Haru Haru","backnumber 高嶺の花子さん","Wherever you are","恋空と雨音","25コ目の染色体","イケナイ太陽","Mr.children 終わりなき旅","愛を叫べ","猟奇的なキスを私にして","いきものがかり ありがとう","永遠に共に","ないものねだり","ウィークエンダー","家族になろうよ","無責任ヒーロー"]//果物
        case 7: list = ["とにかく明るい安村","おかずクラブ","ピスタチオ","アンガールズ","Go!皆川","渡辺直美","永野","ハリセンボン","ノンスタイル","森三中","雨上がり決死隊","トレンディエンジェル","出川哲郎","宮川大輔","メイプル超合金","いとうあさこ","8.6秒バズーカ","鬼越トマホーク","横澤夏子","パンサー","ノンスタイル","オリエンタルラジオ","ゆんぼだんぷ","ざきやま","カンニング竹山","千鳥","狩野英孝","ロバート","ピース","FUJIWARA"]
        case 8: list = ["医者","弁護士","警察","コンサルタント","ディレクター","プロデューサー","エンジニアー","ライター","画家","芸能人","運動選手","役者","フリーター","フリーランス","軍人","ナース","介護士","占い師","シェフ","職人","政治家","デザイナー","漫画家","声優","小説家","先生"]
        case 9: list = ["ラグビー","野球","サッカー","ハンドボール","ボーリング","柔道","剣道","乗馬","テニス","空手","卓球","フィギュアースケード","スピードスケート","ホッケー","ゴルフ","ジョギング","マラソン","バスケット","カーリング","スポーツダンス","高跳び","機械体操","床","エアロビクス","ヨーガ","レスリング","ドッジボール","ハンマー投げ","水泳","サイクリング"]
        case 10: list = ["apple","banana","silver","gold","name","disgusting","apply","catch","continue","game","develop","die","disappear","approach","add","contact","cover","solve","spread","stay","sound","share","protect","remember","spend","mean","manage","lie","market","meal" ]
        case 11: list = ["北川景子","阿部サダヲ","綾野剛","剛力彩芽","市川海老蔵","東幹久","生田斗真","福山雅治","佐藤健","三浦春馬","西島秀俊","市原隼人","城田優","上戸彩","浅野忠信","綾瀬はるか","佐藤隆太","松田翔太","船越英一郎","香川照之","向井修","堀北真紀","岡田将生","オダギリジョー","渡辺謙","高倉健","関根勤","梅宮辰夫","伊藤淳史","阿部寛"]

        case 12: list = ["STARWARS","殺人の追憶","イーグルアイ","異邦人","エイリアン","X-MEN","エルム街の悪夢","オーシャンズ","オペラ座の怪人","カーズ","カルメン","キル・ビル","キングコング","ゴースト","サイコ","サイン","リング","猿の惑星","GIジョー","幸せのレシピ","幸せの教室","シャーロック","JUNO","情事","ジョーズ","スーパーマン","スクリーム","スターゲイト","スターダスト","HOMEALONE"]
        case 13: list = ["ガキつか","24時間テレビ","いいとも","ペケポン","SMAPｘSMAP","大喜利","ニュース","ドラマ","27時間テレビ","紅白歌合戦","FNS歌謡祭","オンタマ","僕らの音楽","テレビタックル","ぶらり旅","ちい散歩","おじゃマップ","しゃべくり007","嵐にしやがれ","さんま御殿","徹子の部屋","music lover","ミヤネ屋","サンデージャポン","とくダネ","めざましテレビ","昼顔","虹色ジーンズ","あめとーーく","怒り新党"]
        case 14: list = ["スーパーマリオ","ストリートファイター","ポケットモンスター","バイオハザード","メタルギア","ときめきメモリアル","ドンキーコング","コスモポリス","プロ野球","TITAN","ドラゴンボール","星のカービィ","アイドルマスター","ワールドサッカー","ガンダム無双","FIFA09","プリンスオブペルシャー","NBA","鉄拳","ベヨネッタ","アサシンクリード","アバター","北斗無双","FF","信長の野望","ALANWAKE","キャサリン","F1","モンスターハンター","ドラゴンエイジ"]
        case 15: list = ["error"]
            
        case 16: list = ["こころ","吾輩は猫である","人間失格","走れメロス","東京八景","火花","雁","トロッコ","ノルウェイの森","ベニスの商人","パステルの竜","永遠のゼロ","悪の教典","百夜行","不毛地帯","１Q84 ","ジェノサイド","空飛ぶタイヤ","すべてがFになる","モンスター","流星ワゴン","ダヴィンチコード","重力ピエロ","Nのために","天使と悪魔","半落ち","天地明察","秘密","長い長い殺人","新参者"]
        case 17: list = ["インフルエンザ","北朝鮮","大気汚染","放射線","プレミア12","テロ","IS","爆買い","ノーベル賞","地震","五輪","エボラ","中国","メルス","iPS細胞","STAP細胞","ユネスコ"]//社会
        case 18: list = ["築地","雷門","鎌倉","江の島","富士山","箱根","京都","東京タワー","スカイツリー","青の洞窟","ウユニ塩湖","ハワイ","バリ島","自由の女神","NY","万里の長城","ヴェルサイユ宮殿","エッフェル塔","厳島神社","景福宮","タージマハル","アンコールワット","地獄の門","タイムズスクエア","モレーン湖","ケルン大聖堂","ノイシュヴァンシュタイン城","フィンガルの洞窟","プラハ"]//名所
        case 19: list = ["PRADA","CHANEL","Calvin Klein","COACH","H&M","109","ユニクロ","Kiton","POLO","サマンサ","EDWIN","GUCCI","BVLGARI","Ferragamo","DOLCE & GABBANA","ARMANI","LOUIS VUITTON","Chloe","HERMES","CARTIER","Christian Dior","CELINE","Saint Laurent","ANNA SUI","BURBERRY","Paul Smith","Dakota","GANZO","PORTER","MARC JACOBS"]//ファッション
        case 20: list = ["切手集め","株","編み物","料理","アニメ","アクアリウム","アロマテラピ","インテリア","ネットゲーム","ネットサーフィン","ダーツ","読書","自由研究","刺繍","スポーツ観戦","コスプレ","追っかけ","筋トレ","映画鑑賞","カメラ","家庭菜園","コレクション","ケーキ作り","水泳","テニス","スキューバダイビング","キャンプ","カラオケ","釣り","野球"]
        case 21: list = ["ペアリング","プロポーズ","公園","デート","占い","ストーカー","リア充","結婚","幸せ","恋愛","別れ","失恋","嫉妬","同棲","合コン","友達","遠距離","不倫","浮気","片思い","血液型","彼氏","彼女","既婚者","離婚","破局","クリスマス","年の差","キス","ハグ"]
            
            
        case 22:list = ["シンデレラ","白雪姫","親指姫","かぐや姫","鶴の恩返し","桃太郎","赤ずきん","雪の女王","眠れる森の美女","ピノキオ","ヘンゼルとグレーテル","ラプンツェル","ピーターパン","三匹のこぶた","人形姫","浦島太郎","かちかち山","赤い靴","猿かに合戦","不思議な国のアリス","フランダースの犬","マッチ売りの少女","雪女","トラのあぶら","ジャックとまめの木","しあわせの王子","ウサギとカメ","長靴をはいたネコ","カエルの王様","裸の王様"]
            
        case 23:list = ["オムライス","親子丼","鯖の味噌煮","アラビアータ","トルティーヤ","ナポリタン","フィッシュアンドチップス","たこ焼き"]//料理
        case 24:list = ["お正月","花見","お盆","月見","花火","初詣","大晦日","誕生日","節分","成人式","七夕","体育祭","入学式","卒業式","ひな祭り","バレンタインデー","ホワイトデー","母の日","父の日","敬老の日","クリスマス","建国記念日","ハロウィン","エイプリルフール"]
        case 25:list = ["卵","鉛筆","トイレットペーパ","めんぼう","SUICA","PASMO","たばこ","ごみ","自販機","ベッド","ペットボトル","傘","時計","椅子","机","パソコン","電話","テレビ","ラジオ","リモコン","冷蔵庫","やかん","カレンダー","スマホ","メガネ","コンビニー","病院","歯科","接骨院","掃除機"]
        case 26:list = ["冬のソナタ","イケメンですね","深夜食堂","バラのない花屋","家政婦のミタ","ひまわり","任侠ヘルパー","海猿","ルーキーズ","SPEC","電車男","失恋ショコラ","あまちゃん","げげげの女房","篤姫","竜馬伝","JIN","コードブルー","CSI","白い巨頭","男はつらいよ","水戸黄門","花より男子","大奥","相棒","釣りバカ日誌","孤独のグルメ","下町ロケット","アイムホーム","銭の戦争"]
        case 27:list = ["error"]//あるある
            
        default: list = ["読み込みに失敗しました。BACKボタンで戻ってください。"]
            
        }
        
        let cnt = list.count
        
        for (var i=0; i<cnt; i++){
            let idx = Int(arc4random() % UInt32(list.count))
            appDelegate.result.append(list[idx])
            list.removeAtIndex(idx)
        }
        print("result=\(appDelegate.result)")
        explain.text=appDelegate.result[appDelegate.ind] //最初の単語を生成する
        appDelegate.ind++
        
    }
    //swipe
    @IBAction func swipe_play(sender: AnyObject) {
        print("スワイプ処理")
        if (enable == 1){
        
        
        
        appDelegate.right += 1 //正解数増加
        appDelegate.detail.append("○")
            
        right.alpha = 0 //透明化
        self.view.addSubview(right)
        self.appearAndFadeout(right)
        
        //soundPlay("correct2",type: "mp3")
        playSoundWithFile("correct2", type: "mp3")
        
         //if in the que_num mode, decrease the number of remained num.
          if (appDelegate.radio == 1){
             appDelegate.set = appDelegate.set - 1
             timer.text = "\(appDelegate.set)"
            
            if (appDelegate.set == 0){
                //ビデオ停止
                myVideoOutput.stopRecording()
                
                //go to next page
                //let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("result")
                //presentViewController(nextVC!,animated:true,completion:nil)
            }
            
        }
        
        
        
        if (appDelegate.result.count == 1){
            explain.text = "終了！"
            
            myVideoOutput.stopRecording()
            
        }else{
        explain.text=appDelegate.result[appDelegate.ind]//change the word from the array
            }
        if (appDelegate.ind >= appDelegate.result.count - 1) {
            if appDelegate.radio == 0{
                timekeeper.invalidate()
            }
            explain.text = "終了！"
            
            myVideoOutput.stopRecording()
            
            
        }else{
            
        appDelegate.ind++
            
        }
        }
        
    }
    
    //double_click
    @IBAction func down(sender: AnyObject) {
        print("パス処理")
        if (enable == 1) && (sender.state == UIGestureRecognizerState.Ended){
            
            
            appDelegate.wrong += 1 //パス数増加
            appDelegate.detail.append("×")
            
            wrong.alpha = 0
            self.view.addSubview(wrong)
            self.appearAndFadeout(wrong)
            
            playSoundWithFile("incorrect1", type: "mp3")
            
            if (appDelegate.radio == 1){
                appDelegate.set = appDelegate.set - 1
                timer.text = "\(appDelegate.set)"
                
                if (appDelegate.set == 0){
                    //ビデオ停止
                    myVideoOutput.stopRecording()
                    
                    //timekeeper.invalidate()
                    
                    
                }
                
            }//if in the que_num mode, decrease the number of remained num.
            
            explain.text=appDelegate.result[appDelegate.ind]  //change the word from the array
            
            if(appDelegate.ind >= appDelegate.result.count - 1){
                
                if appDelegate.radio == 0{
                    timekeeper.invalidate()
                }
                
                explain.text = "終了！"
                
                myVideoOutput.stopRecording()
                
            }else{
                
                appDelegate.ind++
                
            }
        }
        
    }
    
    
    
    


    
    //画像をフェードアウトさせる
    
    func appearAndFadeout(theView:UIView){
        theView.center = CGPointMake(CGFloat(scW/2),CGFloat(scH/2))
        theView.alpha = 1.0
        print("フェードアウト処理")
        
        UIView.animateWithDuration(
            2.0,    delay:0,    options: UIViewAnimationOptions.CurveEaseInOut,
            animations:{
                theView.alpha = 0.0
            },completion:{(finished:Bool) in
                theView.removeFromSuperview()
        })
    }

    
//撮影がおわると呼ばれる
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        
        print("撮影終了")
        explain.text = "終了！"
        
        playSoundWithFile("gong-played2", type: "mp3")
        
        //AssetsLibraryを生成する.
        //let assetsLib = ALAssetsLibrary()
        
        //動画のパスから動画をフォトライブラリに保存する.
        //assetsLib.writeVideoAtPathToSavedPhotosAlbum(outputFileURL, completionBlock: nil)
        
        appDelegate.path = outputFileURL
        
        var delay = 2.0
        let d = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(d, dispatch_get_main_queue()) {
            
            //go to next page
            let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("result")
            self.presentViewController(nextVC!,animated:true,completion:nil)
            
        }

    }



    override func viewDidLoad() {
        super.viewDidLoad()
        
        var name = "Play"
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)
        
        var builder = GAIDictionaryBuilder.createScreenView()
        
        //サウンドファイルの読み込み
        
        
        alpView.alpha = 0
        if (appDelegate.radio == 0){
        timekeeper = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        } else{
            
            if(appDelegate.set == 60 ){appDelegate.set = 5} //デフォルトの秒数が６０なので、デフォルトでかつモードが１ならばデフォルト問題数を５にする。
            byou.text = "問"
            timer.text = "\(appDelegate.set)"
        }
        
        explain.adjustsFontSizeToFitWidth = true
    
    }
    
    func update() {
        
        if(swi == 1){       //ボタンが押されたかどうかの判定
        
        timer.text = "\(appDelegate.set)"
        appDelegate.set--
        
            if(appDelegate.set == 2){
                playSoundWithFile("info-girl1-countdown1", type: "mp3")
            }
        
            
        if(appDelegate.set < 0){
            //ビデオ停止
    
            timekeeper.invalidate()

            explain.text = "終了！"
            
            myVideoOutput.stopRecording()
            
        }
    }
    }
    
    
    func playSoundWithFile(file: String, type: String){
        var path = NSBundle.mainBundle().pathForResource(file, ofType: type)
        var url:NSURL? = NSURL(fileURLWithPath:path!)
        print(path,url)
        for i in 0...sound.count-1 {
            if sound[i] == nil {
                sound[i] = try! AVAudioPlayer(contentsOfURL: url!, fileTypeHint: nil)
                sound[i].delegate = self
                sound[i].prepareToPlay()
                print("再生されました")
                sound[i].play()
            return
                }
            }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        print("再生終了",player)
        
        for i in 0...sound.count-1 {
            if sound[i] == nil {
            }else{
                sound[i] = nil
            }
            }
        let noti = NSNotification(name: "stop", object: self)
        NSNotificationCenter.defaultCenter().postNotification(noti)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }


}
