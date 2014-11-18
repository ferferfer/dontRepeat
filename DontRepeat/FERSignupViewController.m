//
//  FERSignupViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 10/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERSignupViewController.h"
#import "FERUser.h"
#import "FERFirebaseManager.h"
#import "FERFormatHelper.h"
#import "FERMainCollectionView.h"
#import "FERPlistManager.h"
#import "FERInfoViewController.h"
#import "FERAlerts.h"

#import <Firebase/Firebase.h>

@interface FERSignupViewController ()<FERInfoViewControllerDelegate, UIPopoverControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;
@property	(strong, nonatomic)FERUser *theUser;
@property	(nonatomic,strong)Firebase *firebase;
@property	(nonatomic,strong)FERFirebaseManager *fireManager;
@property	(nonatomic,strong)FERFormatHelper *formatHelper;
@property (nonatomic,strong)FERPlistManager *plist;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;
@property (weak, nonatomic) IBOutlet UIButton *infoButtonForiPhone;
@property (nonatomic, strong) UIPopoverController *infoPopover;
@property (nonatomic) BOOL shouldHidePopOver;
@property (nonatomic,strong)FERAlerts *alert;

@end

@implementation FERSignupViewController

-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.emailTextField.delegate=self;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[self configurePopover];
	}
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

-(FERFormatHelper *)formatHelper{
	if (_formatHelper==nil) {
		_formatHelper=[[FERFormatHelper alloc]init];
	}
	return _formatHelper;
}

-(FERFirebaseManager *)fireManager{
	if (_fireManager==nil) {
		_fireManager=[[FERFirebaseManager alloc]init];
	}
	return _fireManager;
}

-(FERPlistManager	*)plist{
	if (_plist==nil) {
		_plist=[[FERPlistManager alloc]init];
	}
	return _plist;
}

-(FERAlerts *)alert{
	if (_alert==nil) {
		_alert=[[FERAlerts alloc]init];
	}
	return _alert;
}

-(void)configurePopover{
	[self.infoButton addTarget:self action:@selector(showPopover) forControlEvents:UIControlEventTouchUpInside];
	
	self.shouldHidePopOver = YES;
}

- (void)showPopover{
	FERInfoViewController *infoViewController = [[FERInfoViewController	alloc] init];
	infoViewController.delegate = self;
	self.infoPopover =
	[[UIPopoverController alloc] initWithContentViewController:infoViewController];
	self.infoPopover.delegate = self;
	self.infoPopover.popoverContentSize=CGSizeMake(200, 100);
	[self.infoPopover presentPopoverFromRect:self.infoButton.frame
																				inView:self.view
											permittedArrowDirections:UIPopoverArrowDirectionUp | UIPopoverArrowDirectionDown
																			animated:YES];
}

#pragma mark - FERInfoViewController

- (void)startedEditing{
	self.shouldHidePopOver = NO;
}

- (void)finishedEditing{
	self.shouldHidePopOver = YES;
}

- (IBAction)infoForiPhonePressed:(id)sender {
	[self.alert alertInfo];
}

- (IBAction)signupPressed:(id)sender {
	
	if ([self checkPasswordMach]) {
		[self saveUser];
		[self signUpUser:self.theUser];
	}
	
}

-(BOOL)checkPasswordMach{
	if ([self.passwordTextField.text isEqualToString:@""]) {
		[self.alert alertPasswordCannotBeBlank];
		return NO;
	}else if([self.passwordTextField.text isEqualToString:self.rePasswordTextField.text]){
		return YES;
	}
	[self.alert alertPasswordsNotMatch];
	return NO;
}

#pragma mark - User SingUp
-(void)signUpUser:(FERUser *)theUser{
	[self.firebase createUser:theUser.userMail password:theUser.userPassword withCompletionBlock:^(NSError *error) {
											if (error != nil) {
												[self.alert alertRegisterErrorMailInUse];
												NSLog(@"There was an error creating the account, %@",error);
											} else {
												[self.plist addUser:theUser];
												[self.fireManager saveUserInFirebase:theUser];
												[self.alert alertNewUserCreated];
												[self loginUser:theUser];
												NSLog(@"We created a new user account");
											}
										}];
}

- (void)saveUser{
	self.theUser.userMail = self.emailTextField.text;
	self.theUser.userPassword = self.passwordTextField.text;
	self.theUser.userNick = [self.formatHelper cleanMail:self.emailTextField.text];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
	self.emailTextField.text=[self.emailTextField.text lowercaseString];
}

#pragma mark - User LogIn
-(void)loginUser:(FERUser *)theUser{
	[self dismissViewControllerAnimated:YES completion:nil];
	[self.firebase authUser:self.emailTextField.text password:self.passwordTextField.text withCompletionBlock:^(NSError *error, FAuthData *authData) {
	
								if (error != nil) {
									if ([[error.userInfo valueForKey:@"NSLocalizedDescription"] containsString:@"NETWORK_ERROR"]) {
										[self.alert alertSigninNetworkError];
									}
									[self.alert alertError];
									NSLog(@"There was an error logging in to this account: %@",error);
								} else {
									theUser.userMail=self.emailTextField.text;
									theUser.userPassword=self.passwordTextField.text;
									theUser.userNick = [self.formatHelper cleanMail:self.emailTextField.text];
									[self.plist addUser:theUser];
									NSLog(@"We are now logged in");
								}
							}];
}



@end
