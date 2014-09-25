//
//  FERFormatHelper.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 03/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FERFormatHelper : NSObject

-(NSString *)cleanMail:(NSString *)mail;
-(NSString *)returnStringFromDate:(NSDate *)date;
-(NSDate *)returnDateFromString:(NSString *)string;
-(NSMutableArray *)orderDontRepeatsByDate:(NSMutableArray *)array;
-(NSString *)removeSpacesAndSlashes:(NSString *)text;
@end
