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
	
	NSString *filePath=[self pathOfPlistInDocumentsFolder:@"UserList"];
	
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

-(BOOL)plistExistInDocumentsFolder:(NSString *)name{
	NSString *path=[self pathOfPlistInDocumentsFolder:name];
	NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
	if (array) {
		return YES;
	}
	return NO;
}

-(NSString *)pathOfPlistInDocumentsFolder:(NSString *)name{
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory=[paths firstObject];
	
	NSString *filePath= [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",name]];
	return filePath;
}

-(FERUser	*)loadUser{
	NSString *path=[self pathOfPlistInDocumentsFolder:@"UserList"];
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
	NSString *path=[self pathOfPlistInDocumentsFolder:@"UserList"];
	NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
	return [array count];
}

-(void)saveDontRepeatToPlist:(DontRepeat *)dontRepeat{
	
	NSString *filePath=[self pathOfPlistInDocumentsFolder:@"DontRepeats"];
	
	NSMutableDictionary *dict=[NSMutableDictionary	dictionary];
	
	NSMutableDictionary *storeDict=[NSMutableDictionary dictionary];
	[storeDict setValue:dontRepeat.dontRepeatTitle forKey:@"Title"];
	[storeDict setValue:dontRepeat.dontRepeatDate forKey:@"Date"];
	if (dontRepeat.dontRepeatDesc==nil){
		[storeDict setValue:@"" forKey:@"Desc"];
	}	else{
		[storeDict setValue:dontRepeat.dontRepeatDesc forKey:@"Desc"];
	}
	if (dontRepeat.dontRepeatPicture==nil) {
		[storeDict setValue:@"" forKey:@"Pic"];
	}else{
		[storeDict setValue:dontRepeat.dontRepeatPicture forKey:@"Pic"];
	}

	[dict setObject:storeDict forKey:dontRepeat.dontRepeatID];

	[dict writeToFile:filePath atomically: YES];
	
}

-(NSMutableArray	*)loadDontRepeats{
	NSString *path=[self pathOfPlistInDocumentsFolder:@"DontRepeats"];
	NSMutableDictionary *contentDictionary= [NSMutableDictionary dictionaryWithContentsOfFile:path];
//	NSMutableArray *contentArray = [NSMutableArray arrayWithContentsOfFile:path];
	NSMutableArray *dontRepeats=[[NSMutableArray alloc]init];
	
	for (NSString *key in contentDictionary) {
	//for(int i=0;i<contentArray.count;i++){
		NSMutableDictionary *dic=[contentDictionary objectForKey:key];
		DontRepeat *dont = [[DontRepeat alloc] init];
		dont.dontRepeatTitle= [dic objectForKey:@"Title"];
		dont.dontRepeatDate = [dic objectForKey:@"Date"];
		dont.dontRepeatDesc = [dic objectForKey:@"Desc"];
		dont.dontRepeatPicture = [dic objectForKey:@"Pic"];
		dont.dontRepeatID	= [dic objectForKey:@"Id"];
		[dontRepeats addObject:dont];
	}
	return dontRepeats;
}


@end
