//
//  BRPayToScriptTest.m
//  BreadWallet
//
//  Created by alon muroch on 2/26/15.
//  Copyright (c) 2015 Aaron Voisine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NSMutableData+Bitcoin.h"
#import "NSString+Base58.h"
#import "BRBIP32Sequence.h"

@interface BRPayToScriptTest : XCTestCase

@end

@implementation BRPayToScriptTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testP2shAddress {
    BRBIP32Sequence *seq = [BRBIP32Sequence new];
    NSData *seed = @"000102030405060708090a0b0c0d0e0f".hexToData;
    NSData *mpk = [seq masterPublicKeyFromSeed:seed];
    
    // 027b6a7dd645507d775215a9035be06700e1ed8c541da9351b4bd14bd50ab61428
    NSData *pub1 = [seq publicKey:0 internal:NO masterPublicKey:mpk];
    // 02c8a17867e2cadc451a3071eff3499769a8dc1f25f407acd8d71f7938a8160de7
    NSData *pub2 = [seq publicKey:1 internal:NO masterPublicKey:mpk];
    // 038f6d5dd3f4ba4f39331843328c28c4ffef9e37330c916a4426a0e3ae00d7d2d1
    NSData *pub3 = [seq publicKey:2 internal:NO masterPublicKey:mpk];
    
    NSMutableData *script = [[NSMutableData alloc] init];
    [script appendMultisigScriptForPubKeys:@[pub1,pub2,pub3] signaturesRequired:2];
    
    NSString *p2shAddress = [script p2shAddress];
    NSLog(@"address %@", p2shAddress);
    XCTAssertEqualObjects(p2shAddress, @"3Q1Lkh1vT2pydNkgWG39Y316DEU2mcVx25");
    
}

@end
