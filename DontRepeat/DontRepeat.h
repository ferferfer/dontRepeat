//
//  DontRepeat.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 05/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DontRepeat : NSObject

@property (nonatomic, strong) NSString * dontRepeatDate;
@property (nonatomic, copy) NSString * dontRepeatTitle;
@property (nonatomic, copy) NSString * dontRepeatDesc;
@property (nonatomic, strong) NSData * dontRepeatPicture;
@property (nonatomic, copy) NSString * dontRepeatLocalization;

@end
