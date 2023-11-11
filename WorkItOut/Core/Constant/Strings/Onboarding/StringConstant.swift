//
//  OnboardingStringConstant.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 11/11/23.
//

import Foundation
import SwiftUI

extension Constant {
    struct String {
        struct Enum {
            struct AssesmentState {
               
            }
            
            struct Day {
                static let monday: LocalizedStringResource = "Monday"
                static let tuesday: LocalizedStringResource = "Tuesday"
                static let wednesday: LocalizedStringResource = "Wednesday"
                static let thursday: LocalizedStringResource = "Thursday"
                static let friday: LocalizedStringResource = "Friday"
                static let saturday: LocalizedStringResource = "Saturday"
                static let sunday: LocalizedStringResource = "Sunday"
            }
        }
        
        struct Onboarding {
            struct OnboardingView {
                static let title: LocalizedStringResource = "Welcome to Mamaste"
                static let desc: LocalizedStringResource = "Your personalized yoga guide for a healthy pregnancy"
                static let button: LocalizedStringResource = "Get Started"
            }
            
            struct CompleteView {
                static let title: LocalizedStringResource = "Creating Exercise Plan"
                static let desc: LocalizedStringResource = "Please wait, we are crafting the best exercise plan for you"
                
                struct Strings {
                    static let first: LocalizedStringResource = "Curating best yoga poses for your pregnancy weeks"
                    static let second: LocalizedStringResource = "Taking into account your health conditions"
                    static let third: LocalizedStringResource = "Predicting best sessions for your schedules"
                }
            }
            
            
        }
    }
}


