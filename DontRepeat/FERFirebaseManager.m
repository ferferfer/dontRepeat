//
//  FERFirebaseManager.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 03/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERFirebaseManager.h"
#import "FERFormatHelper.h"
#import	"FERPlistManager.h"

NSString *const FERFireBaseURL = @"https://dontrepeat.firebaseio.com/";

@interface FERFirebaseManager	()

@property (strong, nonatomic) Firebase *ref;
@property (strong, nonatomic) FERFormatHelper	*formatHelper;
@property	(strong, nonatomic) FERPlistManager *plistManager;
@property (nonatomic,strong)	NSMutableArray *dontRepeats;

@end

@implementation FERFirebaseManager


- (instancetype)init{
	self = [super init];
	if (self) {
		_ref = [[Firebase alloc] initWithUrl:FERFireBaseURL];
	}
	return self;
}

-(FERFormatHelper *)formatHelper{
	if (_formatHelper==nil) {
    _formatHelper=[[FERFormatHelper alloc]init];
	}
	return _formatHelper;
}

-(FERPlistManager *)plistManager{
	if(_plistManager==nil){
		_plistManager=[[FERPlistManager	alloc]init];
	}
	return _plistManager;
}

-(Firebase *)arriveToUserFolder:(FERUser *)user{
	NSString *formatedMail=[self.formatHelper cleanMail:user.userMail];
	
	Firebase *nameRef = [[Firebase alloc] initWithUrl:FERFireBaseURL];
	nameRef= [nameRef childByAppendingPath:@"users"];
	nameRef= [nameRef childByAppendingPath:formatedMail];
	return nameRef;
}

-(void)saveUserInFirebase:(FERUser *)user{
	Firebase *nameRef = [self arriveToUserFolder:user];
	[[nameRef childByAppendingPath:@"mail"] setValue:user.userMail];
}

-(void)saveDontRepeatToFirebase:(DontRepeat	*)dontRepeat forUser:(FERUser *)user{
	
	Firebase *nameRef = [self arriveToUserFolder:user];
	nameRef=[nameRef childByAppendingPath:dontRepeat.dontRepeatID];
  [[nameRef childByAppendingPath:@"Title"] setValue:dontRepeat.dontRepeatTitle];
	[[nameRef childByAppendingPath:@"Date"] setValue:dontRepeat.dontRepeatDate];
	[[nameRef childByAppendingPath:@"Desc"] setValue:dontRepeat.dontRepeatDesc];
	[[nameRef childByAppendingPath:@"Pic"] setValue:dontRepeat.dontRepeatPicture];

}

-(void)removeDontRepeatToFirebase:(DontRepeat *)dontRepeat forUser:(FERUser *)user{
	Firebase *nameRef = [self arriveToUserFolder:user];
	[[nameRef childByAppendingPath:dontRepeat.dontRepeatID] setValue:nil];
}

-(void)updateDontRepeatToFirebase:(DontRepeat *)dontRepeat
														 with:(DontRepeat *)oldDontRepeat
													forUser:(FERUser *)user{
	[self removeDontRepeatToFirebase:oldDontRepeat forUser:user];
	[self saveDontRepeatToFirebase:dontRepeat forUser:user];
}

@end
