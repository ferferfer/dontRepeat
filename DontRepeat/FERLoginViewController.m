//
//  FERLoginViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 21/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERLoginViewController.h"
#import "FERFirebaseManager.h"
#import "FERMainCollectionView.h"
#import "FERPlistManager.h"
#import "FERUser.h"
#import "FERFormatHelper.h"

#import <Firebase/Firebase.h>
#import <FirebaseSimpleLogin/FirebaseSimpleLogin.h>

@interface FERLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *buttonSegue;
@property (nonatomic,strong)FERUser *theUser;
@property (nonatomic,strong)FERPlistManager *plist;
@property	(nonatomic,strong)FirebaseSimpleLogin *authClient;
@property	(nonatomic,strong)Firebase* ref;
@property	(nonatomic,strong)FERFormatHelper *formatHelper;

@end

@implementation FERLoginViewController

-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad{
	[super viewDidLoad];
	[self loadUserTextFields];
	[self loginProcess];
}

-(Firebase *)ref{
	if(_ref==nil){
		_ref = [[Firebase alloc] initWithUrl:@"https://dontrepeat.firebaseio.com/"];
	}
	return _ref;
}

-(FirebaseSimpleLogin *)authClient{
	if(_authClient==nil){
		_authClient = [[FirebaseSimpleLogin alloc] initWithRef:self.ref];
	}
	return _authClient;
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

-(FERFormatHelper *)formatHelper{
	if (_formatHelper==nil) {
		_formatHelper=[[FERFormatHelper alloc]init];
	}
	return _formatHelper;
}



-(void)loadUserTextFields{
	FERUser *userText=[self.plist loadUser];
	self.email.text=userText.userMail;
	self.password.text=userText.userPassword;
	self.password.secureTextEntry = YES;
}


- (IBAction)loginPressed:(id)sender {
	[self saveUser];
	[self loginUser:self.theUser];
}

- (IBAction)passwordResetPressed:(id)sender {

}

- (IBAction)passwordChangePressed:(id)sender {
	
	

}


#pragma mark - User LogIn
-(void)loginUser:(FERUser *)theUser{
	[self dismissViewControllerAnimated:YES completion:nil];
	[self.authClient loginWithEmail:self.email.text andPassword:self.password.text
							withCompletionBlock:^(NSError* error, FAUser* user) {
								if (error != nil) {
									if (![self tryToLoginWithPlist]) {
										[self alertRegisterError];
										NSLog(@"There was an error logging in to this account: %@",error);
									}
								} else {
									[self.plist addUser:theUser];
									[self.buttonSegue sendActionsForControlEvents:UIControlEventTouchUpInside];
									NSLog(@"We are now logged in");
								}
							}];
}

-(BOOL)tryToLoginWithPlist{
	FERUser *userText=[self.plist loadUser];
	if ([self.email.text isEqualToString:userText.userMail] &&
			[self.password.text isEqualToString:userText.userPassword]) {
		[self.buttonSegue sendActionsForControlEvents:UIControlEventTouchUpInside];
		NSLog(@"We are now logged in with plist");
		return YES;
	}
	return NO;
}

-(void)alertRegisterError{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Error"
																									message:@"User Name or password incorect"
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
}

- (void)saveUser{
	self.theUser.userMail = self.email.text;
	self.theUser.userPassword = self.password.text;
	self.theUser.userNick = [self.formatHelper cleanMail:self.email.text];
}

#pragma mark - Login Process
-(void)loginProcess{
	[self isUserLoginWithcompletionBlock:^(BOOL isLogin, FERUser *user) {
		if (isLogin) {
			NSLog(@"User is Login");
			[self.buttonSegue sendActionsForControlEvents:UIControlEventTouchUpInside];
		};
	}];
}

-(void)isUserLoginWithcompletionBlock:(void(^)(BOOL isLogin, FERUser *user))completion{
	[self.authClient checkAuthStatusWithBlock:^(NSError* error, FAUser* fbuser) {
		
		if (error != nil) {
			completion(FALSE, nil);
		} else if (fbuser == nil) {
			completion(FALSE, nil);
		} else {
			self.theUser.userID = fbuser.userId;
			completion(TRUE, self.theUser);
		}
	}];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if ([segue.identifier isEqualToString:@"logInSegue"]) {
			FERMainCollectionView *mcv=[segue destinationViewController];
			FERUser *loggedUser=[self.plist loadUser];
			mcv.user=loggedUser;
			mcv.authClient=self.authClient;
	}
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
}


@end
