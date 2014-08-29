//
//  FERUserManager.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

@class FERUser;

@protocol UserManagerProtocol <NSObject>

-(void)userManagerDidAddUser:(FERUser *)user;

@end

@interface FERUserManager : NSObject

@property (nonatomic, weak) id<UserManagerProtocol> delegate;


@end
