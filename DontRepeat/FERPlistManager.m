//
//  PlistManager.m
//  StartRunning
//
//  Created by Fernando Garcia Corrochano on 02/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERPlistManager.h"

@implementation FERPlistManager

-(void)addUser:(FERUser *)user{
	
	NSString *filePath=[self pathOfPlistInDocumentsFolder];
	
	NSMutableDictionary *newUser=[[NSMutableDictionary alloc]init];
	[newUser setValue:user.userNick forKey:@"userNick"];
	[newUser setValue:user.userPassword forKey:@"userPassword"];
	[newUser setValue:user.userMail forKey:@"userMail"];
	[newUser setValue:user.userID forKey:@"userID"];
	
	NSMutableArray *array=[NSMutableArray arrayWithContentsOfFile:filePath];
	if (array) {
		[array removeObjectAtIndex:0];
		[array insertObject:newUser atIndex:0];
	}else{
		array=[[NSMutableArray alloc]init];
		[array addObject:newUser];
	}
	
	[array writeToFile:filePath atomically: YES];
	
}




-(BOOL)plistExistInDocumentsFolder{
	NSString *path=[self pathOfPlistInDocumentsFolder];
	NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
	if (array) {
		return YES;
	}
	return NO;
}

-(NSString *)pathOfPlistInDocumentsFolder{
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory=[paths firstObject];
	
	NSString *filePath= [documentsDirectory stringByAppendingPathComponent:@"UserList.plist"];
	return filePath;
}

-(FERUser	*)loadUser{
	NSString *path=[self pathOfPlistInDocumentsFolder];
	NSMutableArray *contentArray = [NSMutableArray arrayWithContentsOfFile:path];
	NSMutableDictionary *data=[contentArray firstObject];
	FERUser *user=[[FERUser alloc]init];
	user.userID=[data valueForKey:@"userID"];
	user.userPassword=[data valueForKey:@"userPassword"];
	user.userMail=[data valueForKey:@"userMail"];
	user.userNick=[data valueForKey:@"userNick"];
	
	return user;
}

-(NSInteger)numberOfUsersInPlist{
	NSString *path=[self pathOfPlistInDocumentsFolder];
	NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
	return [array count];
}




@end
