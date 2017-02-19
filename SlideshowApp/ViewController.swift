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
    @IBOutlet weak var slideshowButtonLabel: UIButton!
    @IBOutlet weak var returnButtonLabel: UIButton!
    @IBOutlet weak var nextButtonLabel: UIButton!

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func slideshowButton(_ sender: Any) {
        // 再生ボタンを押すとタイマー作成、始動
        if(play == true){
            play = false
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
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            }
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
        if(play == false){//スライドショー起動していない時のみ有効
            if(img_num > 0){
                img_num -= 1
                slideshowImage.image = UIImage(named: imgs[img_num])
            } else if (img_num == 0 ) {
                img_num = imgs.count - 1
                slideshowImage.image = UIImage(named: imgs[img_num])
            }
        }
    }

    @IBAction func nextButton(_ sender: Any) {
        if(play == false){ //スライドショー起動していない時のみ有効
            if(img_num < imgs.count-1){
                img_num += 1
                slideshowImage.image = UIImage(named: imgs[img_num])
            } else if (img_num == imgs.count-1 ) {
                img_num = 0
                slideshowImage.image = UIImage(named: imgs[img_num])
            }
        }
    }
    
    func updateTimer(timer: Timer){
        self.timer_sec += 2
        img_num = (timer_sec / 2) % 3
        slideshowImage.image = UIImage(named: imgs[img_num])
    }
}

