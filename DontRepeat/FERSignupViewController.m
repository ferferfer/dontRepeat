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

#import <Firebase/Firebase.h>
#import <FirebaseSimpleLogin/FirebaseSimpleLogin.h>

@interface FERSignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *buttonSegue;
@property	(strong, nonatomic)FERUser *theUser;
@property	(nonatomic,strong)FirebaseSimpleLogin *authClient;
@property	(nonatomic,strong)Firebase *ref;
@property	(nonatomic,strong)FERFirebaseManager *fireManager;
@property	(nonatomic,strong)FERFormatHelper *formatHelper;
@property (nonatomic,strong)FERPlistManager *plist;

@end

@implementation FERSignupViewController

-(void)viewWillAppear:(BOOL)animated{
	self.navigationController.navigationBarHidden=NO;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(Firebase *)ref{
	if(_ref==nil){
		_ref = [[Firebase alloc] initWithUrl:@"https://dontrepeat.firebaseio.com/"];
	}
	return _ref;
}

-(FERUser *)theUser{
	if (_theUser==nil) {
		_theUser=[[FERUser alloc]init];
	}
	return _theUser;
}

-(FirebaseSimpleLogin *)authClient{
	if(_authClient==nil){
		_authClient = [[FirebaseSimpleLogin alloc] initWithRef:self.ref];
	}
	return _authClient;
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

- (IBAction)signupPressed:(id)sender {
	
	if ([self checkPasswordMach]) {
		[self saveUser];
		[self signUpUser:self.theUser];
	}
	
}

-(BOOL)checkPasswordMach{
	if ([self.passwordTextField.text isEqualToString:@""]) {
		[self alertPasswordCannotBeBlank];
		return NO;
	}else if([self.passwordTextField.text isEqualToString:self.rePasswordTextField.text]){
		return YES;
	}
	[self alertPasswordsNotMatch];
	return NO;
}

#pragma mark - User SingUp
-(void)signUpUser:(FERUser *)theUser{
	[self.authClient createUserWithEmail:theUser.userMail password:theUser.userPassword
										andCompletionBlock:^(NSError* error, FAUser* user) {
											if (error != nil) {
												[self alertRegisterErrorMailInUse];
												NSLog(@"There was an error creating the account, %@",error);
											} else {
												[self.plist addUser:theUser];
												[self.fireManager saveUserInFirebase:theUser];
												[self alertNewUserCreated];
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

#pragma mark - User LogIn
-(void)loginUser:(FERUser *)theUser{
	[self dismissViewControllerAnimated:YES completion:nil];
	[self.authClient loginWithEmail:self.emailTextField.text
											andPassword:self.passwordTextField.text
							withCompletionBlock:^(NSError* error, FAUser* user) {
								if (error != nil) {
									[self alertError];
									NSLog(@"There was an error logging in to this account: %@",error);
								} else {
									theUser.userMail=self.emailTextField.text;
									theUser.userPassword=self.passwordTextField.text;
									theUser.userNick = [self.formatHelper cleanMail:self.emailTextField.text];
									[self.plist addUser:theUser];
									
									[self.buttonSegue sendActionsForControlEvents:UIControlEventTouchUpInside];
									NSLog(@"We are now logged in");
								}
							}];
}

-(void)alertNewUserCreated{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Successful"
																									message:@"Now you can log in"
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
}

-(void)alertRegisterErrorMailInUse{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Error"
																									message:@"This email is allready use, try with a diferent mail."
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
	
}

-(void)alertError{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Error"
																									message:@"There was an error logging in to this account."
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
	
}

-(void)alertPasswordsNotMatch{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Error"
																									message:@"Passwords do not match."
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
	
}

-(void)alertPasswordCannotBeBlank{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Error"
																									message:@"Passwords cannot be blank."
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
	
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if ([segue.identifier isEqualToString:@"signupSegue"]) {
		FERMainCollectionView *mcv=[segue destinationViewController];
		FERUser *loggedUser=[self.plist loadUser];
		mcv.user=loggedUser;
		mcv.authClient=self.authClient;
	}
}


@end
