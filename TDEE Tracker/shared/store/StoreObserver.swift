//
//  StoreObserver.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/26/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation
import StoreKit



protocol StoreObserverDelegate: AnyObject {
    
    func storeObserverFinishedRestore()
    
    func storeObserverCompletedRestoreOf(product: ProductIdentifier)
    
    func storeObserverCancelledRestore()
    
    func storeObserverFailedRestore(_ message: String)
    

    func storeObserverCompletedPurchaseOf(product: ProductIdentifier)
    
    func storeObserverCancelledPurchase()
    
    func storeObserverFailedPurchase(_ message: String)
}


class StoreObserver: NSObject, SKPaymentTransactionObserver {
    
    public static let shared = StoreObserver()
    
    // MARK: - Properties
    
    public var isAuthorizedForPayments: Bool { SKPaymentQueue.canMakePayments() }
    
    public weak var delegate: StoreObserverDelegate?
    
    
    // MARK: - Initializer
    
    private override init() { }
    
    
    // MARK: - Submit Payment Request
    
    /// Create and add a payment request to the payment queue.
    public func buy(_ product: SKProduct) {
        
        let payment = SKMutablePayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    // MARK: - Restore All Restorable Purchases
    
    /// Restores all previously completed purchases.
    public func restore() {
        
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    // MARK: - Handle Payment Transactions
    
    private func handlePurchased(_ transaction: SKPaymentTransaction) {
        
        Utils.log(
            source: "StoreObserver.handlePurchased",
            message: transaction.payment.productIdentifier
        )
        
        DispatchQueue.main.async {
            self.delegate?.storeObserverCompletedPurchaseOf(product: transaction.payment.productIdentifier)
        }
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func handleRestored(_ transaction: SKPaymentTransaction) {
        
        Utils.log(
            source: "StoreObserver.handleRestored",
            message: transaction.payment.productIdentifier
        )
        
        DispatchQueue.main.async {
            self.delegate?.storeObserverCompletedRestoreOf(product: transaction.payment.productIdentifier)
        }
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }

    private func handleFailed(_ transaction: SKPaymentTransaction) {
        
        Utils.log(
            source: "StoreObserver.handleFailed",
            message: transaction.payment.productIdentifier
        )
        
        let title = StoreManager.shared.getProductTitleById(transaction.payment.productIdentifier)
        
        var message = "\(Label.purchaseError) \(title)"
        
        if let error = transaction.error {
            
            message += ":\n\(error.localizedDescription)"
            
            Utils.log(
                source: "StoreObserver.handleFailed",
                message: error.localizedDescription
            )
        }
        
        if (transaction.error as? SKError)?.code != .paymentCancelled {
            DispatchQueue.main.async {
                self.delegate?.storeObserverFailedPurchase(message)
            }
        }
        else {
            DispatchQueue.main.async {
                self.delegate?.storeObserverCancelledPurchase()
            }
        }
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }


    // MARK: - SKPaymentTransactionObserver

    /// Called when there are transactions in the payment queue.
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [ SKPaymentTransaction ]) {
        
        for transaction in transactions {
            
            switch transaction.transactionState {
                
                case .purchasing: break
                case .deferred:
                    Utils.log(
                        source: "StoreObserver.paymentQueue",
                        message: "Do not block the UI. Allow the user to continue using the app."
                    )

                case .purchased: handlePurchased(transaction)
                case .restored: handleRestored(transaction)
                case .failed: handleFailed(transaction)
                
                @unknown default: fatalError("Unknown payment transaction case.")
            }
        }
    }
    
    public func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [ SKPaymentTransaction ]) {
        
        for transaction in transactions {
            Utils.log(
                source: "StoreObserver.paymentQueue",
                message: "\(transaction.payment.productIdentifier) was removed from the payment queue."
            )
        }
    }
    
    /// Called when an error occur while restoring purchases.
    public func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        
        if let error = error as? SKError, error.code != .paymentCancelled {
            DispatchQueue.main.async {
                self.delegate?.storeObserverFailedRestore(error.localizedDescription)
            }
        }
        else {
            DispatchQueue.main.async {
                self.delegate?.storeObserverCancelledRestore()
            }
        }
    }
    
    public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        
        DispatchQueue.main.async {
            self.delegate?.storeObserverFinishedRestore()
        }
    }
}

