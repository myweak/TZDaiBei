//
//  UIColor+Extension.swift
//  XunHuiFinance
//
//  Created by lisilong on 2018/01/08.
//  Copyright © 2018年 TDW.CN. All rights reserved.
//

import UIKit

extension UIColor {
    // MARK: - 基础用色
    
    /// App 主色调
    open class var tintColor: UIColor { return UIColor.color(hex: "#3a4153") }
    /// 纯白-内容板块背景、列表视图背景
    open class var contentViewColor: UIColor { return UIColor.color(hex: "#ffffff") }
    /// 浅白-页面底色
    open class var viewColor: UIColor { return UIColor.color(hex: "#f7f7f7") }
    /// 深蓝-导航栏颜色
    open class var navigationBarTintColor: UIColor { return UIColor.color(hex: "#3a4153") }
    
    /// 淡白-cell的高亮色
    open class var cellHighlightedColor: UIColor { return UIColor.color(hex: "#E6E6E6") }
    
    
    // MARK: - 分隔线用色
    
    /// 分隔线颜色
    open class var spaceLineColor: UIColor { return UIColor.color(hex: "#e5e5e5") }
    
    
    // MARK: - 文字用色
    
    /// 纯白-按钮文字、颜色背景上的文字
    open class var titleBackgroundColor: UIColor { return UIColor.color(hex: "#ffffff") }
    /// 浅灰-输入框类的提示文字
    open class var titleTextFieldColor: UIColor { return UIColor.color(hex: "#cccccc") }
    /// 深灰-备注提示性文字（或需要弱化的文字）
    open class var titleNoteColor: UIColor { return UIColor.color(hex: "#999999") }
    /// 中灰-Tab栏
    open class var titleTabBarColor: UIColor { return UIColor.color(hex: "#666666") }
    /// 黑色-标题、金额等重要文字
    open class var titlePriceColor: UIColor { return UIColor.color(hex: "#333333") }
    /// 金色-按钮用色、登录注册模块的文字链接、神蓝色背景上的文字
    open class var titleLinkColor: UIColor { return UIColor.color(hex: "#cead78") }
    /// 棕色-提醒文字、白底上的文字链接
    open class var titleWarnColor: UIColor { return UIColor.color(hex: "#b17e47") }
    /// 橙色-醒目提示、退出按钮用色
    open class var titleBackButtonColor: UIColor { return UIColor.color(hex: "#fa6419") }
    
    // MARK: - UIButton 背景颜色
    /// normal   状态背景颜色
    open class var buttonNormalColor: UIColor { return UIColor.color(hex: "#cead78") }
    /// selected 状态背景颜色
    open class var buttonSelectedColor: UIColor { return UIColor.color(hex: "#b99b6c") }
    /// disabled 状态背景颜色
    open class var buttonDisabledColor: UIColor { return UIColor.color(hex: "#cacacc") }
    
    
    // MARK: - 其它
    
    /// 随机色
    open class var randomColor: UIColor {
        get {
            return UIColor.color(red:   CGFloat(arc4random() % 256),
                                 green: CGFloat(arc4random() % 256),
                                 blue:  CGFloat(arc4random() % 256))
        }
    }
    
    /// 直接通过RGBA值创建UIColor
    open class func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }

    /// 把16进制色 ==> UIColor
    ///
    /// - Parameter hex: 16进制色字符串
    /// - Returns: UIColor
    open class func color(hex hexStr: String, alpha: CGFloat = 1.0) -> UIColor {
        var hex: String = hexStr
        if (hex.hasPrefix("#")) {
            hex.remove(at: hex.startIndex)
        }
        guard hex.count == 6 else {
            return UIColor.tintColor
        }
        let redStart = hex.index(hex.startIndex, offsetBy: 0)
        let redEnd   = hex.index(hex.startIndex, offsetBy: 2)
        let redStr: String = String(hex[redStart..<redEnd])
        
        let greenStart = hex.index(hex.startIndex, offsetBy: 2)
        let greenEnd   = hex.index(hex.startIndex, offsetBy: 4)
        let greenStr: String = String(hex[greenStart..<greenEnd])

        let blueStart = hex.index(hex.startIndex, offsetBy: 4)
        let blueEnd   = hex.index(hex.startIndex, offsetBy: 6)
        let blueStr: String = String(hex[blueStart..<blueEnd])

        var red: UInt32 = 0, green: UInt32 = 0, blue: UInt32 = 0
        Scanner(string: redStr).scanHexInt32(&red)
        Scanner(string: greenStr).scanHexInt32(&green)
        Scanner(string: blueStr).scanHexInt32(&blue)
        return UIColor.color(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: alpha)
    }
    
    /// 用数值初始化颜色，便于生成设计图上标明的十六进制颜色
    convenience init(valueRGB: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((valueRGB & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((valueRGB & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(valueRGB & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
