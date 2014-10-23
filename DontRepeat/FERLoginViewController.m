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
#import "FERResetPasswordViewController.h"
#import	"FERChangePasswordViewController.h"
#import "FERFirstViewController.h"

#import <Firebase/Firebase.h>

@interface FERLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *buttonSegue;
@property (nonatomic,strong)FERUser *theUser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic,strong)FERPlistManager *plist;
@property	(nonatomic,strong)Firebase* firebase;
@property	(nonatomic,strong)FERFormatHelper *formatHelper;

@end

@implementation FERLoginViewController

-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad{
	[super viewDidLoad];
	[self stop];
	[self loadUserTextFields];
}

-(Firebase *)firebase{
	if(_firebase==nil){
		_firebase = [[Firebase alloc] initWithUrl:FERFireBaseURL];
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
	[self wait];
}

-(void)wait{
	self.loginButton.enabled=NO;
	self.activityIndicator.hidden=NO;
	[self.activityIndicator startAnimating];
}

-(void)stop{
	self.loginButton.enabled=YES;
	self.activityIndicator.hidden=YES;
	[self.activityIndicator stopAnimating];
}

#pragma mark - User LogIn
-(void)loginUser:(FERUser *)theUser{
	[self dismissViewControllerAnimated:YES completion:nil];
	[self.firebase authUser:self.email.text password:self.password.text withCompletionBlock:^(NSError *error, FAuthData *authData) {
		if (error != nil) {
			if (![self tryToLoginWithPlist]) {
				[self alertRegisterError];
				NSLog(@"There was an error logging in to this account: %@",error);
			}
			[self stop];
		} else {
			[self.plist addUser:theUser];
			[self stop];
			NSLog(@"We are now authed");
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}

- (void)saveUser{
	self.theUser.userMail = self.email.text;
	self.theUser.userPassword = self.password.text;
	self.theUser.userNick = [self.formatHelper cleanMail:self.email.text];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	
	if ([segue.identifier isEqualToString:@"logInSegue"]) {
		FERMainCollectionView *mcv=[segue destinationViewController];
		FERUser *loggedUser=[self.plist loadUser];
		mcv.user=loggedUser;
		mcv.authClient=self.firebase;
	}
	
	if ([segue.identifier isEqualToString:@"resetSegue"]) {
		FERResetPasswordViewController *rpvc=[segue destinationViewController];
		rpvc.emailTextField.text=self.email.text;
	}
	if ([segue.identifier isEqualToString:@"changeSegue"]) {
		FERChangePasswordViewController *cpvc=[segue destinationViewController];
		cpvc.emailTextField.text=self.email.text;
	}
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
}


@end
