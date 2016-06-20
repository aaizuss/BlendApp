//
//  GradColors.swift
//  BlendApp
//
//  Created by Amanda Aizuss on 6/17/16.
//  Copyright © 2016 aaizuss. All rights reserved.
//

import Foundation
import UIKit

typealias GradTuple = (top: CGColor, bottom: CGColor)

/// - Attributions: http://www.jessesquires.com/swift-namespaced-constants/
/// A bunch of preset colors to use for choosing random gradients
/// Some colors from http://uigradients.com

extension UIColor {
    
    /// var color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
    /// - Attribution: http://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values-in-swift-ios
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /// var color2 = UIColor(netHex:0xFFFFFF)
    /// - Attribution http://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values-in-swift-ios
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    struct GradPalette {
        struct PinkDarkBlue {
            static let Top = UIColor(red: 242/255, green: 148/255, blue: 146/255, alpha: 1).cgColor
            static let Bottom = UIColor(red: 17/255, green: 67/255, blue: 87/255, alpha: 1).cgColor
        }
        
        struct BrightPurple {
            static let Top = UIColor(red: 160/255, green: 68/255, blue: 255/255, alpha: 1).cgColor
            static let Bottom = UIColor(red: 106/255, green: 48/255, blue: 147/255, alpha: 1).cgColor
        }
        
        struct Blush {
            static let Top = UIColor(red: 178/255, green: 69/255, blue: 146/255, alpha: 1).cgColor
            static let Bottom = UIColor(red: 241/255, green: 95/255, blue: 121/255, alpha: 1).cgColor
        }
        
        struct Virgin {
            static let Top = UIColor(red: 123/255, green: 67/255, blue: 151/255, alpha: 1).cgColor
            static let Bottom = UIColor(red: 220/255, green: 36/255, blue: 48/255, alpha: 1).cgColor
        }
        
        struct Turquoise {
            static let Top = UIColor(red: 19/255, green: 106/255, blue: 138/255, alpha: 1).cgColor
            static let Bottom = UIColor(red: 113/255, green: 120/255, blue: 113/255, alpha: 1).cgColor
        }
        
        struct Dawn {
            static let Top = UIColor(red: 255/255, green: 161/255, blue: 127/255, alpha: 1).cgColor
            static let Bottom = UIColor(red: 0/255, green: 34/255, blue: 62/255, alpha: 1).cgColor
        }
        
        struct RedLightBlueGray {
            static let Top = UIColor(netHex: 0xaf0820).cgColor
            static let Bottom = UIColor(netHex: 0xaee9e7).cgColor
        }
        
        struct SeaGreens {
            static let Top = UIColor(netHex: 0x4fb394).cgColor
            static let Bottom = UIColor(netHex: 0xa2b9e5).cgColor
        }
        
        struct WaterFire {
            static let Top = UIColor(netHex: 0xf58758).cgColor
            static let Bottom = UIColor(netHex: 0x56baae).cgColor
        }
        
        struct Purples {
            static let Top = UIColor(netHex: 0x9D50BB).cgColor
            static let Bottom = UIColor(netHex: 0x6E48AA).cgColor
        }
        
        struct Sun {
            static let Top = UIColor(netHex: 0xFF4E50).cgColor
            static let Bottom = UIColor(netHex: 0xF9D423).cgColor
        }
        
        struct CherryBlossoms {
            static let Top = UIColor(netHex: 0xFBD3E9).cgColor
            static let Bottom = UIColor(netHex: 0xBB377D).cgColor
        }
        
        struct ShadowNight {
            static let Top = UIColor(netHex: 0x000000).cgColor
            static let Bottom = UIColor(netHex: 0x53346D).cgColor
        }
        
        struct Ash {
            static let Top = UIColor(netHex: 0x606c88).cgColor
            static let Bottom = UIColor(netHex: 0x3f4c6b).cgColor
        }
        
        struct Watermelon {
            static let Top = UIColor(netHex: 0xC9FFBF).cgColor
            static let Bottom = UIColor(netHex: 0xFFAFBD).cgColor
        }
        
        struct DirtyFog {
            static let Top = UIColor(netHex: 0xB993D6).cgColor
            static let Bottom = UIColor(netHex: 0x8CA6DB).cgColor
        }
        
        struct Reef {
            static let Top = UIColor(netHex: 0x00d2ff).cgColor
            static let Bottom = UIColor(netHex: 0x3a7bd5).cgColor
        }
        
        struct Candy {
            static let Top = UIColor(netHex: 0xD3959B).cgColor
            static let Bottom = UIColor(netHex: 0xBFE6BA).cgColor
        }
        
        struct Autumn {
            static let Top = UIColor(netHex: 0xDAD299).cgColor
            static let Bottom = UIColor(netHex: 0x3a7bd5).cgColor
        }
        struct Candy2 {
            static let Top = UIColor(netHex: 0xddd6f3).cgColor
            static let Bottom = UIColor(netHex: 0xfaaca8).cgColor
        }
        struct Aqua {
            static let Top = UIColor(netHex: 0x00d2ff).cgColor
            static let Bottom = UIColor(netHex: 0x3a7bd5).cgColor
        }
        struct Sirius {
            static let Top = UIColor(netHex: 0x50C9C3).cgColor
            static let Bottom = UIColor(netHex: 0x96DEDA).cgColor
        }
        struct Pale {
            static let Top = UIColor(netHex: 0xEFEFBB).cgColor
            static let Bottom = UIColor(netHex: 0xDDEFBB).cgColor
        }
        struct Memory {
            static let Top = UIColor(netHex: 0xDE6262).cgColor
            static let Bottom = UIColor(netHex: 0xFFB88C).cgColor
        }
        struct Sunset {
            static let Top = UIColor(netHex: 0xd53369).cgColor
            static let Bottom = UIColor(netHex: 0xcbad6d).cgColor
        }
        struct MidnightBlue {
            static let Top = UIColor(netHex: 0x4b6cb7).cgColor
            static let Bottom = UIColor(netHex: 0x182848).cgColor
        }
        
        struct Superman {
            static let Top = UIColor(netHex: 0xFC354C).cgColor
            static let Bottom = UIColor(netHex: 0x0ABFBC).cgColor
        }
        
        struct Influenza {
            static let Top = UIColor(netHex: 0xC04848).cgColor
            static let Bottom = UIColor(netHex: 0x480048).cgColor
        }
        
        struct TurqPurple {
            static let Top = UIColor(netHex: 0x5f2c82).cgColor
            static let Bottom = UIColor(netHex: 0x49a09d).cgColor
        }
        
        struct Bourbon {
            static let Top = UIColor(netHex: 0xEC6F66).cgColor
            static let Bottom = UIColor(netHex: 0xF3A183).cgColor
        }
        
        struct Stellar {
            static let Top = UIColor(netHex: 0x7474BF).cgColor
            static let Bottom = UIColor(netHex: 0x348AC7).cgColor
        }
        
        struct Moonrise {
            static let Top = UIColor(netHex: 0xDAE2F8).cgColor
            static let Bottom = UIColor(netHex: 0xD6A4A4).cgColor
        }
        
        struct Peach {
            static let Top = UIColor(netHex: 0xED4264).cgColor
            static let Bottom = UIColor(netHex: 0xFFEDBC).cgColor
        }
        
        struct Mantle {
            static let Top = UIColor(netHex: 0x24C6DC).cgColor
            static let Bottom = UIColor(netHex: 0x514A9D).cgColor
        }
        
        struct Opa {
            static let Top = UIColor(netHex: 0x3D7EAA).cgColor
            static let Bottom = UIColor(netHex: 0xFFE47A).cgColor
        }
        
        struct SeaBlizz {
            static let Top = UIColor(netHex: 0x1CD8D2).cgColor
            static let Bottom = UIColor(netHex: 0x93EDC7).cgColor
        }
        
        struct BluePurpleDark {
            static let Top = UIColor(netHex: 0x5C258D).cgColor
            static let Bottom = UIColor(netHex: 0x4389A2).cgColor
        }
        
        struct BoraBora {
            static let Top = UIColor(netHex: 0x2BC0E4).cgColor
            static let Bottom = UIColor(netHex: 0xEAECC6).cgColor
        }
        
        struct VeniceBlue {
            static let Top = UIColor(netHex: 0x085078).cgColor
            static let Bottom = UIColor(netHex: 0x85D8CE).cgColor
        }
        
        struct ElectricViolet {
            static let Top = UIColor(netHex: 0x4776E6).cgColor
            static let Bottom = UIColor(netHex: 0x8E54E9).cgColor
        }
        
        struct OrangeJuice {
            static let Top = UIColor(netHex: 0xFF8008).cgColor
            static let Bottom = UIColor(netHex: 0xFFC837).cgColor
        }
        
        struct Pinky {
            static let Top = UIColor(netHex: 0xDD5E89).cgColor
            static let Bottom = UIColor(netHex: 0xF7BB97).cgColor
        }
        
        struct Cherry {
            static let Top = UIColor(netHex: 0xEB3349).cgColor
            static let Bottom = UIColor(netHex: 0xF45C43).cgColor
        }
        
        struct Aubergine {
            static let Top = UIColor(netHex: 0xAA076B).cgColor
            static let Bottom = UIColor(netHex: 0x61045F).cgColor
        }
        
        struct BloodyMary {
            static let Top = UIColor(netHex: 0xFF512F).cgColor
            static let Bottom = UIColor(netHex: 0xDD2476).cgColor
        }
        
        struct MangoPulp {
            static let Top = UIColor(netHex: 0xF09819).cgColor
            static let Bottom = UIColor(netHex: 0xEDDE5D).cgColor
        }
        
        struct HarmonicEnergy {
            static let Top = UIColor(netHex: 0x16A085).cgColor
            static let Bottom = UIColor(netHex: 0xF4D03F).cgColor
        }
        
        struct Tranquil {
            static let Top = UIColor(netHex: 0xF09819).cgColor
            static let Bottom = UIColor(netHex: 0xEDDE5D).cgColor
        }
        
        struct SweetMorning {
            static let Top = UIColor(netHex: 0xEECDA3).cgColor
            static let Bottom = UIColor(netHex: 0xEF629F).cgColor
        }
        
        struct Lipstick {
            static let Top = UIColor(hue: 323/360, saturation: 65/100, brightness: 95/100, alpha: 1).cgColor
            static let Bottom = UIColor(hue: 0, saturation: 66/100, brightness: 95/100, alpha: 1).cgColor
        }
        
        struct Lipstick2 {
            static let Top = UIColor(hue: 323/360, saturation: 65/100, brightness: 95/100, alpha: 1).cgColor
            static let Bottom = UIColor(hue: 353/360, saturation: 78/100, brightness: 96/100, alpha: 1).cgColor
        }
        
        struct DefaultColor {
            static let Top = UIColor(hue: 198/360, saturation: 19/100, brightness: 100/100, alpha: 1).cgColor
            static let Bottom = UIColor(hue: 251/360, saturation: 35/100, brightness: 100/100, alpha: 1).cgColor
        }
        
        struct Seashell {
            static let Top = UIColor(hue: 326/360, saturation: 18/100, brightness: 96/100, alpha: 1).cgColor
            static let Bottom = UIColor(hue: 23/360, saturation: 40/100, brightness: 96/100, alpha: 1).cgColor
        }
        
        struct Glass {
            static let Top = UIColor(red: 142/255, green: 158/255, blue: 171/255, alpha: 1).cgColor
            static let Bottom = UIColor(red: 238/255, green: 242/255, blue: 243/255, alpha: 1).cgColor
        }
        
        struct Rise {
            static let Top = UIColor(red: 255/255, green: 107/255, blue: 107/255, alpha: 1).cgColor
            static let Bottom = UIColor(red: 85/255, green: 98/255, blue: 112/255, alpha: 1).cgColor
        }
        
        struct Horizon {
            static let Top = UIColor(netHex: 0x003973).cgColor
            static let Bottom = UIColor(netHex: 0xE5E5BE).cgColor
        }
        
        struct LemonTwist {
            static let Top = UIColor(netHex: 0x3CA55C).cgColor
            static let Bottom = UIColor(netHex: 0xB5AC49).cgColor
        }
        
        struct Sylvia {
            static let Top = UIColor(netHex: 0xff4b1f).cgColor
            static let Bottom = UIColor(netHex: 0xff9068).cgColor
        }
        
        struct Pizelex {
            static let Top = UIColor(netHex: 0x114357).cgColor
            static let Bottom = UIColor(netHex: 0xF29492).cgColor
        }
    }
    
    /// Randomly select a gradient tuple (top color, bottom color) from the above colors
    /// Call this function when detect shake
    /// - Attributions: http://codereview.stackexchange.com/questions/81873/choosing-a-random-flat-color
    func getRandomGrad() -> GradTuple {
        struct RandomGrads {
            static let colors: Array<GradTuple> = [
                (GradPalette.PinkDarkBlue.Top, GradPalette.PinkDarkBlue.Bottom),
                (GradPalette.BrightPurple.Top, GradPalette.BrightPurple.Bottom),
                (GradPalette.Blush.Top, GradPalette.Blush.Bottom),
                (GradPalette.Virgin.Top, GradPalette.Virgin.Bottom),
                (GradPalette.Glass.Top, GradPalette.Glass.Bottom),
                (GradPalette.Turquoise.Top, GradPalette.Turquoise.Bottom),
                (GradPalette.Dawn.Top, GradPalette.Dawn.Bottom),
                (GradPalette.Sunset.Top, GradPalette.Sunset.Bottom),
                (GradPalette.Rise.Top, GradPalette.Rise.Bottom),
                (GradPalette.Watermelon.Top, GradPalette.Watermelon.Bottom),
                (GradPalette.Seashell.Top, GradPalette.Seashell.Bottom),
                (GradPalette.Lipstick.Top, GradPalette.Lipstick.Bottom),
                (GradPalette.Lipstick2.Top, GradPalette.Lipstick2.Bottom),
                (GradPalette.Aqua.Top, GradPalette.Aqua.Bottom),
                (GradPalette.Ash.Top, GradPalette.Ash.Bottom),
                (GradPalette.Aubergine.Top, GradPalette.Aubergine.Bottom),
                (GradPalette.Autumn.Top, GradPalette.Autumn.Bottom),
                (GradPalette.BloodyMary.Top, GradPalette.BloodyMary.Bottom),
                (GradPalette.BluePurpleDark.Top, GradPalette.BluePurpleDark.Bottom),
                (GradPalette.BoraBora.Top, GradPalette.BoraBora.Bottom),
                (GradPalette.Bourbon.Top, GradPalette.Bourbon.Bottom),
                (GradPalette.Candy.Top, GradPalette.Candy.Bottom),
                (GradPalette.Candy2.Top, GradPalette.Candy2.Bottom),
                (GradPalette.Cherry.Top, GradPalette.Cherry.Bottom),
                (GradPalette.CherryBlossoms.Top, GradPalette.CherryBlossoms.Bottom),
                (GradPalette.DirtyFog.Top, GradPalette.DirtyFog.Bottom),
                (GradPalette.ElectricViolet.Top, GradPalette.ElectricViolet.Bottom),
                (GradPalette.HarmonicEnergy.Top, GradPalette.HarmonicEnergy.Bottom),
                (GradPalette.Influenza.Top, GradPalette.Influenza.Bottom),
                (GradPalette.Mantle.Top, GradPalette.Mantle.Bottom),
                (GradPalette.Memory.Top, GradPalette.Memory.Bottom),
                (GradPalette.Moonrise.Top, GradPalette.Moonrise.Bottom),
                (GradPalette.MangoPulp.Top, GradPalette.MangoPulp.Bottom),
                (GradPalette.MidnightBlue.Top, GradPalette.MidnightBlue.Bottom),
                (GradPalette.Opa.Top, GradPalette.Opa.Bottom),
                (GradPalette.OrangeJuice.Top, GradPalette.OrangeJuice.Bottom),
                (GradPalette.Reef.Top, GradPalette.Reef.Bottom),
                (GradPalette.Sun.Top, GradPalette.Sun.Bottom),
                (GradPalette.Sirius.Top, GradPalette.Sirius.Bottom),
                (GradPalette.Stellar.Top, GradPalette.Stellar.Bottom),
                (GradPalette.SeaBlizz.Top, GradPalette.SeaBlizz.Bottom),
                (GradPalette.Superman.Top, GradPalette.Superman.Bottom),
                (GradPalette.SeaGreens.Top, GradPalette.SeaGreens.Bottom),
                (GradPalette.ShadowNight.Top, GradPalette.ShadowNight.Bottom),
                (GradPalette.SweetMorning.Top, GradPalette.SweetMorning.Bottom),
                (GradPalette.Tranquil.Top, GradPalette.Tranquil.Bottom),
                (GradPalette.TurqPurple.Top, GradPalette.TurqPurple.Bottom),
                (GradPalette.VeniceBlue.Top, GradPalette.VeniceBlue.Bottom),
                (GradPalette.WaterFire.Top, GradPalette.WaterFire.Bottom),
                (GradPalette.Horizon.Top, GradPalette.Horizon.Bottom),
                (GradPalette.LemonTwist.Top, GradPalette.LemonTwist.Bottom),
                (GradPalette.Sylvia.Top, GradPalette.Sylvia.Bottom),
                (GradPalette.Pizelex.Top, GradPalette.Pizelex.Bottom)
            ]
        }
        
        let gradCount = UInt32(RandomGrads.colors.count)
        let randomIndex = arc4random_uniform(gradCount)
        let grad = RandomGrads.colors[Int(randomIndex)]
        return grad
    }

}
