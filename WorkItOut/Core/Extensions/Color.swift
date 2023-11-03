//
//  Color.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 03/11/23.
//

import SwiftUI

extension Color {
    private static let colorDirectory = Color.ColorStyles.self
    
    //Main
    static let background = colorDirectory.Main.background
    static let primary = colorDirectory.Main.background
    
    //Neutral
    static let neutral1 = colorDirectory.Neutral._1
    static let neutral2 = colorDirectory.Neutral._2
    static let netural3 = colorDirectory.Neutral._3
    static let netural4 = colorDirectory.Neutral._4
    static let netural5 = colorDirectory.Neutral._5
    static let netural6 = colorDirectory.Neutral._6
    
    //Transparent
    static let transparent60 = colorDirectory.Transparent._60
    static let transparent20 = colorDirectory.Transparent._20
    
    //Pure
    static let white = colorDirectory.Pure.white
    
    //Semantic
    static let dangerBackground = colorDirectory.Semantic.dangerBackground
    static let dangerPrimary = colorDirectory.Semantic.dangerPrimary
    static let successBackground = colorDirectory.Semantic.successBackground
    static let warningBackground = colorDirectory.Semantic.warningBackground
    static let successPrimary = colorDirectory.Semantic.successPrimary
    static let warningPrimary = colorDirectory.Semantic.warningPrimary
}
