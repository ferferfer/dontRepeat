//
//  DontRepeat.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 05/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "DontRepeat.h"


@implementation DontRepeat

- (instancetype)init{
	self = [super init];
	if (self) {
		self.dontRepeatDate=[[NSString alloc]init];
		self.dontRepeatDesc=[[NSString alloc]init];
		self.dontRepeatLocalization=[[NSString alloc]init];
		self.dontRepeatPicture=[[NSData alloc]init];
		self.dontRepeatTitle=[[NSString alloc]init];
	}
	return self;
}

@end
