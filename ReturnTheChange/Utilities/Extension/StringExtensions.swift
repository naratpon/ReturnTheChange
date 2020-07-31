import Foundation
import UIKit

extension String {
    func validateNumberOnly() -> Bool {
        let allowingChars = "0123456789"
        let numberOnly = NSCharacterSet.init(charactersIn: allowingChars).inverted
        let validNumber = self.rangeOfCharacter(from: numberOnly) == nil
        return validNumber
    }
}
