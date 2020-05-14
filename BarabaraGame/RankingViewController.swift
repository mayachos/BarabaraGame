//
//  RankingViewController.swift
//  BarabaraGame
//
//  Created by maya on 2020/05/14.
//  Copyright © 2020 maya. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {

    @IBOutlet var rankingLabel1: UILabel! //1位のスコア表示
    @IBOutlet var rankingLabel2: UILabel! //2
    @IBOutlet var rankingLabel3: UILabel! //3
    
    let defaults: UserDefaults = UserDefaults.standard //スコアを保存する変数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // score1キーの値を取得、表示
        rankingLabel1.text = String(defaults.integer(forKey: "score1"))
        rankingLabel2.text = String(defaults.integer(forKey: "score2"))
        rankingLabel3.text = String(defaults.integer(forKey: "score3"))

        // Do any additional setup after loading the view.
    }
    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil)
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
