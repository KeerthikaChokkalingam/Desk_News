//
//  AlertView.swift
//  DeskNews
//
//  Created by Keerthika on 12/03/24.
//

import UIKit

class AlertView: UIView {
    
    let mgsLbl : UILabel =
    {
        let lbl = UILabel()
        //lbl.text = "MULTI  SQUARE  OFF"
        lbl.text = ""
        lbl.textAlignment = .center
        lbl.textColor = Thememanager.shared.tabBarTintColor
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.numberOfLines = 0
        return lbl
        
    }()
    let okBtn : UIButton =
    {
        let btn = UIButton()
        //lbl.text = "MULTI  SQUARE  OFF"
        btn.setTitle("OK", for: .normal)
        btn.backgroundColor = Thememanager.shared.tabBarTintColor
        btn.layer.cornerRadius = 10
        btn.setTitleColor(Thememanager.shared.mainBgColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return btn
        
    }()
    let cancelBtn : UIButton =
    {
        let btn = UIButton()
        //lbl.text = "MULTI  SQUARE  OFF"
        btn.setTitle("CANCEL", for: .normal)
        btn.backgroundColor = Thememanager.shared.tabBarTintColor
        btn.layer.cornerRadius = 10
        btn.setTitleColor(Thememanager.shared.mainBgColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return btn
        
    }()
    var fromCtegory: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
    }
    
    func setUpUI() {
        self.addSubview(mgsLbl)
        self.addSubview(okBtn)
        self.addSubview(cancelBtn)
    }
    func reloadView() {
        mgsLbl.frame = CGRect(x: 10, y:  0, width: Int(self.frame.width) - 10, height: 70)
        okBtn.frame = CGRect(x: Int(mgsLbl.frame.midX - 100), y: Int(mgsLbl.frame.maxY), width: 60, height: 35)
        cancelBtn.frame = CGRect(x: Int(okBtn.frame.maxX) + 50, y: Int(mgsLbl.frame.maxY), width: 100, height: 35)
        if fromCtegory != nil {
            if fromCtegory == true {
                mgsLbl.text = "Selected Category will display in Dashboard. \n Please confirm"
            } else {
                mgsLbl.text = "Selected Country will display in Dashboard. \n Please confirm"
            }
        }
    }
    
}
