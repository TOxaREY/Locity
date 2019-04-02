//
//  ViewController.swift
//  Flip
//
//  Created by REYNIKOV ANTON on 05/03/2019.
//  Copyright © 2019 REYNIKOV ANTON. All rights reserved.
//

import UIKit


extension CGFloat {
    var dp: CGFloat {
        return (self / 320) * UIScreen.main.bounds.width
    }
}
extension CGFloat {
    var dp2: CGFloat {
        switch UIScreen.main.bounds.height {
        case 896, 812:
            return (self / 320) * UIScreen.main.bounds.width * 1.3
        case 736, 667:
            return (self / 320) * UIScreen.main.bounds.width * 1.1
        default:
            return (self / 320) * UIScreen.main.bounds.width
        }
    }
}

extension UILabel {
    func pulsate() {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.65
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = .greatestFiniteMagnitude
        pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(pulse, forKey: nil)
    }
}
extension UILabel {
    func pulsateRep() {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = 0.5
        pulse.fromValue = 0.65
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        layer.add(pulse, forKey: nil)
    }
}


class ViewController: UIViewController {

//    let isoArray = ["AA","AB","AC","AD","AE","AF","AG","AH","AI","AJ","AK","AL","AM","AN","AO","AP","AQ","AR","AS","AT","AU","AV","AW","AX","AY","AZ","BA","BB","BC","BD","BE","BF","BG","BH","BI","BJ","BK","BL","BM","BN","BO","BP","BQ","BR","BS","BT","BU","BV","BW","BX","BY","BZ","CA","CB","CC","CD","CE","CF","CG","CH","CI","CJ","CK","CL","CM","CN","CO","CP","CQ","CR","CS","CT","CU","CV","CW","CX","CY","CZ","DA","DB","DC","DD","DE","DF","DG","DH","DI","DJ","DK","DL","DM","DN","DO","DP","DQ","DR","DS","DT","DU","DV","DW","DX","DY","DZ","EA","EB","EC","ED","EE","EF","EG","EH","EI","EJ","EK","EL","EM","EN","EO","EP","EQ","ER","ES","ET","EU","EV","EW","EX","EY","EZ","FA","FB","FC","FD","FE","FF","FG","FH","FI","FJ","FK","FL","FM","FN","FO","FP","FQ","FR","FS","FT","FU","FV","FW","FX","FY","FZ","GA","GB","GC","GD","GE","GF","GG","GH","GI","GJ","GK","GL","GM","GN","GO","GP","GQ","GR","GS","GT","GU","GV","GW","GX","GY","GZ","HA","HB","HC","HD","HE","HF","HG","HH","HI","HJ","HK","HL","HM","HN","HO","HP","HQ","HR","HS","HT","HU","HV","HW","HX","HY","HZ","IA","IB","IC","ID","IE","IF","IG","IH","II","IJ","IK","IL","IM","IN","IO","IP","IQ","IR","IS","IT","IU","IV","IW","IX","IY","IZ","JA","JB","JC","JD","JE","JF","JG","JH","JI","JJ","JK","JL","JM","JN","JO","JP","JQ","JR","JS","JT","JU","JV","JW","JX","JY","JZ","KA","KB","KC","KD","KE","KF","KG","KH","KI","KJ","KK","KL","KM","KN","KO","KP","KQ","KR","KS","KT","KU","KV","KW","KX","KY","KZ","LA","LB","LC","LD","LE","LF","LG","LH","LI","LJ","LK","LL","LM","LN","LO","LP","LQ","LR","LS","LT","LU","LV","LW","LX","LY","LZ","MA","MB","MC","MD","ME","MF","MG","MH","MI","MJ","MK","ML","MM","MN","MO","MP","MQ","MR","MS","MT","MU","MV","MW","MX","MY","MZ","NA","NB","NC","ND","NE","NF","NG","NH","NI","NJ","NK","NL","NM","NN","NO","NP","NQ","NR","NS","NT","NU","NV","NW","NX","NY","NZ","OA","OB","OC","OD","OE","OF","OG","OH","OI","OJ","OK","OL","OM","ON","OO","OP","OQ","OR","OS","OT","OU","OV","OW","OX","OY","OZ","PA","PB","PC","PD","PE","PF","PG","PH","PI","PJ","PK","PL","PM","PN","PO","PP","PQ","PR","PS","PT","PU","PV","PW","PX","PY","PZ","QA","QB","QC","QD","QE","QF","QG","QH","QI","QJ","QK","QL","QM","QN","QO","QP","QQ","QR","QS","QT","QU","QV","QW","QX","QY","QZ","RA","RB","RC","RD","RE","RF","RG","RH","RI","RJ","RK","RL","RM","RN","RO","RP","RQ","RR","RS","RT","RU","RV","RW","RX","RY","RZ","SA","SB","SC","SD","SE","SF","SG","SH","SI","SJ","SK","SL","SM","SN","SO","SP","SQ","SR","SS","ST","SU","SV","SW","SX","SY","SZ","TA","TB","TC","TD","TE","TF","TG","TH","TI","TJ","TK","TL","TM","TN","TO","TP","TQ","TR","TS","TT","TU","TV","TW","TX","TY","TZ","UA","UB","UC","UD","UE","UF","UG","UH","UI","UJ","UK","UL","UM","UN","UO","UP","UQ","UR","US","UT","UU","UV","UW","UX","UY","UZ","VA","VB","VC","VD","VE","VF","VG","VH","VI","VJ","VK","VL","VM","VN","VO","VP","VQ","VR","VS","VT","VU","VV","VW","VX","VY","VZ","WA","WB","WC","WD","WE","WF","WG","WH","WI","WJ","WK","WL","WM","WN","WO","WP","WQ","WR","WS","WT","WU","WV","WW","WX","WY","WZ","XA","XB","XC","XD","XE","XF","XG","XH","XI","XJ","XK","XL","XM","XN","XO","XP","XQ","XR","XS","XT","XU","XV","XW","XX","XY","XZ","YA","YB","YC","YD","YE","YF","YG","YH","YI","YJ","YK","YL","YM","YN","YO","YP","YQ","YR","YS","YT","YU","YV","YW","YX","YY","YZ","ZA","ZB","ZC","ZD","ZE","ZF","ZG","ZH","ZI","ZJ","ZK","ZL","ZM","ZN","ZO","ZP","ZQ","ZR","ZS","ZT","ZU","ZV","ZW","ZX","ZY","ZZ"]
    
    @IBOutlet weak var fingerIGE: UIImageView!
    @IBOutlet weak var isoView: UIView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var anchorView: Anchor!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var spinButton: UIButton!
    @IBAction func spinButton(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "spin"), object: nil)
        spinButton.isEnabled = false
        isoLabel.isHidden = true
        isoLabel.textColor = .black
        fingerIGE.isHidden = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "down"), object: nil)
//        timer =  Timer.scheduledTimer(timeInterval: 0.25, target: self, selector:#selector(ViewController.isoText), userInfo: nil, repeats: true)
//    }
//    var timer: Timer?
//    var i = 0
//    @objc func isoText(){
//        if i >= isoArray.count {
//            i = 0
//            timer!.invalidate()
//        } else {
//
//            isoLabel.text = isoArray[i]
//            i += 1
//        }
    }
    
    
    @IBOutlet weak var spinPush: UIImageView!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var upLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var downLabel: UILabel!
    @IBOutlet weak var isoLabel: UILabel!
    
    @IBAction func upButtonPush(_ sender: Any) {
        upButton.isSelected = true
        if downButton.isSelected == false {
        downButton.isEnabled = false
        downButton.isHidden = true
        upButton.isEnabled = false
        upButton.isHidden = true
        upLabel.pulsateRep()
        downLabel.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "upFlip"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWheel"), object: nil)
            self.upLabel.isHidden = true
      }
     }
    }
    @IBAction func downButtonPush(_ sender: Any) {
        downButton.isSelected = true
        if upButton.isSelected == false {
        upButton.isEnabled = false
        upButton.isHidden = true
        downButton.isEnabled = false
        downButton.isHidden = true
        downLabel.pulsateRep()
        upLabel.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "upFlip"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addWheel"), object: nil)
            self.downLabel.isHidden = true
      }
     }
    }
    @objc func enableButton(){
        upButton.isEnabled = true
        downButton.isEnabled = true
        upButton.isHidden = false
        downButton.isHidden = false
        upLabel.isHidden = false
        downLabel.isHidden = false
    }
    func disableButtonStart(){
        upButton.isEnabled = false
        downButton.isEnabled = false
        upButton.isHidden = true
        downButton.isHidden = true
        spinButton.isEnabled = false
        spinButton.isHidden = true
        spinPush.isHidden = true
        upLabel.isHidden = true
        downLabel.isHidden = true
        isoLabel.isHidden = true
        fingerIGE.isHidden = true
    }

    @objc func enableSpinButton(){
        spinButton.isEnabled = true
        spinButton.isHidden = false
        spinPush.isHidden = false
        isoLabel.isHidden = false
        isoLabel.textColor = .red
        isoLabel.text = "GO"
        isoLabel.pulsate()
    }
    @objc func res() {
        result.text = UserDefaults.standard.string(forKey: "Result")
        fingerIGE.isHidden = true
    }


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ert:CGFloat = 60
        let ert2:CGFloat = 40
        upLabel.font = upLabel.font.withSize(ert.dp)
        downLabel.font = downLabel.font.withSize(ert.dp)
        isoLabel.font = isoLabel.font.withSize(ert2.dp2)
        let wS = CGFloat(UserDefaults.standard.float(forKey: "wheelSize") / 2)
        let wS2 = CGFloat(UserDefaults.standard.float(forKey: "wheelSize") * 0.03412478336)
        self.isoView.translatesAutoresizingMaskIntoConstraints = false
        self.isoView.topAnchor.constraint(equalTo: self.isoView.superview!.topAnchor, constant: wS).isActive = true
        self.resultView.translatesAutoresizingMaskIntoConstraints = false
        self.resultView.bottomAnchor.constraint(equalTo: self.resultView.superview!.bottomAnchor, constant: -wS).isActive = true
        self.anchorView.translatesAutoresizingMaskIntoConstraints = false
        self.anchorView.bottomAnchor.constraint(equalTo: self.anchorView.superview!.bottomAnchor, constant: wS2).isActive = true
        disableButtonStart()
        NotificationCenter.default.addObserver(self, selector: #selector(enableButton), name: NSNotification.Name(rawValue: "resting"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enableSpinButton), name: NSNotification.Name(rawValue: "enableSpinButton"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(res), name: NSNotification.Name(rawValue: "res"), object: nil)
    }
}

