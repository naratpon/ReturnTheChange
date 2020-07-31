import XCTest
import Quick
import Nimble

@testable import ReturnTheChange

class ReturnMoneyPresenterTests: QuickSpec {
    override func spec() {
        describe("ReturnMoneyPresenterTests") {
            var presenter: ReturnMoneyPresenter!
            var viewController: ReturnMoneyViewController!
            beforeEach {
                presenter = ReturnMoneyPresenter()
                viewController = ReturnMoneyViewController()
                presenter.viewController = viewController
            }
            
            context("Check Validate Number Only") {
                it("should be true") {
                    presenter.showValidateNumber(isValidateNumber: true, textReceive: "123", textPrize: "123")
                    expect(viewController.textReceive).notTo(beNil())
                }
                it("should be false") {
                    presenter.showValidateNumber(isValidateNumber: false, textReceive: "test", textPrize: "123")
                    expect(viewController.textError).notTo(beNil())
                }
            }
            
            context("Check Validate Button") {
                it("should be true") {
                    presenter.showValidateButton(isValidateButton: true)
                    expect(viewController.isEnable) == true
                }
                it("should be false") {
                    presenter.showValidateButton(isValidateButton: false)
                    expect(viewController.isEnable) == false
                }
            }
            
            context("Calucalate Result") {
                it("show be not nil") {
                    presenter.showCalculate(result: [500,100])
                    expect(viewController.resultCalulate).notTo(beNil())
                }
            }
        }
    }
}

extension ReturnMoneyPresenterTests {
    class ReturnMoneyViewController: ReturnMoneyDisplayLogic {
        var textError: String = ""
        var textReceive: Int = 0
        var isReceiveMoreThanPrize = false
        var isEnable: Bool = false
        var resultCalulate: [String] = []
        
        func displayNumber(textReceive: Int, textPrize: Int) {
            self.textReceive = textReceive
        }
        
        func displayNumberError(text: String) {
            self.textError = text
        }
        
        func displayButton(isValidateButton: Bool) {
            self.isEnable = isValidateButton
        }
        
        func displayCalculate(result: [String]) {
            self.resultCalulate = result
        }
    }
}
