//
//  FERJsonManager.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 25/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERJsonManager.h"

@implementation FERJsonManager

-(void)saveDontRepeatToPlist:(DontRepeat *)dontRepeat{
	
	NSString *filePath=[self pathOfJsonInDocumentsFolder];
	
	NSMutableArray *myJSON = [[NSArray arrayWithContentsOfFile:filePath] mutableCopy];
	

	NSMutableDictionary *json=[NSMutableDictionary	dictionary];
	
  NSMutableDictionary *storeJSON=[NSMutableDictionary dictionary];
	[storeJSON setValue:@"Title" forKey:dontRepeat.dontRepeatTitle];
	[storeJSON setValue:@"Date" forKey:dontRepeat.dontRepeatDate];
	[storeJSON setValue:@"Desc" forKey:dontRepeat.dontRepeatDesc];
	[storeJSON setValue:@"Pic" forKey:dontRepeat.dontRepeatPicture];

	[json setObject:storeJSON forKey:dontRepeat.dontRepeatID];
	
	NSMutableArray *array=[myJSON mutableCopy];
	[array addObject:json];
	[array writeToFile:filePath atomically: YES];
	
}

//-(Session *)loadSessionWithIndex:(NSInteger)index{
//	NSString *path=[self pathOfPlistInDocumentsFolder];
//	NSMutableArray *contentArray = [NSMutableArray arrayWithContentsOfFile:path];
//	NSMutableDictionary *data=[contentArray objectAtIndex:index];
//	NSMutableArray *arrayOfCoordinates= [data objectForKey:@"route"];
//	Route *route=[[Route alloc]initWithArrayofCoordinates:arrayOfCoordinates];
//	Session *session=[[Session alloc]initWithDate:[data valueForKey:@"sessionDate"]
//																andTotalRunning:[[data valueForKey:@"totalRunning"] intValue]
//																andTotalWalking:[[data valueForKey:@"totalWalking"] intValue]
//																 andTimeRunning:[[data valueForKey:@"timeRunning"] intValue]
//																 andTimewalking:[[data valueForKey:@"timeWalking"] intValue]
//																		andDistance:[[data valueForKey:@"distance"] doubleValue]
//																		 andAvSpeed:[[data valueForKey:@"avSpeed"] doubleValue]
//																				andKcal:[[data valueForKey:@"kcal"] doubleValue]
//																			 andRoute:route];
//	
//	return session;
//	
//}

-(BOOL)jsonExistInDocumentsFolder{
	NSString *path=[self pathOfJsonInDocumentsFolder];
	NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
	if (array) {
		return YES;
	}
	return NO;
}

-(NSString *)pathOfJsonInDocumentsFolder{
	NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory=[paths firstObject];
	NSString *filePath= [documentsDirectory stringByAppendingPathComponent:@"file.json"];
	
	//NSString *filePath = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"json"];
	return filePath;
}



-(NSInteger)numberofDontRepeatsInJson{
	NSString *path=[self pathOfJsonInDocumentsFolder];
	NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
	return [array count];
}

-(NSArray *)arrayOfDontRepeats{
	NSString *path=[self pathOfJsonInDocumentsFolder];
	NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:path];
	NSMutableArray *dontRepeatArray=[[NSMutableArray alloc]init];
	for(int i=1;i<[array count];i++){
		[dontRepeatArray addObject:[array objectAtIndex:i]];
	}
	return dontRepeatArray;
}

@end
