//
//  ViewController.swift
//  ExampleSwift
//
//  Created by Ovidiu Rotaru on 27.07.2022.
//

import UIKit
import ClearentIdtechIOSFramework

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSDK()
    }
    
    func initSDK() {
        
        // Initalize the SDK UI with needed info to work properly
        // ! Make sure you update the baseURL and apiKey with the correct values in order to test the SDK !
        let baseURL = "test_url"
        let apiKey: String? = nil
        
        let encryptionKeyData = Crypto.SHA256hash(data: "some_secret_here".data(using: .utf8)!)
        let uiManagerConfig =
        ClearentUIManagerConfiguration(baseURL: baseURL, apiKey: apiKey, publicKey: nil, offlineModeEncryptionKeyData: encryptionKeyData, enableEnhancedMessaging: true, signatureEnabled: true)
        
        ClearentUIManager.shared.initialize(with: uiManagerConfig)
        
        // Load the default fonts from our SDK
        UIFont.loadFonts()
        
        // Uncomment the code below to see how the branding mechanism works
        
        /*
         // Set custom colors
         ClearentUIBrandConfigurator.shared.colorPalette = ClientColorPalette()
         
         // Set custom fonts
         ClearentUIBrandConfigurator.shared.fonts = ClientFonts()
         UIFont.loadFonts(fonts: ["Arial Bold.ttf", "Arial.ttf"], bundle: Bundle(for: ViewController.self))
         
         // Set custom texts
         ClearentUIBrandConfigurator.shared.overriddenLocalizedStrings = [
             "xsdk_tips_custom_amount": "🍎Custom amount",
             "xsdk_tips_user_transaction_tip_title": "🍎Would you like to add a tip?",
             "xsdk_tips_user_action_transaction_with_tip": "🍎Charge %@",
             "xsdk_tips_user_action_transaction_without_tip":"🍎Maybe next time"
         ]
         */
    }
    
    
    // MARK: Actions
    

    @IBAction func startPairingProcess(_ sender: Any) {
        let pairingVC = ClearentUIManager.shared.pairingViewController() { [weak self] error in
            // do something here after dismiss
            if let error = error {
                self?.printError(with: error.type)
            }
            
        }
        navigationController?.present(pairingVC, animated: true, completion: { })
    }
    
    @IBAction func startCardReaderTransaction(_ sender: Any) {
        let paymentInfo = PaymentInfo(amount: randomCGFloat())
        ClearentUIManager.shared.cardReaderPaymentIsPreferred = true
        
        let paymentVC = ClearentUIManager.shared.paymentViewController(paymentInfo: paymentInfo) { [weak self] error in
            // do something here after dismiss
            if let error = error {
                self?.printError(with: error.type)
            }
        }
        navigationController?.present(paymentVC, animated: true)
    }
    
    @IBAction func startManualEntryTransaction(_ sender: Any) {
        let paymentInfo = PaymentInfo(amount: randomCGFloat())
        ClearentUIManager.shared.cardReaderPaymentIsPreferred = false
        
        let paymentVC = ClearentUIManager.shared.paymentViewController(paymentInfo: paymentInfo) { [weak self] error in
            // do something here after dismiss
            if let error = error {
                self?.printError(with: error.type)
            }
        }
        navigationController?.present(paymentVC, animated: true)
    }
    
    @IBAction func showSettingsScreen(_ sender: Any) {
        let settingsVC = ClearentUIManager.shared.settingsViewController() { [weak self] error in
            // do something here after dismiss
            if let error = error {
                self?.printError(with: error.type)
            }
        }
        navigationController?.present(settingsVC, animated: true)
    }
    
    private func randomCGFloat() -> Double {
        Double(arc4random()) /  Double(1000)
    }
    
    private func printError(with type: ClearentErrorType) {
        print("❗️Oops, something went wrong, error \(type.rawValue)")
    }
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
    
    var linkButtonTextColor: UIColor { UIColor(hexString: "A12B0C") }
    
    var linkButtonDisabledTextColor: UIColor { UIColor(hexString: "572A31") }
    
    var subtitleWarningLabelColor: UIColor { UIColor(hexString: "A12B0C") }
    
    var fieldValidationErrorMessageColor: UIColor { UIColor(hexString: "A12B0C") }
    
    var settingOfflineStatusLabel: UIColor { UIColor(hexString: "272431") }
    
    var settingsOfflineStatusLabelFail: UIColor { UIColor(hexString: "A12B0C") }
    
    var settingsOfflineStatusLabelSuccess: UIColor { UIColor(hexString: "A12B0C") }
    
    var settingsReadersPlaceholderColor: UIColor { UIColor(hexString: "A12B0C") }
    
    var settingsReadersDescriptionColor: UIColor { UIColor(hexString: "272431") }
    
    var errorLogKeyLabelColor: UIColor { UIColor(hexString: "A12B0C") }
    
    var errorLogValueLabelColor: UIColor { UIColor(hexString: "572A31") }
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
    
    var detailScreenItemDescriptionFont: UIFont { arialBoldNormal }
    
    var settingsScreenTitle: UIFont{ arialBoldNormal }
    
    var settingsOfflineModeSubtitle: UIFont{ arialBoldNormal }
    
    var settingsOfflineModeProcessLabel: UIFont { arialBoldNormal }
    
    var settingsReadersPlaceholderLabel: UIFont { arialBoldNormal }
    
    var settingsReadersDescriptionLabel: UIFont { arialBoldLarge }
    
    var offlineResultItemLabelFont: UIFont { arialBoldNormal }
    
    var offlineReportFieldLabel: UIFont { arialBoldNormal }
}
