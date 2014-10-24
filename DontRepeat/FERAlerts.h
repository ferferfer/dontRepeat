//
//  FERAlerts.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 24/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FERAlerts : NSObject

-(void)alertRegisterError;
-(void)alertNewUserCreated;
-(void)alertRegisterErrorMailInUse;
-(void)alertError;
-(void)alertPasswordsNotMatch;
-(void)alertPasswordCannotBeBlank;
-(void)alertInfo;
-(void)alertResetPasswordError;
-(void)alertResetPasswordSuccess;
-(void)alertChangePasswordError;
-(void)alertChangePasswordSuccess;

@end
