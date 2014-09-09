//
//  FERFormatHelper.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 03/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERFormatHelper.h"

@implementation FERFormatHelper

-(NSString *)cleanMail:(NSString *)mail{
	mail=[mail stringByReplacingOccurrencesOfString:@"@" withString:@""];
	mail=[mail stringByReplacingOccurrencesOfString:@"." withString:@""];
	return mail;
}

-(NSString *)returnStringFromDate:(NSDate *)date{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];
	
	return [dateFormatter stringFromDate:date];
	
}

@end
