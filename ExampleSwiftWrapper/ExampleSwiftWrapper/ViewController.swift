//
//  ViewController.swift
//  ExampleSwiftWrapper
//
//  Created by Ovidiu Rotaru on 28.07.2022.
//

import UIKit
import ClearentIdtechIOSFramework

class ViewController: UIViewController {

    @IBOutlet weak var readerStatusLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var tableView : UITableView?
    var readers : [ReaderInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSDK()
    }
    
    // MARK: SDK Related
    
    func initSDK() {
        // Initalize the SDK with needed info to work properly
        // ! Make sure you update the baseURL and apiKey with the correct values in order to test the SDK !
        let baseURL = "test_url"
        let apiKey: String? = nil
        
        let encryptionKeyData = Crypto.SHA256hash(data: "some_secret_here".data(using: .utf8)!)
        let clearentWrapperConfiguration = ClearentWrapperConfiguration(baseURL: baseURL, apiKey: apiKey, publicKey: nil, offlineModeEncryptionKeyData: encryptionKeyData)
        ClearentWrapper.shared.initialize(with: clearentWrapperConfiguration)
        ClearentWrapper.shared.delegate = self
        
        ClearentWrapper.configuration.readerInfoReceived = { [weak self] reader in
            DispatchQueue.main.async {
                if (reader?.isConnected == true) {
                    self?.readerStatusLabel.text = (reader?.readerName ?? "-") + "\nSN : \(String(describing: reader?.serialNumber))" + "\nBattery Level : \(String(describing: reader?.batterylevel))"
                } else {
                    self?.readerStatusLabel.text = "No reader connected."
                }
            }
        }
    }
    
    public func startCardReaderTransaction(with amount: Double) {
        let amountString: String = String(format: "%f", amount)
        let saleEntity = SaleEntity(amount: amountString)
        
        ClearentWrapper.shared.startTransaction(with: saleEntity, isManualTransaction: false) { error in
            if let error = error {
                self.infoLabel.text = "Oops, something went wrong, error \(error.type.rawValue)"
            }
        }
        infoLabel.text = "Transaction started.."
    }
    
    public func startManualTransaction(with amount: Double, card: String, csc: String, expirationDateMMYY: String) {
        let amountString: String = String(format: "%f", amount)
        let saleEntity = SaleEntity(amount: amountString, card: card, csc: csc, expirationDateMMYY: expirationDateMMYY)
        
        ClearentWrapper.shared.startTransaction(with: saleEntity, isManualTransaction: true) { error in
            if let error = error {
                self.infoLabel.text = "Oops, something went wrong, error \(error.type.rawValue)"
            }
        }
        infoLabel.text = "Transaction started.."
    }
    
    
    // MARK: Actions
    
    @IBAction func disconnectFromReaderButtonAction(_ sender: Any) {
        // TO DO move this to deviceDisconnected method
        readerStatusLabel.text = "No reader connected"
        infoLabel.text = "Device disconnected"
        ClearentWrapper.shared.disconnectFromReader()
    }
    
    @IBAction func pairNewReaderButtonAction(_ sender: Any) {
        self.infoLabel.text = "Searching for readers..."
        ClearentWrapper.shared.startPairing(reconnectIfPossible: false)
    }
    
    @IBAction func startCardReaderTransactionAction(_ sender: Any) {
        startCardReaderTransaction(with: 20.0)
    }
    
    @IBAction func startManualTransactionAction(_ sender: Any) {
        startManualTransaction(with: 20.0, card: "4111111111111111", csc: "999", expirationDateMMYY: "11/99")
    }
    
    
    // MARK: Tableview helper methods
    
    func showReaderList(readers:[ReaderInfo]) {
        self.readers = readers
        if self.tableView == nil {
            createTableView()
        }
        self.tableView?.reloadData()
    }
    
    func createTableView() {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = self.contentView.bounds
        self.contentView.addSubview(tableView)
        self.tableView = tableView
    }
}


extension ViewController : ClearentWrapperProtocol {
    
    // MARK: - Reader related callback
    
    func didStartPairing() {
        infoLabel.text = "Searching for readers..."
    }
    
    func didFinishPairing() {
        infoLabel.text = "Reader Connected"
    }
    
    func didReceiveSignalStrength() {
        //
    }
    
    func didFindReaders(readers: [ClearentIdtechIOSFramework.ReaderInfo]) {
        showReaderList(readers: readers)
    }
    
    func deviceDidDisconnect() {
        infoLabel.text = "Device disconnected"
    }
    
    func startedReaderConnection(with reader: ClearentIdtechIOSFramework.ReaderInfo) {
        tableView?.removeFromSuperview()
        tableView = nil
        infoLabel.text = "Connecting to \(reader.readerName)"
    }
    
    func didFindRecentlyUsedReaders(readers: [ClearentIdtechIOSFramework.ReaderInfo]) {
        //
    }
    
    func didBeginContinuousSearching() {
        //
    }
    
    // MARK: - Error messages
    
    func didEncounteredGeneralError() {
        infoLabel.text = "Oops, something went wrong!"
    }
    
    // MARK: - Transaction related callbacks
    
    func didFinishTransaction(response: ClearentIdtechIOSFramework.TransactionResponse?, error: ClearentIdtechIOSFramework.ClearentError?) {
        if (error != nil) {
            self.infoLabel.text = "Transaction successfully processed."
        } else {
            self.infoLabel.text = "Oops, something went wrong!"
        }
    }
    
    func didAcceptOfflineTransaction(status: ClearentIdtechIOSFramework.TransactionStoreStatus) {
        //
    }
    
    func didFinishedSignatureUploadWith(response: ClearentIdtechIOSFramework.SignatureResponse?, error: ClearentIdtechIOSFramework.ClearentError?) {
        //
    }
    
    func didFinishedSendingReceipt(response: ClearentIdtechIOSFramework.ReceiptResponse?, error: ClearentIdtechIOSFramework.ClearentError?) {
        //
    }
    
    func didAcceptOfflineSignature(status: ClearentIdtechIOSFramework.TransactionStoreStatus, transactionID: String) {
        //
    }
    
    func didAcceptOfflineEmail(transactionID: String) {
        //
    }
    
    func userActionNeeded(action: ClearentIdtechIOSFramework.UserAction) {
        infoLabel.text = action.rawValue
    }
    
    func showEncryptionWarning() {
        //
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let reader = readers[indexPath.row]
        cell.textLabel?.text = reader.readerName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reader = readers[indexPath.row]
        ClearentWrapper.shared.connectTo(reader: reader)
    }
}
