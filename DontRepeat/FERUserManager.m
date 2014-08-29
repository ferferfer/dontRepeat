//
//  RMMUserManager.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERUserManager.h"
#import "FERUser.h"

#import <Firebase/Firebase.h>

@interface FERUserManager ()

@property (nonatomic, strong) Firebase *fireBaseURLLiveUsers;

@end


@implementation FERUserManager

#pragma mark - Setup Live Firebase CallBacks
-(void)setupFirebaseCallbacks
{
    [self.fireBaseURLLiveUsers observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [self fireBaseDetectNewUser:snapshot.name];
    }];
}

#pragma mark - User Utils
-(void)fireBaseDetectNewUser:(NSString *)userID
{
    NSLog(@"UserId: %@ join to Session", userID);
    
    Firebase *userURL = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"https://dontrepeat.firebaseio.com/users/%@", userID]];
    [userURL observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        if (snapshot.value == [NSNull null]) {
            NSLog(@"They arent users");
        } else {
            FERUser *user = [[FERUser alloc] initWithDictionary:snapshot.value];
            [self.delegate userManagerDidAddUser:user];
        }
        
    }];
    
}


@end
