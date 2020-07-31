import UIKit
import Localize_Swift

protocol ReturnMoneyDisplayLogic: class {
    func displayNumber(textReceive: Int, textPrize: Int)
    func displayNumberError(text: String)
    func displayButton(isValidateButton: Bool)
    func displayCalculate(result: [String])
}

private enum ReturnMoneyReuseCellType: String {
    case title            = "title"
    case detail           = "detail"
}

private enum ReturnMoneyTextFieldTag: Int {
    case Receive          = 1
    case Prize            = 2
}

private enum PrizeOfMoney : Int, CaseIterable {
    case p500  = 500
    case p100  = 100
    case p50   = 50
    case p20   = 20
    case p10   = 10
    case p5    = 5
    case p1    = 1
    
    var description: Int {
        return self.rawValue
    }
    
    static var getValueList: [Int] {
        return PrizeOfMoney.allCases.map { $0.rawValue }
    }
}

class ReturnMoneyViewController: BaseViewController, ReturnMoneyDisplayLogic {
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var receiveMoneyTextField: UITextField!
    @IBOutlet weak var productPrizeTextField: UITextField!
    @IBOutlet weak var calculateMoneyButton: UIButton!
    // MARK: - Layout Properties
    // MARK: - Properties
    var interactor: ReturnMoneyBusinessLogic?
    var router: (NSObjectProtocol & ReturnMoneyRoutingLogic & ReturnMoneyDataPassing)?
    private var dataSource = [ReturnMoneyReuseCellType]()
    private var dataPrize = [PrizeOfMoney]()
    private var moneyType: [Int] = []
    private var textRecieve: String = ""
    private var textPrize: String = ""
    private var result: [String] = []
    
    // MARK: - Object Life Cycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactorReturnMoney = ReturnMoneyInteractor()
        let presenterReturnMoney = ReturnMoneyPresenter()
        let routerReturnMoney = ReturnMoneyRouter()
        viewController.interactor = interactorReturnMoney
        viewController.router = routerReturnMoney
        interactorReturnMoney.presenter = presenterReturnMoney
        presenterReturnMoney.viewController = viewController
        routerReturnMoney.viewController = viewController
        routerReturnMoney.dataStore = interactorReturnMoney
    }
    
    // MARK: - Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let routerReturnMoney = router, routerReturnMoney.responds(to: selector) {
                routerReturnMoney.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUIReturnMoney()
        self.calculateDataSource()
    }
    
    // MARK: - UI Setup
    private func setupUIReturnMoney() {
        self.setupTableView()
        self.setupTextField()
        self.setupButton()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isScrollEnabled = false
        self.returnMoneyTableViewCellReusedIdentifier()
    }
    
    private func returnMoneyTableViewCellReusedIdentifier() {
        self.tableView.register(reuseNib: "TitleReturnMoneyTableViewCell")
        self.tableView.register(reuseNib: "DetailReturnMoneyTableViewCell")
    }
    
    private func setupTextField() {
        self.receiveMoneyTextField.delegate = self
        self.receiveMoneyTextField.tag = ReturnMoneyTextFieldTag.Receive.rawValue
        self.receiveMoneyTextField.placeholder = "calculate_receive_title".localized()
        self.receiveMoneyTextField.keyboardType = .numberPad
        
        self.productPrizeTextField.delegate = self
        self.productPrizeTextField.tag = ReturnMoneyTextFieldTag.Prize.rawValue
        self.productPrizeTextField.placeholder = "calculate_prize_title".localized()
        self.productPrizeTextField.keyboardType = .numberPad
    }
    
    private func setupButton() {
        self.calculateMoneyButton.setTitle("calculate_title_button".localized(), for: .normal)
        self.calculateMoneyButton.setTitleColor(UIColor.black, for: .normal)
        self.calculateMoneyButton.backgroundColor = UIColor.gray
        self.calculateMoneyButton.addTarget(self, action: #selector(calculateAction), for: .touchUpInside)
        self.calculateMoneyButton.isEnabled = false
    }
    
    // MARK: - IBActions
    // MARK: - User Interaction
    @objc func calculateAction() {
        interactor?.validateNumber(textReceive: self.receiveMoneyTextField.text ?? "", textPrize: self.productPrizeTextField.text ?? "")
    }
    
    // MARK: - Public Methods
    // MARK: - Private Methods
    private func calculateDataSource() {
        var sections = [ReturnMoneyReuseCellType]()
        sections.append(.title)
        for i in PrizeOfMoney.getValueList {
            sections.append(.detail)
            self.moneyType.append(i)
            self.result.append("0")
        }
        
        self.dataSource = sections
        self.tableView.reloadData()
    }
    
    private func getReuseId(row: ReturnMoneyReuseCellType) -> String {
        switch row {
        case .title:
            return "TitleReturnMoneyTableViewCell"
        case .detail:
            return "DetailReturnMoneyTableViewCell"
        }
    }
    
    // MARK: - ReturnMoneyDisplayLogic
    func displayNumber(textReceive: Int, textPrize: Int) {
        if textReceive >= textPrize {
            self.textRecieve = String(textReceive)
            self.textPrize = String(textPrize)
            
            interactor?.calculate(textReceive: self.textRecieve, textPrize: self.textPrize, prizeOfMoney: moneyType)
        }else {
            self.showAlert(msg: "warning_prize_morethan_receive".localized())
        }
    }
    
    func displayNumberError(text: String) {
        self.showAlert(msg: text)
    }
    
    func displayButton(isValidateButton: Bool) {
        if isValidateButton {
            self.calculateMoneyButton.isEnabled = isValidateButton
            self.calculateMoneyButton.backgroundColor = UIColor.red
        }else {
            self.calculateMoneyButton.isEnabled = isValidateButton
            self.calculateMoneyButton.backgroundColor = UIColor.gray
        }
    }
    
    func displayCalculate(result: [String]) {
        self.result = result
        self.tableView.reloadData()
    }
    
    // MARK: - Other section e.g. Local Notifications
}
// MARK: - UITableViewDataSource
extension ReturnMoneyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.getReuseId(row: row), for: indexPath)
        cell.selectionStyle = .none
        switch row {
        case .title:
            let cells = cell as! TitleReturnMoneyTableViewCell
            cells.configure(title: "result_title_money".localized(), amount: "result_title_amount".localized())
        case .detail:
            let cells = cell as! DetailReturnMoneyTableViewCell
            cells.configure(value: "\(PrizeOfMoney.getValueList[indexPath.row - 1])", amount: self.result[indexPath.row - 1])
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ReturnMoneyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.dataSource[indexPath.row]
        switch row {
        case .title, .detail:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - UITextFieldDelegate
extension ReturnMoneyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        if textField.tag == ReturnMoneyTextFieldTag.Receive.rawValue {
            self.textRecieve = updatedString ?? ""
        }else if textField.tag == ReturnMoneyTextFieldTag.Prize.rawValue  {
            self.textPrize = updatedString ?? ""
        }
        interactor?.validateButton(textReceive: self.textRecieve, textPrize: self.textPrize)
        
        return true
    }
}


