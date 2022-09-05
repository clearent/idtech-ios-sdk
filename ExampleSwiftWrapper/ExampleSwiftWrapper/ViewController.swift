//
//  ViewController.swift
//  ExampleSwiftWrapper
//
//  Created by Ovidiu Rotaru on 28.07.2022.
//

import UIKit
import ClearentIdtechIOSFramework

class ViewController: UIViewController {
    
    @IBOutlet weak var startTransactionButton: UIButton!
    @IBOutlet weak var readerStatusLabel: UILabel!
    @IBOutlet weak var disconnectFromReaderButton: UIButton!
    @IBOutlet weak var pairNewReaderButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    var tableView : UITableView?
    var readers : [ReaderInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSDK()
    }
    
    // MARK: SDK Related
    
    public func initSDK() {
        // Update the needed information that the SDK needs to work properly
        ClearentWrapper.shared.updateWithInfo(baseURL: Api.baseURL, publicKey: Api.publicKey, apiKey: Api.apiKey)
        ClearentWrapper.shared.delegate = self
        
        ClearentUIManager.shared.readerInfoReceived = { [weak self] reader in
            if (reader?.isConnected == true) {
                self?.readerStatusLabel.text = (reader?.readerName ?? "-") + "\nSN : \(String(describing: reader?.serialNumber))" + "\nBattery Level : \(String(describing: reader?.batterylevel))"
            } else {
                self?.readerStatusLabel.text = "No reader connected."
            }
        }
    }
    
    public func startTransactionWithAmount(amount: Double) {
        let amountString: String = String(format: "%f", amount)
        let saleEntity = SaleEntity(amount: amountString)
        
        do {
            try ClearentWrapper.shared.startTransaction(with: saleEntity)
        } catch {
            if let error = error as? ClearentResult {
                self.infoLabel.text = "Ops, something went wrong \(error.rawValue)"
            }
        }
    
        //self.infoLabel.text = "Transaction started.."
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
    
    
    @IBAction func startTransactionButtonAction(_ sender: Any) {
        startTransactionWithAmount(amount: 20.0)
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
    
    
    func didStartPairing() {
        self.infoLabel.text = "Searching for readers..."
    }
    
    func didFinishPairing() {
       self.infoLabel.text = "Reader Connected"
    }
    
    func didFindReaders(readers: [ReaderInfo]) {
        self.showReaderList(readers: readers)
    }
    
    func didNotFindReaders() {
        self.infoLabel.text = "No readers around."
    }
    

    func startedReaderConnection(with reader: ReaderInfo) {
        
        self.tableView?.removeFromSuperview()
        self.tableView = nil
        self.infoLabel.text = "Connecting to \(reader.readerName)"
    }
    

    func didBeginContinuousSearching() {
        //
    }
    
    
    func didFindRecentlyUsedReaders(readers: [ReaderInfo]) {
        //
    }
    
    func didNotFindRecentlyUsedReaders() {
        //
    }
    
    
    // Error mesages
    func didEncounteredGeneralError() {
        self.infoLabel.text = "Oops, something went wrong!"
    }

    // Reader related
    
    func deviceDidDisconnect() {
        self.infoLabel.text = "Device disconnected"
    }
    
    func didReceiveSignalStrength() {
        //
    }
    
    // Transaction related delegate methods
    
    func didFinishTransaction(response: TransactionResponse, error: ResponseError?) {
        if (error != nil) {
            self.infoLabel.text = "Transaction successfully processed."
        } else {
            self.infoLabel.text = "Oops, something went wrong!"
        }
    }
    
    func userActionNeeded(action: UserAction) {
        self.infoLabel.text = action.rawValue
    }
    
    func didReceiveInfo(info: UserInfo) {
        self.infoLabel.text = info.rawValue
    }
    
    
    // Siganture related methods
    
    func didFinishedSignatureUploadWith(response: SignatureResponse, error: ResponseError?) {
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

enum Api {
    static var baseURL: String {
        return "https://gateway-sb.clearent.net"
    }

    static let publicKey = "307a301406072a8648ce3d020106092b240303020801010c036200041fcefcdf366991b57f0fccf9efd587d0eee8d8ef8e5c78c17c2766d17a3b44b52bd999da8873e4daa144d76159d98a7f0fd94b65c49580ce134899f3826cd98380927c42fceec6e183a5ed4a064b43fef8507984ac855ca92b0ce32c50264670"

    static let apiKey = "27a419e3ecad4d58aa6009b65e66fd81"
}
