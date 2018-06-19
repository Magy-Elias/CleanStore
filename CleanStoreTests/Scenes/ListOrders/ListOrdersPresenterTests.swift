//
//  ListOrdersPresenterTests.swift
//  CleanStoreTests
//
//  Created by Magy Elias on 6/18/18.
//  Copyright © 2018 Raymond Law. All rights reserved.
//

@testable import CleanStore
import XCTest

class ListOrdersPresenterTests: XCTestCase {
    
    // MARK:- Subject Under Test
    var sut: ListOrdersPresenter!
    
    // Mock the external dependency by creating the spy
    class ListOrdersPresentationLogicSpy: ListOrdersDisplayLogic {
        
        // MARK:- Method call expectations
        var displayFetchedOrdersCalled = false
        
        // MARK:- Argument expectations
        var listOrders_fetchOrders_viewModel: ListOrders.FetchOrders.ViewModel!
        
        // MARK:- Spied methods
        func displayFetchedOrders(viewModel: ListOrders.FetchOrders.ViewModel) {
            displayFetchedOrdersCalled = true
            listOrders_fetchOrders_viewModel = viewModel
        }
    }
    
    override func setUp() {
        super.setUp()
        sut = ListOrdersPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Test to make sure the presenter Format the orders for display
    func testPresentFecthedOrdersShouldFormatFetchedOrdersForDisplay() {
        // Given
        let listOrdersPresentationLogicSpy = ListOrdersPresentationLogicSpy()
        sut.viewController = listOrdersPresentationLogicSpy
        
        var dateComponents = DateComponents()
        dateComponents.year = 2007
        dateComponents.month = 6
        dateComponents.day = 29
        let date = Calendar.current.date(from: dateComponents)!
        
        var amy = Seeds.Orders.amy
        amy.date = date
        let orders = [amy]
        
        let response = ListOrders.FetchOrders.Response(orders: orders)
        
        // When
        sut.presentFetchedOrders(response: response)
        
        // Then
        let displayedOrders = listOrdersPresentationLogicSpy.listOrders_fetchOrders_viewModel.displayedOrders
        for displayedOrder in displayedOrders {
            XCTAssertEqual(displayedOrder.id, "aaa111", "Presenting fetched orders should properly format order ID")
            XCTAssertEqual(displayedOrder.date, "6/29/07", "Presenting fetched orders should properly format order date")
            XCTAssertEqual(displayedOrder.email, "amy.apple@clean-swift.com", "Presenting fetched orders should properly format email")
            XCTAssertEqual(displayedOrder.name, "Amy Apple", "Presenting fetched orders should properly format name")
            XCTAssertEqual(displayedOrder.total, "$1.11", "Presenting fetched orders should properly format total")
        }
    }
    
    // Test to make sure the presenter Ask the view controller to display the orders
    func testPresentFetchedOrdersShouldAskViewControllerToDisplayFetchedOrders() {
        // Given
        let listOrdersPresentationLogicSpy = ListOrdersPresentationLogicSpy()
        sut.viewController = listOrdersPresentationLogicSpy
        
        let orders = [Seeds.Orders.amy]
        let response = ListOrders.FetchOrders.Response(orders: orders)
        
        // When
        sut.presentFetchedOrders(response: response)
        
        // Then
        XCTAssert(listOrdersPresentationLogicSpy.displayFetchedOrdersCalled, "Presenting fetched orders should ask view controller to display them")
    }
    
}
