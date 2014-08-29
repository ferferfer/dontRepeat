//
//  FERLoginViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 21/08/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERLoginViewController.h"
#import "FERUser.h"
#import "FERMainCollectionView.h"
#import <Firebase/Firebase.h>
#import <FirebaseSimpleLogin/FirebaseSimpleLogin.h>


@interface FERLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *buttonSegue;
@property (nonatomic,strong)FERUser *user;

@property	(nonatomic,strong)FirebaseSimpleLogin* authClient;
@property	(nonatomic,strong)Firebase* ref;


@property (nonatomic, assign) BOOL isSingUp;
@end

@implementation FERLoginViewController

- (void)viewDidLoad{
	[super viewDidLoad];
	self.isSingUp=NO;
	// Do any additional setup after loading the view.
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

-(FERUser *)user{
	if (_user==nil) {
		_user=[[FERUser alloc]init];
		
	}
	return _user;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.view endEditing:YES];
	[self textFieldFinished:self.email];
}

- (void)textFieldFinished:(UITextField *)sender{
	self.user.userMail = self.email.text;
	self.user.userPassword = self.password.text;
}


- (IBAction)loginPressed:(id)sender {
	[self loginUser:self.user];
}

- (IBAction)singUpPressed:(id)sender {
	[self singUpUser:self.user];
}

#pragma mark - User SingUp
-(void)singUpUser:(FERUser *)user{
	[self.authClient createUserWithEmail:self.email.text password:self.password.text
										andCompletionBlock:^(NSError* error, FAUser* user) {
											if (error != nil) {
												[self alertRegisterErrorMailInUse];
												NSLog(@"There was an error creating the account");
											} else {
												[self alertNewUserCreated];
												NSLog(@"We created a new user account");
											}
										}];
}

#pragma mark - User LogIn
-(void)loginUser:(FERUser *)user{
	[self dismissViewControllerAnimated:YES completion:nil];
	[self.authClient loginWithEmail:self.email.text andPassword:self.password.text
							withCompletionBlock:^(NSError* error, FAUser* user) {
								if (error != nil) {
									[self alertRegisterError];
									NSLog(@"There was an error logging in to this account");
								} else {
									self.isSingUp=YES;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if ([segue.identifier isEqualToString:@"logInSegue"]) {
		
		if(self.isSingUp){
			self.isSingUp=NO;
		}
	}
	// Get the new view controller using [segue destinationViewController].
	// Pass the selected object to the new view controller.
}


@end
