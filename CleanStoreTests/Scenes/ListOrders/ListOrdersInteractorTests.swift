//
//  ListOrdersInteractorTests.swift
//  CleanStoreTests
//
//  Created by Magy Elias on 6/12/18.
//  Copyright © 2018 Raymond Law. All rights reserved.
//

@testable import CleanStore
import XCTest

class ListOrdersInteractorTests: XCTestCase {
    
    // MARK:- Subject Under Test
    var sut: ListOrdersInteractor!
    
    override func setUp() {
        super.setUp()
        setupListOrdersInteractor()
    }
    
    // MARK:- Test Setup
    func setupListOrdersInteractor() {
        sut = ListOrdersInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test doubles
    // Mock the external dependency by creating the spy
    class ListOrdersPresentationLogicSpy: ListOrdersPresentationLogic {
        // MARK: Method call expectations
        var presentFetchedOrdersCalled = false
        
        // MARK:- Spied methods
        func presentFetchedOrders(response: ListOrders.FetchOrders.Response) {
            presentFetchedOrdersCalled = true
        }
    }
    
    // Mock the external dependency by creating the spy
    class OrdersWorkerSpy: OrdersWorker {
        // MARK:- Method call expectations
        var fetchOrdersCalled = false
        
        // MARK:- Spied methods
        override func fetchOrders(completionHandler: @escaping ([Order]) -> Void) {
            fetchOrdersCalled = true
            completionHandler([])   //Seeds.Orders.amy, Seeds.Orders.bob
        }
    }
    
    func testFetchOrdersShouldAskOrdersWorkerToFetchWorkerToFetchOrdersAndPresenterToFormatResult() {
        // Given
        let listOrdersPresentationLogicSpy = ListOrdersPresentationLogicSpy()
        sut.presenter = listOrdersPresentationLogicSpy
        let ordersWorkerSpy = OrdersWorkerSpy(ordersStore: OrdersMemStore())
        sut.ordersWorker = ordersWorkerSpy
        
        // When
        let request = ListOrders.FetchOrders.Request()
        sut.fetchOrders(request: request)
        
        // Then
        XCTAssert(ordersWorkerSpy.fetchOrdersCalled, "FetchOrders() should ask OrdersWorker to fetch orders")
        XCTAssert(listOrdersPresentationLogicSpy.presentFetchedOrdersCalled, "FetchOders() should ask presenter to format orders result")
    }
}
