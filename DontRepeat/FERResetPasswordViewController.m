//
//  FERResetPasswordViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERResetPasswordViewController.h"

#import <FirebaseSimpleLogin/FirebaseSimpleLogin.h>

@interface FERResetPasswordViewController ()

@property (nonatomic,strong)FirebaseSimpleLogin *authClient;

@end

@implementation FERResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(FirebaseSimpleLogin *)authClient{
	if (_authClient==nil) {
		_authClient=[[FirebaseSimpleLogin alloc]init];
	}
	return _authClient;
}

- (IBAction)resetPressed:(id)sender {

	[self.authClient sendPasswordResetForEmail:self.emailTextField.text andCompletionBlock:^(NSError *error, BOOL success) {
		if (error != nil) {
			[self alertResetPasswordError];
		} else {
			[self alertResetPasswordSuccess];
			[self dismissViewControllerAnimated:YES completion:nil];
		}
		
	}];

}

-(void)alertResetPasswordError{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset Password Error"
																									message:@"There was an error sending your password, try again later"
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
}

-(void)alertResetPasswordSuccess{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reset Password Succeeded"
																									message:@"Check your mail inbox in order to receive the password"
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
