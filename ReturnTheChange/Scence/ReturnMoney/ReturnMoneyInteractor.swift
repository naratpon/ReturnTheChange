import UIKit

protocol ReturnMoneyBusinessLogic {
    func validateNumber(textReceive: String, textPrize: String)
    func validateButton(textReceive: String, textPrize: String)
    func calculate(textReceive: String, textPrize: String, prizeOfMoney: [Int])
}

protocol ReturnMoneyDataStore {
    //var name: String { get set }
}

class ReturnMoneyInteractor: ReturnMoneyBusinessLogic, ReturnMoneyDataStore {
    // MARK: - Properties
    var presenter: ReturnMoneyPresentationLogic?
    var worker: ReturnMoneyWorker?
    //var name: String = ""
    
    // MARK: - Initializer
    init(worker: ReturnMoneyWorker = ReturnMoneyWorker()) {
        self.worker = worker
    }
    
    // MARK: - ReturnMoneyBusinessLogic
    func validateNumber(textReceive: String, textPrize: String) {
        if textReceive.validateNumberOnly() && textPrize.validateNumberOnly() {
            presenter?.showValidateNumber(isValidateNumber: true, textReceive: textReceive, textPrize: textPrize)
        }else {
            presenter?.showValidateNumber(isValidateNumber: false, textReceive: textReceive, textPrize: textPrize)
        }
    }
    
    func validateButton(textReceive: String, textPrize: String) {
        if textReceive.count > 0 && textPrize.count > 0 {
            presenter?.showValidateButton(isValidateButton: true)
        }else {
            presenter?.showValidateButton(isValidateButton: false)
        }
    }
    
    func calculate(textReceive: String, textPrize: String, prizeOfMoney: [Int]) {
        var value:Int = (Int(textReceive) ?? 0) - (Int(textPrize) ?? 0)
        var result:[Int] = []
        for moneyType in prizeOfMoney {
            result.append(value/moneyType)
            value = value%moneyType
        }
        presenter?.showCalculate(result: result)
    }
}

