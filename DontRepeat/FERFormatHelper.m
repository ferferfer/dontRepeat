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

-(NSMutableArray *)sortDontRepeatsByDate:(NSMutableArray *)array{
	
	NSArray *arrayWithCoolDate=[self formatDateInArray:array toSort:YES];
	
	NSSortDescriptor *appearanceDescriptor =
	[[NSSortDescriptor alloc] initWithKey:@"dontRepeatDate"
															ascending:YES
															 selector:@selector(localizedCaseInsensitiveCompare:)];
 
	
	NSArray *sortedArray = [arrayWithCoolDate sortedArrayUsingDescriptors: [NSArray arrayWithObject:appearanceDescriptor]];
	
	NSLog(@"%@",sortedArray);
	return [self formatDateInArray:sortedArray toSort:NO];
	
}

-(NSMutableArray *)formatDateInArray:(NSArray *)array toSort:(BOOL)sort{
	NSMutableArray *arrayWithDateFormatedToSort=[[NSMutableArray alloc]init];
	for (NSObject *obj in array) {
		DontRepeat *dont=(DontRepeat *)obj;
		if (sort) {
			dont.dontRepeatDate=[self formatDateToSort:dont.dontRepeatDate];
		}else{
			dont.dontRepeatDate=[self formatDateToShow:dont.dontRepeatDate];
		}

		[arrayWithDateFormatedToSort addObject:dont];
	}
	return arrayWithDateFormatedToSort;
}

-(NSString *)formatDateToSort:(NSString *)date{
	NSString *year=[date substringWithRange:NSMakeRange(6,4)];
	NSString *month=[date substringWithRange:NSMakeRange(3,2)];
	NSString *day=[date substringWithRange:NSMakeRange(0,2)];
	
	return [NSString stringWithFormat:@"%@%@%@",year,month,day];
	
}

-(NSString *)formatDateToShow:(NSString *)date{
	NSString *year=[date substringWithRange:NSMakeRange(0,4)];
	NSString *month=[date substringWithRange:NSMakeRange(4,2)];
	NSString *day=[date substringWithRange:NSMakeRange(6,2)];
	
	return [NSString stringWithFormat:@"%@/%@/%@",day,month,year];
}

-(NSString *)removeSpacesAndSlashes:(NSString *)text{
	NSString *textWithoutSlash=[text stringByReplacingOccurrencesOfString:@"/" withString:@""];
	return [textWithoutSlash stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
