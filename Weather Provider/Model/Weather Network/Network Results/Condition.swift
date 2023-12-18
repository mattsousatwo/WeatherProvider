//
//  Condition.swift
//  Weather Provider
//
//  Created by Matthew Sousa on 12/18/23.
//

import Foundation
import SwiftUI

struct Condition: Codable {
    var text: String
    var icon: String
    var code: Int
    
    func image() -> Image {
        
        var conditionImage: ConditionImage = .sun
        
        switch code {
            case 1000:
                conditionImage = .sun
            case 1003:
                conditionImage = .partlyCloudy
            case 1006, 1009:
                conditionImage = .cloudy
            case 1030, 1035, 1147:
                conditionImage = .fog
            case 1063, 1150, 1153, 1180, 1240:
                conditionImage = .cloudyDrizzle
            case 1066, 1117, 1210, 1213, 1216, 1219, 1222, 1225, 1255:
                conditionImage = .cloudySnow
            case 1069, 1204, 1207, 1249, 1252:
                conditionImage = .cloudySleet
            case 1072, 1168, 1171, 1198, 1201, 1237:
                conditionImage = .cloudyHail
            case 1114:
                conditionImage = .windySnow
            case 1183, 1189, 1195, 1243:
                conditionImage = .cloudyRain
            case 1186, 1192, 1246:
                conditionImage = .cloudyHeavyRain
            case 1087:
                conditionImage = .cloudySnowThunder
            default:
                conditionImage = .sun
        }
        
        return Image(systemName: conditionImage.image)
        
    }
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case icon = "icon"
        case code = "code"
    }
    
    enum ConditionImage: Int,  CaseIterable {
        case sun = 000001
        case partlyCloudy = 000002
        case cloudy = 000003
        case fog = 000004
        case cloudyDrizzle = 000005
        case cloudySnow = 000006
        case cloudySleet = 000007
        case cloudyHail = 000008
        case windySnow = 000009
        case cloudyRain = 000010
        case cloudyHeavyRain = 000011
        case cloudySnowThunder = 000012
        
        var image: String {
            switch self {
                case .sun:
                    return "sun.max.fill"
                case .partlyCloudy:
                    return "cloud.sun.fill"
                case .cloudy:
                    return "cloud.fill"
                case .fog:
                    return "cloud.fog.fill"
                case .cloudyDrizzle:
                    return "cloud.drizzle.fill"
                case .cloudySnow:
                    return "cloud.snow.fill"
                case .cloudySleet:
                    return "cloud.sleet.fill"
                case .cloudyHail:
                    return "cloud.hail.fill"
                case .windySnow:
                    return "wind.snow"
                case .cloudyRain:
                    return "cloud.rain.fill"
                case .cloudyHeavyRain:
                    return "cloud.heavyrain.fill"
                case .cloudySnowThunder:
                    return "cloud.bolt.rain.fill"
            }
        }
        
        
        
        
        
    }
    
}
