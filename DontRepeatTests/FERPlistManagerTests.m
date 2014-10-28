//
//  FERPlistManagerTests.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 25/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FERPlistManager.h"

@interface FERPlistManagerTests : XCTestCase

@property (nonatomic,strong)FERPlistManager *plistManager;

@end

@implementation FERPlistManagerTests

-(FERPlistManager *)plistManager{
	if (_plistManager==nil) {
		_plistManager=[[FERPlistManager alloc]init];
	}
	return _plistManager;
}

- (void)testExample {
	DontRepeat *dont=[[DontRepeat alloc]init];
	dont.dontRepeatID=@"titulo01/01/01";
	dont.dontRepeatDate=@"01/01/01";
	dont.dontRepeatDesc=@"holaaaaa";
	dont.dontRepeatTitle=@"titulo";
	FERUser *user=[[FERUser alloc]init];
	user.userID=@"holahola";
	
	[self.plistManager saveDontRepeatToPlist:dont forUser:user];
	
	XCTAssert(YES, @"Pass");
}

-(void)testNumberOfDontRepeatsInPlist{
	FERUser *user=[[FERUser alloc]init];
	user.userNick=@"emailemailemail";
	NSLog(@"testNumberOfDontRepeatsInPlist: %i",[self.plistManager numberOfDontRepeatsInPlistForUser:user]);
	XCTAssertEqual(1, [self.plistManager numberOfDontRepeatsInPlistForUser:user]);
}

-(void)testNumberOfDeletedDontRepeatsInPlist{
	FERUser *user=[[FERUser alloc]init];
	user.userNick=@"emailemailemail";
	NSLog(@"testNumberOfDeletedDontRepeatsInPlist: %i",[self.plistManager numberOfDontRepeatsInPlistForUser:user]);
	XCTAssertEqual(1, [self.plistManager numberOfDontRepeatsInPlistForUser:user]);
}

@end
