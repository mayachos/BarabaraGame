//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by maya on 2020/05/14.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imgView1: UIImageView! //上の画像
    @IBOutlet var imgView2: UIImageView! //真ん中の画像
    @IBOutlet var imgView3: UIImageView! //下の画像
    
    @IBOutlet var resultLabel: UILabel! //スコアを表示
    @IBOutlet var stopButton: UIButton!
    
    var timer: Timer! //画像を動かすためのタイマー
    var score: Int = 1000 //スコアの値
    let defaults: UserDefaults = UserDefaults.standard //スコアを保存
    
    let width: CGFloat = UIScreen.main.bounds.size.width //iPhonの画面幅
    
    var positionX: [CGFloat] = [0.0, 0.0, 0.0] //画像の位置の配列
    
    var dx: [CGFloat] = [2.0, 1.5, -1.5] //画像の動かす幅の配列
    
    func start() {
        //結果ラベルを隠す
        resultLabel.isHidden = true
        
        //タイマーを動かす
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self,
                                     selector: #selector(self.up), userInfo: nil, repeats: true)
        timer.fire()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        positionX = [width/2, width/2, width/2] //画像の位置を画面幅の中心に
        self.start() //startメソッド

        // Do any additional setup after loading the view.
    }
    
    @objc func up() {
        for i in 0..<3 {
            //端にきたら向きを逆にする
            if positionX[i] > width || positionX[i] < 0 {
                dx [i] = dx[i] * (-1)
            }
            positionX[i] += dx[i] //画像の位置をdx分ずらす
        }
        imgView1.center.x = positionX[0] //上の画像をずらした位置に移動
        imgView2.center.x = positionX[1] //真ん中の画像をずらした位置に移動
        imgView3.center.x = positionX[2] //下
    }
    
    //ストップボタン
    @IBAction func stop() {
        if timer.isValid == true { //もしタイマーが動いていたら
            timer.invalidate() //タイマー無効
            
            stopButton.setTitle("retry", for: .normal)
            
            for i in 0..<3 {
                score = score - abs(Int(width/2 - positionX[i])) * 2 //スコアを計算(absは絶対値)
                
            }
            resultLabel.text = "Score : " + String(score) //結果ラベルにスコアを表示
            resultLabel.isHidden = false //結果ラベルを隠さない
            
            let highScore1: Int = defaults.integer(forKey: "score1") //UserDefaultsにscore1キーの値を取得
            let highScore2: Int = defaults.integer(forKey: "score2") //UserDefaultsにscore2キーの値を取得
            let highScore3: Int = defaults.integer(forKey: "score3") //UserDefaultsにscore3キーの値を取得
            
            if score > highScore1 {
                defaults.set(score, forKey: "score1")
                defaults.set(highScore1, forKey: "score2")
                defaults.set(highScore2, forKey: "score3")
            } else if score > highScore2 {
                defaults.set(score, forKey: "score2")
                defaults.set(highScore2, forKey: "score3")
            } else if score > highScore3 {
                defaults.set(score, forKey: "score3")
            }
            defaults.synchronize()
        } else if timer.isValid == false {
            stopButton.setTitle("stop", for: .normal)
            self.retry()
        }
    }
    
    @IBAction func retry() {
        score = 1000 //スコアの値をリセット
        positionX = [width/2, width/2, width/2] //画像を真ん中に戻す
        if timer.isValid == false { //タイマーが動いていなければ
            self.start() //スタートメソッドを呼び出す
        }
    }
    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil) //Game~画面を破棄し元の画面に戻る
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
