//
//  Suitcase.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 05/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "Suitcase.h"


@implementation Suitcase

- (instancetype)init{
	self = [super init];
	if (self) {
		self.suitcaseDate=[[NSDate alloc]init];
		self.suitcaseDesc=[[NSString alloc]init];
		self.suitcaseLocalization=[[NSString alloc]init];
		self.suitcasePicture=[[NSData alloc]init];
		self.suitcaseTitle=[[NSString alloc]init];
	}
	return self;
}

@end
