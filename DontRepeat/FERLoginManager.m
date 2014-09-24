//
//  FERLoginManager.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERLoginManager.h"
#import "FERUser.h"
#import <Firebase/Firebase.h>

#import <FirebaseSimpleLogin/FirebaseSimpleLogin.h>

@interface FERLoginManager ()

@property (strong, nonatomic) Firebase *fireBaseURLSessions;
@property (nonatomic, strong) FirebaseSimpleLogin *authClient;

@end

@implementation FERLoginManager

-(instancetype)init
{
    self = [super init];
    if (self) {
        _fireBaseURLSessions = [[Firebase alloc] initWithUrl:@"https://dontrepeat.firebaseio.com"];
        _authClient = [[FirebaseSimpleLogin alloc] initWithRef:_fireBaseURLSessions];
    }
    NSLog(@"init Login Manager");
    return self;
}

-(void)isUserLoginWithcompletionBlock:(void(^)(BOOL isLogin, FERUser *user))completion{
    [self.authClient checkAuthStatusWithBlock:^(NSError* error, FAUser* fbuser) {
        
        if (error != nil) {
            completion(FALSE, nil);
        } else if (fbuser == nil) {
            completion(FALSE, nil);
        } else {
            FERUser *myUser = [[FERUser alloc] init];
            myUser.userID = fbuser.userId;
            completion(TRUE, myUser);
        }
    }];
}

-(void)loginUser:(FERUser *)aUser completionBlock:(void(^)(BOOL isLogin, NSString *userID))completion
{
    [self.authClient loginWithEmail:aUser.userMail andPassword:aUser.userPassword
                withCompletionBlock:^(NSError* error, FAUser* user) {
                    
                    if (error != nil) {
                        completion(FALSE, nil);
                        NSLog(@"User Login Error: %@", error.description);
                        
                    } else {
                        completion(TRUE, user.userId);
                        NSLog(@"User Login OK");
                    }
                }];
}

-(void)registerUser:(FERUser *)aUser completionBlock:(void(^)(NSError *error, NSString *userID))completion
{
    [self.authClient checkAuthStatusWithBlock:^(NSError* error, FAUser* user) {
        if (error != nil) {
            // Oh no! There was an error performing the check
        } else if (user == nil) {
            
            NSLog(@"No user is logged in");
            
            [self.authClient createUserWithEmail:aUser.userMail password:aUser.userPassword
                              andCompletionBlock:^(NSError* error, FAUser* user) {
                                  
                                  if (error != nil) {
                                      // There was an error creating the account
                                      NSLog(@"Error creating new user: %@", error.description);
                                      completion(error, nil);
                                  } else {
                                      // We created a new user account
                                      NSLog(@"Register new user: %@ success", aUser.userNick);
                                      completion (error, user.userId);
                                  }
                              }];
        } else {
            NSLog(@"There is a logged in user");
        }
    }];
}

-(void)rememberPassword:(FERUser *)aUser completionBlock:(void(^)(NSError *error))completion
{
    [self.authClient sendPasswordResetForEmail:aUser.userMail andCompletionBlock:^(NSError* error, BOOL success) {
        
        if (error != nil) {
            NSLog(@"Error processing reset password request: %@", error.description);
            completion(error);
        } else if (success) {
            NSLog(@"Processing reset password request success");
            completion(error);
        }
    }];
}

-(void)logout
{
    [self.authClient logout];
}


#pragma mark - Save and Get User Data in Firebase
-(void)saveUserInFiBase:(FERUser *)user
{
    Firebase *fireBaseUserURL = [self.fireBaseURLSessions childByAppendingPath:[NSString stringWithFormat:@"/users/%@", user.userID]];
    NSDictionary *userDict = @{@"userID": user.userID,
                               @"userMail": user.userMail,
                               @"userPassword": user.userPassword};
    [fireBaseUserURL setValue:userDict withCompletionBlock:^(NSError *error, Firebase *ref) {
        if (error) {
            NSLog(@"%@", error.description);
        } else {
            NSLog(@"Save user data in FireBase success");
        }
    }];
}

-(void)userDataWithUser:(FERUser *)user completionBlock:(void(^)(NSError *error, FERUser *user))completion
{
    Firebase *fireBaseUserURL = [self.fireBaseURLSessions childByAppendingPath:[NSString stringWithFormat:@"/users/%@", user.userID]];
    [fireBaseUserURL observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if(snapshot.value == [NSNull null]) {
            NSError *error;
            completion(error, nil);
            NSLog(@"User doesn't exist");
        } else {
            FERUser *myUser = [[FERUser alloc] init];
            myUser.userID = snapshot.value[@"userID"];
            myUser.userNick = snapshot.value[@"userNick"];
            myUser.userMail = snapshot.value[@"userMail"];
          
            completion(nil, myUser);
        }
    }];
}

#pragma mark - Cache User
//-(void)saveUserNameInUserDefault:(FERUser *)user;
//{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault setObject:user.userID forKey:@"userID"];
//    [userDefault setObject:user.userMail forKey:@"userMail"];
//    [userDefault setObject:user.userNick forKey:@"userNick"];
//    [userDefault synchronize];
//}
//
//-(FERUser *)readPreviousUserInUserDefault
//{
//    FERUser *userCache = [[FERUser alloc] init];
//    userCache.userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
//    userCache.userMail = [[NSUserDefaults standardUserDefaults] objectForKey:@"userMail"];
//    userCache.userNick = [[NSUserDefaults standardUserDefaults] objectForKey:@"userNick"];
//
//    return userCache;
//}


@end
