//
//  LocalizedStringKey.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 11/11/23.
//

import Foundation
import SwiftUI

extension LocalizedStringKey {
    var originalString: String {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String ?? "Empty String"
    }
}

extension String {
    func localized() -> String {
        return self.localizedLowercase
    }
}

extension String {
    static func localizedString(for key: String,
                                locale: Locale = .current) -> String {
        
        let language = locale.language.languageCode?.identifier
        let path = Bundle.main.path(forResource: language, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        
        return localizedString
    }
}

extension LocalizedStringKey {
    func stringValue(locale: Locale = .current) -> String {
        return .localizedString(for: self.originalString, locale: locale)
    }
}

extension LocalizedStringResource {
    var originalString: String {
        Mirror(reflecting: self).children.first(where: { $0.label == "key" })?.value as? String ?? "Empty String"
    }
}

extension LocalizedStringResource {
    func stringValue(locale: Locale = .current) -> String {
        return .localizedString(for: self.originalString, locale: locale)
    }
}
