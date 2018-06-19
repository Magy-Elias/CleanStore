////
////  ListOrdersWorkerTests.swift
////  CleanStoreTests
////
////  Created by Magy Elias on 6/14/18.
////  Copyright © 2018 Raymond Law. All rights reserved.
////
//
//@testable import CleanStore
//import XCTest
//
//class ListOrdersWorkerTests: XCTestCase {
//    
//    // MARK:- Subject Under Test
//    var sut: OrdersWorker!
//    
//    // MARK:- Test lifecycle
//    override func setUp() {
//        super.setUp()
//        setupOrdersWorker()
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//    
//    // MARK:- Test setup
//    func setupOrdersWorker() {
//        sut = OrdersWorker(ordersStore: OrdersMemStoreSpy())
//    }
//    
//    // MARK:- Test doubles
//    class OrdersMemStoreSpy: OrdersMemStore {
//        // MARK:- Method call expectations
//        var fetchedOrdersCalled = false
//        
//        // MARK:- Spied methods
//        override func fetchOrders(completionHandler: @escaping (() throws -> [Order]) -> Void) {
//            fetchedOrdersCalled = true
//            ordersStore.fetchOrders { (orders: [Order]) -> Void in
//                completionHandler(orders: orders)
//            }
////            let oneSecond = dispatch_time(dispatch_time_t(DispatchTime.now()), 1 * Int64(NSEC_PER_SEC))
////            dispatch_after(oneSecond, dispatch_get_main_queue(), {
////                completionHandler(orders: [Order(), Order()])
////            })
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                completionHandler(orders: [Order(), Order()])       //postpone invoking the completionHandler by 1 second
//            }
//        }
//    }
//    
//    // MARK:- Tests
//    func testFetchOrdersShouldReturnListOfOrders() {
//        // Given
//        let ordersMemStoreSpy = sut.ordersStore as! OrdersMemStoreSpy
//
//        // When
//        let expectation = expectationWithDescription("Wait for fetched orders result")        //XCTest’s asynchronous testing support
//        sut.fetchOrders { (orders: [Order]) -> Void in
//            expectation.fulfill()     //to fulfill the expectation
//        }
//
//        // Then
//        XCTAssert(ordersMemStoreSpy.fetchedOrdersCalled, "Calling fetchOrders() should ask the data store for a list of orders")
//        waitForExpectations(timeout: 1.1) { (error: NSError?) -> Void in
//            XCTAssert(true, "Calling fetchOrders() should result in the completion handler being called with the fetched orders result")
//        }
//    }
//}
