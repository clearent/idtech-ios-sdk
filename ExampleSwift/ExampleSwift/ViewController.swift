//
//  ViewController.swift
//  ExampleSwift
//
//  Created by Ovidiu Rotaru on 27.07.2022.
//

import UIKit
import ClearentIdtechIOSFramework

class ViewController: UIViewController {
    
    @IBOutlet weak var showReadersDetailsButton: UIButton!
    @IBOutlet weak var startTransactionButton: UIButton!
    @IBOutlet weak var startPairingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSDK()
    }
    
    func initSDK() {
        
        // Update the SDk with needed info to work properly
        ClearentUIManager.shared.updateWith(baseURL: Api.baseURL, apiKey: Api.apiKey, publicKey: Api.publicKey)
        
        // Load the default fonts from our SDK
        UIFont.loadFonts()
        
        // The signature step from transaction is enabled by default
        ClearentUIManager.shared.signatureEnabled = false
        
        
        /*
         * Uncomment the code below to see how the branding mechanism works
        */

        /*
         ClearentUIBrandConfigurator.shared.colorPalette = ClientColorPalette()
         ClearentUIBrandConfigurator.shared.fonts = ClientFonts()
         ClearentUIBrandConfigurator.shared.overriddenLocalizedStrings = [
          "xsdk_tips_custom_amount": "🍎Custom amount",
          "xsdk_tips_user_transaction_tip_title": "🍎Would you like to add a tip?",
          "xsdk_tips_user_action_transaction_with_tip": "🍎Charge %@",
          "xsdk_tips_user_action_transaction_without_tip":"🍎Maybe next time"
         ]
         */


        // This is how to load your own fonts
        // UIFont.loadFonts(fonts: ["Arial Bold.ttf", "Arial.ttf"], bundle: Constants.bundle)
    }
    
    
    // MARK: Actions
    
    @IBAction func showRederDetailsAction(_ sender: Any) {
        
        let readerDetailsVC = ClearentUIManager.shared.readersViewController(completion: { result in
            // do something here after dismiss
        })
        self.navigationController?.present(readerDetailsVC, animated: true, completion: { })
    }
    
    @IBAction func startTransactionAction(_ sender: Any) {
        
        let randomNumDouble = randomCGFloat()
        let transactionVC = ClearentUIManager.shared.paymentViewController(amount: randomNumDouble, completion: { result in
            // do something here after dismiss
        })
        self.navigationController?.present(transactionVC, animated: true, completion: { })
    }
    
    @IBAction func startPairingProcess(_ sender: Any) {
        let pairingVC = ClearentUIManager.shared.pairingViewController(completion: { result in
            // do something here after dismiss
        })
        self.navigationController?.present(pairingVC, animated: true, completion: { })
    }
    
    func randomCGFloat() -> Double {
        return Double(arc4random()) /  Double(1000)
    }
}

enum Api {
    static var baseURL: String {
        return "https://gateway-sb.clearent.net"
    }

    static let publicKey = "307a301406072a8648ce3d020106092b240303020801010c036200041fcefcdf366991b57f0fccf9efd587d0eee8d8ef8e5c78c17c2766d17a3b44b52bd999da8873e4daa144d76159d98a7f0fd94b65c49580ce134899f3826cd98380927c42fceec6e183a5ed4a064b43fef8507984ac855ca92b0ce32c50264670"

    static let apiKey = "27a419e3ecad4d58aa6009b65e66fd81"
}


/*
 Example on how to implement your own branding colors
*/


class ClientColorPalette: ClearentUIColors {
    
    var filledDisabledBackgroundColor: UIColor { UIColor(hexString: "#672431") }
    
    var filledDisabledButtonTextColor: UIColor { UIColor(hexString: "#672431") }
    
    var manualPaymentTitleColor: UIColor { UIColor(hexString: "#672431") }
    
    var manualPaymentErrorMessageColor: UIColor { UIColor(hexString: "#672431") }
    
    var manualPaymentTextFieldPlaceholder: UIColor { UIColor(hexString: "#672431") }
    
    var loadingViewFillColor: UIColor { UIColor(hexString: "#672431") }
    
    var filledBackgroundColor: UIColor { UIColor(hexString: "#672431") }
    
    var filledButtonTextColor: UIColor { UIColor(hexString: "#6FFFFF") }
    
    var borderColor: UIColor { UIColor(hexString: "#61E2E8") }
    
    var borderedBackgroundColor: UIColor { UIColor(hexString: "#6FFFFF") }
    
    var borderedButtonTextColor: UIColor { UIColor(hexString: "#672431") }
    
    var enabledBackgroundColor: UIColor { UIColor(hexString: "#6FAC10") }
    
    var disabledBackgroundColor: UIColor { UIColor(hexString: "#272431") }
    
    var enabledTextColor: UIColor { UIColor(hexString: "#6FFFFF") }
    
    var disabledTextColor: UIColor { UIColor(hexString: "#6FFFFF") }
    
    var buttonBorderColor: UIColor { UIColor(hexString: "#61E2E8") }
    
    var highlightedBackgroundColor: UIColor { UIColor(hexString: "#644E27") }
    
    var highlightedTextColor: UIColor { UIColor(hexString: "#6FFFFF") }
    
    var defaultTextColor: UIColor { UIColor(hexString: "#600000") }
    
    var titleLabelColor: UIColor { UIColor(hexString: "#672431") }
    
    var subtitleLabelColor: UIColor { UIColor(hexString: "#6A6D7D") }
    
    var readerNameColor: UIColor { UIColor(hexString: "1B181F") }
    
    var readerStatusLabelColor: UIColor { UIColor(hexString: "#6A6D7D") }
    
    var readerNameLabelColor: UIColor { UIColor(hexString: "1B181F") }
    
    var readerStatusConnectedIconColor: UIColor { UIColor(hexString: "2FAC10") }
    
    var readerStatusNotConnectedIconColor: UIColor { UIColor(hexString: "F4C15F") }
    
    var readersCellBackgroundColor: UIColor { UIColor(hexString: "EEEFF3") }
    
    var checkboxSelectedBorderColor: UIColor { UIColor(hexString: "272431") }
    
    var checkboxUnselectedBorderColor: UIColor { UIColor(hexString: "999BA8") }
    
    var percentageLabelColor: UIColor { UIColor(hexString: "272431") }
    
    var tipLabelColor: UIColor { UIColor(hexString: "272431") }
    
    var tipAdjustmentTintColor: UIColor { UIColor(hexString: "272431") }
    
    var infoLabelColor: UIColor { UIColor(hexString: "1B181F") }
    
    var navigationBarTintColor: UIColor { UIColor(hexString: "000000") }
    
    var screenTitleColor: UIColor { UIColor(hexString: "000000") }
    
    var removeReaderButtonBorderColor: UIColor { UIColor(hexString: "C2210F") }
    
    var removeReaderButtonTextColor: UIColor { UIColor(hexString: "C2210F") }
    
    var signatureDescriptionMessageColor: UIColor { UIColor(hexString: "272431") }
}


/*
 Example on how to implement your own branding fonts
*/


class ClientFonts: ClearentUIFonts {
    
    private let arialBold = "Arial-Bold"
    private let arialRegular = "Arial"
    private let defaultFont = UIFont.systemFont(ofSize: 20)
    
    private var arialBoldLarge: UIFont { UIFont(name: arialBold, size: 20) ?? defaultFont }
    private var arialBoldNormal: UIFont { UIFont(name: arialBold, size: 14) ?? defaultFont }
    private var arialRegularLarge: UIFont { UIFont(name: arialRegular, size: 16) ?? defaultFont }
    private var arialRegularSmall: UIFont { UIFont(name: arialRegular, size: 14) ?? defaultFont }
    
    var paymentViewTitleLabelFont: UIFont { arialBoldNormal }
    
    var paymentFieldTitleLabelFont: UIFont { arialBoldNormal }
    
    var errorMessageLabelFont: UIFont { arialBoldNormal }
    
    var sectionTitleLabelFont: UIFont { arialBoldNormal }
    
    var textfieldPlaceholder: UIFont { arialBoldNormal }

    var primaryButtonTextFont: UIFont { arialBoldLarge }
    
    var hintTextFont: UIFont { arialBoldNormal }
    
    var modalTitleFont: UIFont { arialBoldLarge }
    
    var modalSubtitleFont: UIFont{ arialBoldNormal }
    
    var listItemTextFont: UIFont { arialRegularLarge }
    
    var readerNameTextFont: UIFont { arialBoldLarge }
    
    var statusLabelFont: UIFont{ arialRegularLarge }
    
    var tipItemTextFont: UIFont { arialRegularSmall }
    
    var customNameInfoLabelFont: UIFont { arialBoldLarge }
    
    var customNameInputLabelFont: UIFont { arialRegularSmall }
    
    var screenTitleFont: UIFont{ arialBoldNormal }
    
    var signatureSubtitleFont: UIFont { arialBoldLarge }
    
    var detailScreenItemTitleFont: UIFont{ arialRegularLarge }
    
    var detailScreenItemSubtitleFont: UIFont{ arialBoldNormal }
    
    var detailScreenItemDescriptionFont: UIFont { arialBoldLarge }
}




