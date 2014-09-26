//
//  PlistManager.h
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 02/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FERUser.h"
#import "DontRepeat.h"

@interface FERPlistManager : NSObject

-(void)addUser:(FERUser *)user;
-(BOOL)plistExistInDocumentsFolder:(NSString *)name;
-(FERUser	*)loadUser;
-(NSInteger)numberOfUsersInPlist;
-(void)saveDontRepeatToPlist:(DontRepeat *)dontRepeat;
-(NSMutableArray	*)loadDontRepeats;
-(NSInteger)numberOfDontRepeatsInPlist;
-(void)saveAllDontRepeatToPlistFromArray:(NSArray *)dontRepeatArray;
@end
