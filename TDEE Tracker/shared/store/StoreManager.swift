//
//  StoreManager.swift
//  TDEE Tracker
//
//  Created by Andrei Khvalko on 7/26/20.
//  Copyright © 2020 Greams. All rights reserved.
//

import Foundation
import StoreKit



typealias ProductIdentifier = String

enum ProductIds: ProductIdentifier, CaseIterable {
    
    case Premium = "com.greams.tdee_tracker.premium"
    case TestItem = "com.greams.tdee_tracker.test_item"
    case TestItemNC = "com.greams.tdee_tracker.test_item_non_consumable"
}


protocol StoreManagerDelegate: AnyObject {
    
    func storeManagerRequestResponse(_ response: [ ProductIdentifier : SKProduct ])
    
    func storeManagerRequestError(_ message: String)
}


class StoreManager: NSObject, SKProductsRequestDelegate, SKRequestDelegate {
    
    public static let shared = StoreManager()
    
    // MARK: - Properties
    
    public let PREMIUM_PRODUCT_ID: ProductIdentifier = ProductIds.Premium.rawValue
    
    public var products: [ ProductIdentifier : SKProduct ] = [:]
    
    public var areProductsLoaded: Bool = false
    
    private var productRequest: SKProductsRequest!
    
    public weak var delegate: StoreManagerDelegate?
    
    // MARK: - Initializer
    
    private override init() {}
    
    // MARK: - Request Product Information

    public func fetchProducts(identifiers: [ ProductIdentifier ]) {
        
        // Initialize the product request with the above identifiers.
        self.productRequest = SKProductsRequest(productIdentifiers: Set(identifiers))
        self.productRequest.delegate = self
        
        // Send the request to the App Store.
        self.productRequest.start()
    }
    
    // MARK: - Helper Methods
    
    public func getProductTitleById(_ identifier: ProductIdentifier) -> String {

        return self.products[identifier]?.localizedTitle ?? identifier
    }
    
    public func getProductButtonLabelById(_ identifier: ProductIdentifier) -> (label: String, enabled: Bool) {

        guard let product = self.products[identifier] else { return (Label.unavailable, false) }
        
        guard !product.price.isEqual(0) else { return (Label.getFree, false) }
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = product.priceLocale
        currencyFormatter.numberStyle = .currency

        if let price = currencyFormatter.string(from: product.price) {
            
            return ("\(Label.buyFor) \(price)", true)
        }
        else {
            
            return (Label.unavailable, false)
        }
    }
    
    // MARK: - SKProductsRequestDelegate

    /// Accepts the App Store response that contains the app-requested product information
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        self.areProductsLoaded = true
        
        if !response.products.isEmpty || !response.invalidProductIdentifiers.isEmpty {
            
            for invalidProductIdentifier in response.invalidProductIdentifiers {
                self.products.removeValue(forKey: invalidProductIdentifier)
            }
            
            for product in response.products {
                self.products[product.productIdentifier] = product
            }
            
            DispatchQueue.main.async {
                self.delegate?.storeManagerRequestResponse(self.products)
            }
        }
    }

    // MARK: - SKRequestDelegate

    /// Tells the delegate that the request failed to execute
    public func request(_ request: SKRequest, didFailWithError error: Error) {

        DispatchQueue.main.async {
            self.delegate?.storeManagerRequestError(error.localizedDescription)
        }
    }
}

