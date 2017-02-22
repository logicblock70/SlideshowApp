//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 中村裕 on 2017/02/19.
//  Copyright © 2017年 yu.nakamura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slideshowImage: UIImageView!        //スライドショー画像
    @IBOutlet weak var slideshowButtonLabel: UIButton!     //再生/停止ボタン
    @IBOutlet weak var returnButtonLabel: UIButton!        //戻るボタン
    @IBOutlet weak var nextButtonLabel: UIButton!          //進むボタン

    var img_num = 0         //表示画像の格納位置
    var timer: Timer!       //タイマー
    var timer_sec:Int = 0   //秒数カウント
    var play:Bool = false   //スライドショーオンオフ切り替え用変数
    
    //ファイル名
    var imgs : [String] = ["photo1.JPG","photo2.JPG","photo3.JPG"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //初期画面設定
        slideshowImage.image = UIImage(named: "photo1.JPG")
        
        // スライドショーシングルタップ時のイベント追加
        let slideTapEvent: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.slideTapEvent(_:)))
        // イベントが入ったUITapGestureRecognizerをインスタンス化
        self.slideshowImage.addGestureRecognizer(slideTapEvent)
        // タップを検知
        self.slideshowImage.isUserInteractionEnabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func slideshowButton(_ sender: Any) {
        // 再生ボタンを押すとタイマー作成、始動
        if(play == true){
            play = false              // スライドショーを停止する
            self.timer.invalidate()   // 現在のタイマーを破棄する
            timer = nil
            // 再生ボタンに名前変更
            slideshowButtonLabel.setTitle("再生", for: .normal)
            // 進む、戻るボタン無効
            nextButtonLabel.isEnabled = true
            returnButtonLabel.isEnabled = true
            //　進む、戻るボタン半透明から戻す
            nextButtonLabel.alpha = 1.0
            returnButtonLabel.alpha = 1.0

        } else {
            if self.timer == nil { //タイマーを新たに生成
                self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            }
            // スライドショーを再生する
            play = true
            // 停止ボタンに名前変更
            slideshowButtonLabel.setTitle("停止", for: .normal)
            // 進む、戻るボタン無効
            nextButtonLabel.isEnabled = false
            returnButtonLabel.isEnabled = false
            // 進む、戻るボタンを半透明
            nextButtonLabel.alpha = 0.5
            returnButtonLabel.alpha = 0.5
            
        }

    }
    
    @IBAction func returnButton(_ sender: Any) {
        if(play == false){ //スライドショー起動していない時のみ有効
            if(img_num > 0){ //1つ前の画像を表示
                img_num -= 1
                slideshowImage.image = UIImage(named: imgs[img_num])
            } else if (img_num == 0 ) { //最初の画像の場合
                //一番最後の画像を表示
                img_num = imgs.count - 1
                slideshowImage.image = UIImage(named: imgs[img_num])
            }
        }
    }

    @IBAction func nextButton(_ sender: Any) {
        if(play == false){ //スライドショー起動していない時のみ有効
            if(img_num < imgs.count-1){//次の画像を表示
                img_num += 1
                slideshowImage.image = UIImage(named: imgs[img_num])
            } else if (img_num == imgs.count-1 ) {//最後の画像の場合
                //一番最初の画像を表示
                img_num = 0
                slideshowImage.image = UIImage(named: imgs[img_num])
            }
        }
    }
    
    // 2秒ごとにスライドショーを更新する
    func updateTimer(timer: Timer){
        self.timer_sec += 2
        img_num = (timer_sec / 2) % 3
        slideshowImage.image = UIImage(named: imgs[img_num])
    }
    
    
    // Segue画面遷移
    func segueToResultViewController() {
        //StoryBoardで設定したSegueIDで画面を遷移させる
        self.performSegue(withIdentifier: "Zoom", sender: self)
    }
    
    // 画面遷移先への値受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! ZoomViewController
        nextViewController.img_num = self.img_num
    }

    
    // タップイベント
    func slideTapEvent(_ sender: UITapGestureRecognizer){
        if(play == true){// 画像拡大画面へ遷移する場合
            play = false              // スライドショーを停止する
            self.timer.invalidate()   // 現在のタイマーを破棄する
            timer = nil
            // 再生ボタンに名前変更
            slideshowButtonLabel.setTitle("再生", for: .normal)
            // 進む、戻るボタン無効
            nextButtonLabel.isEnabled = true
            returnButtonLabel.isEnabled = true
            //　進む、戻るボタン半透明から戻す
            nextButtonLabel.alpha = 1.0
            returnButtonLabel.alpha = 1.0
            
        }
        // 画像拡大画面へ遷移
        segueToResultViewController()
    }
    
    @IBAction func backWithSegue(segue: UIStoryboardSegue) {
        // 遷移先から戻る
    }

}

