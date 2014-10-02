//
//  FERFirebaseManager.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 03/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FERUser.h"
#import "DontRepeat.h"
#import <Firebase/Firebase.h>

@interface FERFirebaseManager : NSObject

-(void)saveUserInFirebase:(FERUser *)user;
-(void)saveDontRepeatToFirebase:(DontRepeat	*)dontRepeat forUser:(FERUser *)user;
-(void)removeDontRepeatToFirebase:(DontRepeat *)dontRepeat forUser:(FERUser *)user;
-(void)updateDontRepeatToFirebase:(DontRepeat *)dontRepeat
														 with:(DontRepeat *)oldDontRepeat
													forUser:(FERUser *)user;
-(Firebase *)arriveToUserFolder:(FERUser *)user;
@end
