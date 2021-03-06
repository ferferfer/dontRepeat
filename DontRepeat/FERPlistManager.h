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
-(void)removeUserFromUserList;
-(BOOL)plistExistInDocumentsFolder:(NSString *)name;
-(FERUser	*)loadUser;
-(NSInteger)numberOfUsersInPlist;
-(NSMutableArray	*)loadDontRepeatsFromUser:(FERUser *)user;
-(NSInteger)numberOfDontRepeatsInPlistForUser:(FERUser *)user;
-(NSInteger)numberOfDeletedDontRepeatsInPlistForUser:(FERUser *)user;
-(void)saveAllDontRepeatToPlistFromArray:(NSArray *)dontRepeatArray
																 forUser:(FERUser *)user;
-(void)saveDontRepeatToPlist:(DontRepeat *)dontRepeat
										 forUser:(FERUser *)user;
-(void)updateDontRepeatToPlist:(DontRepeat *)dontRepeat
													with:(DontRepeat *)oldDontRepeat
											 forUser:(FERUser *)user;
-(void)removeDontRepeatToPlist:(DontRepeat *)dontRepeat
forUser:(FERUser *)user;

@end
