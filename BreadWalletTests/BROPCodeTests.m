//
//  BROPCodeTests.m
//  BreadWallet
//
//  Created by alon muroch on 2/26/15.
//  Copyright (c) 2015 Aaron Voisine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSData+Bitcoin.h"

@interface BROPCodeTests : XCTestCase

@end

@implementation BROPCodeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark - testOPCode

- (void)testOPCodes
{
    uint8_t result = [NSData opCodeForNumber:0];
    XCTAssertEqual(result, 0);
    
    result = [NSData opCodeForNumber:-1];
    XCTAssertEqual(result, 79);
    
    result = [NSData opCodeForNumber:1];
    XCTAssertEqual(result, 81);
    
    result = [NSData opCodeForNumber:2];
    XCTAssertEqual(result, 82);
    
    result = [NSData opCodeForNumber:3];
    XCTAssertEqual(result, 83);
    
    result = [NSData opCodeForNumber:4];
    XCTAssertEqual(result, 84);
    
    result = [NSData opCodeForNumber:5];
    XCTAssertEqual(result, 85);
    
    result = [NSData opCodeForNumber:6];
    XCTAssertEqual(result, 86);
    
    result = [NSData opCodeForNumber:7];
    XCTAssertEqual(result, 87);
    
    result = [NSData opCodeForNumber:8];
    XCTAssertEqual(result, 88);
    
    result = [NSData opCodeForNumber:9];
    XCTAssertEqual(result, 89);
    
    result = [NSData opCodeForNumber:10];
    XCTAssertEqual(result, 90);
    
    result = [NSData opCodeForNumber:11];
    XCTAssertEqual(result, 91);
    
    result = [NSData opCodeForNumber:12];
    XCTAssertEqual(result, 92);
    
    result = [NSData opCodeForNumber:13];
    XCTAssertEqual(result, 93);
    
    result = [NSData opCodeForNumber:14];
    XCTAssertEqual(result, 94);
    
    result = [NSData opCodeForNumber:15];
    XCTAssertEqual(result, 95);
    
    result = [NSData opCodeForNumber:16];
    XCTAssertEqual(result, 96);
    
}


@end
