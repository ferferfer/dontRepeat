//
//  FERFormatHelperTests.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 11/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DontRepeat.h"
#import "FERFormatHelper.h"

@interface FERFormatHelperTests : XCTestCase

@end

@implementation FERFormatHelperTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testShortedArray{
	
	NSMutableArray *array=[[NSMutableArray alloc]init];
	DontRepeat *dont=[[DontRepeat alloc]init];
	dont.dontRepeatDate=@"01/01/2013";
	[array addObject:dont];
	dont.dontRepeatDate=@"01/01/2015";
	[array addObject:dont];
	dont.dontRepeatDate=@"01/01/2014";
	[array addObject:dont];
	FERFormatHelper *formatHelper= [[FERFormatHelper alloc]init];
	array=[formatHelper sortDontRepeatsByTitle:array];
	
	XCTAssert(array,@"");
}

@end
