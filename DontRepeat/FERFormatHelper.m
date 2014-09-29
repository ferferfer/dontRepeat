//
//  FERFormatHelper.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 03/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERFormatHelper.h"
#import "DontRepeat.h"

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

-(NSDate *)returnDateFromString:(NSString *)string{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"dd/MM/yyyy"];
	
	return [dateFormatter dateFromString:string];
}

-(NSMutableArray *)sortDontRepeatsByTitle:(NSMutableArray *)array{

	NSSortDescriptor *appearanceDescriptor =
	[[NSSortDescriptor alloc] initWithKey:@"dontRepeatTitle"
															ascending:YES
															 selector:@selector(localizedCaseInsensitiveCompare:)];
 
	
	NSArray *sortedArray = [array sortedArrayUsingDescriptors: [NSArray arrayWithObject:appearanceDescriptor]];
	NSLog(@"%@",sortedArray);
	return [sortedArray mutableCopy];
	
}

-(NSString *)removeSpacesAndSlashes:(NSString *)text{
	NSString *textWithoutSlash=[text stringByReplacingOccurrencesOfString:@"/" withString:@""];
	return [textWithoutSlash stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
