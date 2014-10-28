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
#import "FERAlerts.h"

#import <Firebase/Firebase.h>

@interface FERLoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic,strong)FERUser *theUser;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic,strong)FERPlistManager *plist;
@property	(nonatomic,strong)Firebase* firebase;
@property	(nonatomic,strong)FERFormatHelper *formatHelper;
@property	(nonatomic,strong)FERAlerts *alert;

@end

@implementation FERLoginViewController

-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad{
	[super viewDidLoad];
	self.emailTextField.delegate=self;
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


-(FERAlerts *)alert{
	if (_alert==nil) {
		_alert=[[FERAlerts alloc]init];
	}
	return _alert;
}


-(void)loadUserTextFields{
	FERUser *userText=[self.plist loadUser];
	self.emailTextField.text=userText.userMail;
	self.passwordTextField.text=userText.userPassword;
	self.passwordTextField.secureTextEntry = YES;
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
	[self.firebase authUser:self.emailTextField.text password:self.passwordTextField.text withCompletionBlock:^(NSError *error, FAuthData *authData) {
		if (error != nil) {
			NSString *errorString=[error.userInfo valueForKey:@"NSLocalizedDescription"];
			if ([errorString rangeOfString:@"NETWORK_ERROR"].location != NSNotFound) {
				[self showAlertWithTitle:@"Network Error" andMessage:@"You need internet access to login"];
			}else	if (![self tryToLoginWithPlist]) {
				[self showAlertWithTitle:@"Register Error" andMessage:@"User Name or password incorect"];
				NSLog(@"There was an error logging in to this account: %@",error);
			}
			
		} else {
			[self.plist addUser:theUser];
			NSLog(@"We are now authed");
		}
	}];
}


-(BOOL)tryToLoginWithPlist{
	FERUser *userText=[self.plist loadUser];
	if ([self.emailTextField.text isEqualToString:userText.userMail] &&
			[self.passwordTextField.text isEqualToString:userText.userPassword]) {
		NSLog(@"We are now logged in with plist");
		return YES;
	}
	return NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
	self.emailTextField.text=[self.emailTextField.text lowercaseString];
}

- (void)saveUser{
	self.theUser.userMail = self.emailTextField.text;
	self.theUser.userPassword = self.passwordTextField.text;
	self.theUser.userNick = [self.formatHelper cleanMail:self.emailTextField.text];
}

-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message{
	UIAlertView *alert=[self.alert alertMakerWithTitle:title
																					andMessage:message];
	alert.delegate=self;
	[alert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
	[self stop];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	
	if ([segue.identifier isEqualToString:@"resetSegue"]) {
		FERResetPasswordViewController *rpvc=[segue destinationViewController];
		rpvc.emailTextField.text=self.emailTextField.text;
	}
	if ([segue.identifier isEqualToString:@"changeSegue"]) {
		FERChangePasswordViewController *cpvc=[segue destinationViewController];
		cpvc.emailTextField.text=self.emailTextField.text;
	}
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
}


@end
