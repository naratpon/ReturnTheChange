import UIKit

@objc protocol ReturnMoneyRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ReturnMoneyDataPassing {
    var dataStore: ReturnMoneyDataStore? { get }
}

class ReturnMoneyRouter: NSObject, ReturnMoneyRoutingLogic, ReturnMoneyDataPassing {
    // MARK: - Properties
    weak var viewController: ReturnMoneyViewController?
    var dataStore: ReturnMoneyDataStore?
    
    // MARK: - Routing
//    func routeToSomewhere(segue: UIStoryboardSegue?) {
//        if let segue = segue {
//            let destinationVC = segue.destination as! SomewhereViewController
//            var destinationDS = destinationVC.router!.dataStore!
//            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        } else {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//            var destinationDS = destinationVC.router!.dataStore!
//            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//            navigateToSomewhere(source: viewController!, destination: destinationVC)
//        }
//    }
    
    // MARK: - Navigation
//    func navigateToSomewhere(source: ReturnMoneyViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }
    
    // MARK: - Passing data
//    func passDataToSomewhere(source: ReturnMoneyDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
}
