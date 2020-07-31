import UIKit
import Localize_Swift

protocol ReturnMoneyPresentationLogic {
    func showValidateNumber(isValidateNumber: Bool, textReceive: String, textPrize: String)
    func showValidateButton(isValidateButton: Bool)
    func showCalculate(result: [Int])
}

class ReturnMoneyPresenter: ReturnMoneyPresentationLogic {
    // MARK: - Properties
    weak var viewController: ReturnMoneyDisplayLogic?
    
    // MARK: - Present
    func showValidateNumber(isValidateNumber: Bool, textReceive: String, textPrize: String) {
        if isValidateNumber {
            viewController?.displayNumber(textReceive: Int(textReceive) ?? 0, textPrize: Int(textPrize) ?? 0)
        }else {
            viewController?.displayNumberError(text: "warning_numbe_only".localized())
        }
    }
    
    func showValidateButton(isValidateButton: Bool) {
        viewController?.displayButton(isValidateButton: isValidateButton)
    }
    
    func showCalculate(result: [Int]) {
        let resultMoneyString = result.map { String($0) }
        viewController?.displayCalculate(result: resultMoneyString)
    }
}
