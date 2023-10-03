import UIKit

extension UIColor {
    
    convenience init(components red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let const: CGFloat = 255.0
        self.init(red: red / const, green: green / const, blue: blue / const, alpha: alpha)
    }
    
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static var tabBarItemAccent: UIColor {
        #colorLiteral(red: 0.2392156869, green: 0.6504877145, blue: 0.9686274529, alpha: 1)
    }
    
    static var tabBarMain: UIColor {
        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    static var tabBarNotChosen: UIColor {
        #colorLiteral(red: 0.6969500184, green: 0.6969498992, blue: 0.6969498992, alpha: 1)
    }
}
