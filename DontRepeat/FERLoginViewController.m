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

#import <Firebase/Firebase.h>
#import <FirebaseSimpleLogin/FirebaseSimpleLogin.h>

@interface FERLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *buttonSegue;
@property (nonatomic,strong)FERUser *theUser;
@property (nonatomic,strong)FERPlistManager *plist;
@property	(nonatomic,strong)FirebaseSimpleLogin* authClient;
@property	(nonatomic,strong)Firebase* ref;
@property	(nonatomic,strong)FERFirebaseManager* fireManager;

@end

@implementation FERLoginViewController

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

-(FERFirebaseManager *)fireManager{
	if (_fireManager==nil) {
		_fireManager=[[FERFirebaseManager alloc]init];
	}
	return _fireManager;
}

- (void)saveUser{
	self.theUser.userMail = self.email.text;
	self.theUser.userPassword = self.password.text;
}

-(void)loadUserTextFields{
	FERUser *userText=[self.plist loadUser];
	self.email.text=userText.userMail;
	self.password.text=userText.userPassword;
	self.navigationController.navigationBarHidden=YES;
	self.password.secureTextEntry = YES;
}


- (IBAction)loginPressed:(id)sender {
	[self saveUser];
	[self loginUser:self.theUser];
}

- (IBAction)singUpPressed:(id)sender {
	[self saveUser];
	[self singUpUser:self.theUser];
}

#pragma mark - User SingUp
-(void)singUpUser:(FERUser *)theUser{
	[self.authClient createUserWithEmail:theUser.userMail password:theUser.userPassword
										andCompletionBlock:^(NSError* error, FAUser* user) {
											if (error != nil) {
												[self alertRegisterErrorMailInUse];
												NSLog(@"There was an error creating the account, %@",error);
											} else {
												[self.fireManager saveUserInFirebase:theUser];
												[self alertNewUserCreated];
												NSLog(@"We created a new user account");
											}
										}];
}

#pragma mark - User LogIn
-(void)loginUser:(FERUser *)theUser{
	[self dismissViewControllerAnimated:YES completion:nil];
	[self.authClient loginWithEmail:self.email.text andPassword:self.password.text
							withCompletionBlock:^(NSError* error, FAUser* user) {
								if (error != nil) {
									[self alertRegisterError];
									NSLog(@"There was an error logging in to this account");
								} else {									
									theUser.userMail=self.email.text;
									theUser.userPassword=self.password.text;
									[self.plist addUser:theUser];
									
									[self.buttonSegue sendActionsForControlEvents:UIControlEventTouchUpInside];
									NSLog(@"We are now logged in");// We are now logged in
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

-(void)alertRegisterError{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Error"
																									message:@"User Name or password incorect"
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
