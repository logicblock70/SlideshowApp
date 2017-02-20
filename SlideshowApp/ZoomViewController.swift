//
//  ZoomViewController.swift
//  SlideshowApp
//
//  Created by 中村裕 on 2017/02/20.
//  Copyright © 2017年 yu.nakamura. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController {
    
    var img_num = 0                                                 //画像表示位置を示す変数
    var imgs : [String] = ["photo1.JPG","photo2.JPG","photo3.JPG"]  //ファイル名
    @IBOutlet weak var zoomImageView: UIImageView!                  //拡大画像表示用ビュー
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // スライドショー画面でタップされた画像を表示
        zoomImageView.image = UIImage(named: imgs[img_num])

        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
