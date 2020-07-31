import XCTest
import Quick
import Nimble

@testable import ReturnTheChange

class ReturnMoneyInteractorTests: QuickSpec {
    override func spec() {
        var interactor: ReturnMoneyInteractor!
        var presenter: MockReturnPresenter!
        var worker: MockReturnWorker!
        beforeEach {
            presenter = MockReturnPresenter()
            worker = MockReturnWorker()
            interactor = ReturnMoneyInteractor(worker: worker)
            interactor.presenter = presenter
        }
        
        context("Check Number Only") {
            it("should be true") {
                let _ = interactor.validateNumber(textReceive: "123", textPrize: "123")
                expect(presenter.mockIsNumberOnly) == true
            }
            it("should be false") {
                let _ = interactor.validateNumber(textReceive: "Test", textPrize: "123")
                expect(presenter.mockIsNumberOnly) == false
            }
        }
        
        context("Check Validate Button Text More Than 0") {
            it("should be true") {
                let _ = interactor.validateButton(textReceive: "1234", textPrize: "1234")
                expect(presenter.mockIsButtonEnable) == true
            }
            it("should be false") {
                let _ = interactor.validateButton(textReceive: "", textPrize: "")
                expect(presenter.mockIsButtonEnable) == false
            }
        }
        
        context("Calculate Return TheCchange") {
            it("should be not nil") {
                let _ = interactor.calculate(textReceive: "1000", textPrize: "500", prizeOfMoney: [500,100])
                expect(presenter.mockdataResult).notTo(beNil())
            }
        }
    }
}

extension ReturnMoneyInteractorTests {
    class MockReturnWorker: ReturnMoneyWorker {
        
    }
    
    class MockReturnPresenter: ReturnMoneyPresenter {
        var mockIsNumberOnly: Bool = false
        var mockIsButtonEnable: Bool = false
        var mockdataResult: [Int] = []
        
        override func showValidateNumber(isValidateNumber: Bool, textReceive: String, textPrize: String) {
            if isValidateNumber {
                self.mockIsNumberOnly = true
            }else {
                self.mockIsNumberOnly = false
            }
        }
        
        override func  showValidateButton(isValidateButton: Bool) {
            if isValidateButton {
                self.mockIsButtonEnable = true
            }else {
                self.mockIsButtonEnable = false
            }
        }
        
        override func showCalculate(result: [Int]) {
            self.mockdataResult = result
        }
    }
}
