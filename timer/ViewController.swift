//
//  ViewController.swift
//  timer
//
//  Created by Kobori on 2019/08/28.
//  Copyright © 2019 Masanori Kobori. All rights reserved.
//

//　クラス→プロパティ→イニシャライザ→メソッドの順番にかく


// イニシャライザはここのページには書かれていない
// 継承元のUIViewControllerなどにあるっぽい
// initはクラスの初期化処理？ 初期化処理は、viewdidloadなどですることが多い


// Ulkitをインポートして使っている
import UIKit

// クラス。一番上の階層
class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!

    // これはプロパティっぽい
    var timer: Timer!   // タイマー
    var timer_sec: Float = 0    // タイマー用の時間のための変数。Floatは型でDobleみたいな小数点が使えるやつ。
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // 更新用関数(更新するために作った関数
    // selector: #selector(updatetimer(_:)) で指定された関数
    // 再生ボタンのところのtimeInterval: 0.1, repeats: true で指定された通り、0.1秒毎に呼び出され続ける
    @objc func updateTimer(_ timer: Timer) {
        self.timer_sec += 0.1      //0.1秒毎に呼び出され続ける。なのでクリックした数だけ呼び出されるからこの記述だけだと早くなっていく
        self.timerLabel.text = String(format: "%.1f", timer_sec)      //ラベル表示で x.x という形で小数点第1位までの数字を表示するフォーマット設定。
    }
    
    
    // 再生ボタン IBAction
    @IBAction func startTimer(_ sender: Any) {
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            //Timer.scheduledTimerでタイマーを作成、始動していて、その後の()に入っている記述は引数らしい
            // timeInterval: 0.1    0.1 秒ごとに更新されるタイマー
            // target: self,    ターゲットは自分(クラスのViewController.swift )を指す
            // selector: #selector(updateTimer(_:)  タイマーで実行する処理。updateTimerを実行するように#selector(updateTimer(_:)と引数に指定している。
            // userInfo: nil,   タイマーとして渡したい値があれば設定するけど、今回は不要なのでnil
            // repeats: true    trueなら呼び出し、falseなら一度の呼び出しで終了
        }
    }

    
    
    // 一時停止ボタン IBAction
    @IBAction func pauseTimer(_ sender: Any) {
        //　A_動作しているタイマーを1つだけにするように制御する。タイマーを生成する時は self.timer がnilかどうかチェックして、nilでない時だけタイマーを生成し、タイマーを停止させる時は self.timer をnilにしてタイマーが存在していない状態にします。
        if self.timer != nil {
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
            //　A_ここまで
        }
    }
    
    
    // リセットボタン IBAction
    @IBAction func resetTimer(_ sender: Any) {
        self.timer_sec = 0      // リセットボタンを押すと、タイマーの時間を0に
        self.timerLabel.text = String(format: "%.1f", self.timer_sec)   //ラベル表示で x.x という形で小数点第1位までの数字を表示するフォーマット設定。
        //　A_動作しているタイマーを1つだけにするように制御する。タイマーを生成する時は self.timer がnilかどうかチェックして、nilでない時だけタイマーを生成し、タイマーを停止させる時は self.timer をnilにしてタイマーが存在していない状態にします。
        if self.timer != nil {
            self.timer.invalidate()   // タイマーを停止する
            self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
            // A_ここまで
        }
    }
    
    
    
    
    
}
