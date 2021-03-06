//
//  BSegmentControl.swift
//  BabyCare
//
//  Created by Neo on 2017/3/20.
//  Copyright © 2017年 JL. All rights reserved.
//

import UIKit

protocol BSegmentControlDelegate {
    func segmentSelected(index: Int)
}

class BSegmentControl: UIView {
    
    var items = [UIButton]()
    var flagView: UIView?
    
    var delegate: BSegmentControlDelegate?
    var selectedIndex: Int = 0 {
        willSet {
            let preBtn = items[selectedIndex]
            preBtn.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "555555", alpha: 1), for: .normal)
        }
        
        didSet {
            let currentBtn = items[selectedIndex]
            currentBtn.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "6ec6e2", alpha: 1), for: .normal)
//            UIView.animate(withDuration: 0.15, animations: {
//                [weak self] in
//                self?.flagView?.left = (currentBtn.width+0.5) * CGFloat((self?.selectedIndex)!)
//            })
        }
    }
    
    convenience init(with titles: [String]) {
        self.init(frame:CGRect(x: 0, y: 0, width: Util.screenWidth(), height: 38))
        assert(titles.count > 0, "segment count error")
        
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: 0.5))
        topLine.backgroundColor = UIColor.colorWithHexAndAlpha(hex: "000000", alpha: 0.2)
        self.addSubview(topLine)
        
        let bottomLine = UIView(frame: CGRect(x: 0, y: self.height - 0.5, width: self.width, height: 0.5))
        bottomLine.backgroundColor = UIColor.colorWithHexAndAlpha(hex: "000000", alpha: 0.2)
        self.addSubview(bottomLine)
        
        let width = (self.width - CGFloat(titles.count) * 0.5)/CGFloat(titles.count)
        
//        flagView = UIView(frame: CGRect(x: 0, y: self.height - 2, width: width, height: 1))
//        flagView?.backgroundColor = UIColor.colorWithHexAndAlpha(hex: "333333", alpha: 1)
//        self.addSubview(flagView!)
        
        for i in 0..<titles.count {
            let btn = UIButton(frame: CGRect(x: CGFloat(i) * (width + 0.5), y: 0, width: width, height: self.height))
            btn.setTitleColor(UIColor.colorWithHexAndAlpha(hex: "555555", alpha: 1), for: .normal)

            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitle(titles[i], for: .normal)
            btn.addTarget(self, action: #selector(segmentClicked(item:)), for: .touchUpInside)
            self.addSubview(btn)
            items.append(btn)
            
            if i == titles.count - 1 {
                continue
            }
            
            let vLine = UIView(frame: CGRect(x: btn.right, y: 4, width: 0.5, height: self.height - 8))
            vLine.backgroundColor = UIColor.colorWithHexAndAlpha(hex: "000000", alpha: 0.2)
            self.addSubview(vLine)
        }
    }
    
    func segmentClicked(item: UIButton) {
        let index = items.index(of: item)
        if index == self.selectedIndex {
            return
        }
        self.selectedIndex = index!
        delegate?.segmentSelected(index: index!)
    }

}
