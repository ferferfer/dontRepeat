//
//  FERFirstViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 10/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERFirstViewController.h"
#import "FERPlistManager.h"
#import "FERUser.h"
#import "FERMainCollectionView.h"
#import "FERLoginViewController.h"

#import <Firebase/Firebase.h>

@interface FERFirstViewController () 
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *aNewUserButton;
@property (weak, nonatomic) IBOutlet UIButton *existingUserButton;
@property (weak, nonatomic) IBOutlet UIButton *buttonSegue;
@property (nonatomic,strong)FERPlistManager *plist;
@property (nonatomic,strong)FERUser *theUser;
@property	(nonatomic,strong)Firebase* firebase;

@end

@implementation FERFirstViewController

-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];
		[self loginProcess];
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[self iPadBackground];
	}
	[self configure];
}


-(Firebase *)firebase{
	if(_firebase==nil){
		_firebase = [[Firebase alloc] initWithUrl:@"https://dontrepeat.firebaseio.com/"];
	}
	return _firebase;
}

-(FERUser *)theUser{
	if (_theUser==nil) {
		_theUser=[[FERUser alloc]init];
		
	}
	return _theUser;
}

-(FERPlistManager	*)plist{
	if (_plist==nil) {
		_plist=[[FERPlistManager alloc]init];
	}
	return _plist;
}


-(void)configure{
	[UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionAllowAnimatedContent
									 animations:^{
										 self.imageView.alpha=0.4;
										 self.aNewUserButton.alpha=1;
										 self.existingUserButton.alpha=1;
									 } completion:^(BOOL finished) {
									 }];
}


-(void)iPadBackground{
	[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
	if ([[UIDevice currentDevice]orientation]==UIInterfaceOrientationPortrait){
			self.imageView.image=[UIImage imageNamed:@"launch_portrait1024"];
	}else if([[UIDevice currentDevice]orientation]==UIInterfaceOrientationPortraitUpsideDown){
		self.imageView.image=[UIImage imageNamed:@"launch_portraitUpsidedown1024"];
	}else if([[UIDevice currentDevice]orientation]==UIInterfaceOrientationLandscapeRight){
		self.imageView.image=[UIImage imageNamed:@"launch_landscapeLeft1024"];
	}else if([[UIDevice currentDevice]orientation]==UIInterfaceOrientationLandscapeLeft){
		self.imageView.image=[UIImage imageNamed:@"launch_landscapeRight1024"];
	}else{
		self.imageView.image=[UIImage imageNamed:@"launch_portrait1024"];		
	}
	
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
			self.imageView.contentMode=UIViewContentModeScaleAspectFill;
	switch ([[UIDevice currentDevice]orientation]) {
		case 1:
			self.imageView.image=[UIImage imageNamed:@"launch_portrait1024"];
			break;
		case 2:
			self.imageView.image=[UIImage imageNamed:@"launch_portraitUpsidedown1024"];
			break;
		case 3:
			self.imageView.image=[UIImage imageNamed:@"launch_landscapeLeft1024"];
			break;
		case 4:
			self.imageView.image=[UIImage imageNamed:@"launch_landscapeRight1024"];
			break;
  default:
			break;
	}
}

#pragma mark - Login Process
-(void)loginProcess{
	[self isUserLoginWithcompletionBlock:^(BOOL isLogin, FERUser *user){
		if (isLogin) {
			if ([self.plist numberOfUsersInPlist]==1) {
				NSLog(@"User is Login");
				[self.buttonSegue sendActionsForControlEvents:UIControlEventTouchUpInside];
			}
		};
	}];
}

-(void)isUserLoginWithcompletionBlock:(void(^)(BOOL isLogin, FERUser *user))completion{
	[self.firebase observeAuthEventWithBlock:^(FAuthData *authData) {
		
		if (authData == nil) {
			completion(FALSE, nil);
		} else {
			self.theUser.userID = authData.uid;
			completion(TRUE, self.theUser);
		}
	}];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if ([segue.identifier isEqualToString:@"goAhead"]) {
		FERMainCollectionView *mcv=[segue destinationViewController];
		FERUser *loggedUser=[self.plist loadUser];
		mcv.user=loggedUser;
		mcv.authClient=self.firebase;
	}
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
}

@end
