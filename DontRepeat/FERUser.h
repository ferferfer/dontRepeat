//
//  FERUser.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FERUser : NSObject

@property (strong, nonatomic) NSString *userID;
@property (nonatomic, copy) NSString *userNick;
@property (nonatomic, copy) NSString *userMail;
@property (nonatomic, copy) NSString *userPassword;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end