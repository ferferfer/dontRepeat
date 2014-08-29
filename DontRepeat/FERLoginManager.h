//
//  FERLoginManager.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//
@class FERUser;
@class FAUser;

@interface FERLoginManager : NSObject

-(instancetype)init;

-(void)isUserLoginWithcompletionBlock:(void(^)(BOOL isLogin, FERUser *user))completion;
-(void)loginUser:(FERUser *)aUser completionBlock:(void(^)(BOOL isLogin, NSString *userID))completion;
-(void)registerUser:(FERUser *)aUser completionBlock:(void(^)(NSError *error, NSString *userID))completion;
-(void)rememberPassword:(FERUser *)aUser completionBlock:(void(^)(NSError *error))completion;;
-(void)logout;

-(void)userDataWithUser:(FERUser *)user completionBlock:(void(^)(NSError *error, FERUser *user))completion;

-(void)saveUserInFiBase:(FERUser *)user;

@end
