//
//  Suitcase.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 05/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Suitcase : NSObject

@property (nonatomic, strong) NSDate * suitcaseDate;
@property (nonatomic, copy) NSString * suitcaseTitle;
@property (nonatomic, copy) NSString * suitcaseDesc;
@property (nonatomic, strong) NSData * suitcasePicture;
@property (nonatomic, copy) NSString * suitcaseLocalization;

@end
