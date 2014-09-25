//
//  FERJsonManagerTests.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 25/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "FERJsonManager.h"
#import "DontRepeat.h"

@interface FERJsonManagerTests : XCTestCase

@property (nonatomic,strong)FERJsonManager *jsonManager;

@end

@implementation FERJsonManagerTests

-(FERJsonManager *)jsonManager{
	if (_jsonManager==nil) {
		_jsonManager=[[FERJsonManager alloc]init];
	}
	return _jsonManager;
}


- (void)testExample {

    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

@end
