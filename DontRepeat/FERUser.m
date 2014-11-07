//
//  FERUser.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERUser.h"

@implementation FERUser

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _userID = [dictionary objectForKey:@"userID"];
        _userMail = [dictionary objectForKey:@"userMail"];
        _userNick = [dictionary objectForKey:@"userNick"];
    }
    return self;
}

@end
