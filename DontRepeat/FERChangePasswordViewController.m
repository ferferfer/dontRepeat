//
//  FERChangePasswordViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERChangePasswordViewController.h"

#import <FirebaseSimpleLogin/FirebaseSimpleLogin.h>

@interface FERChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *theNewPasswordTextField;
@property (nonatomic,strong)FirebaseSimpleLogin *authClient;
@end

@implementation FERChangePasswordViewController

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

- (IBAction)changePressed:(id)sender {
	[self.authClient changePasswordForEmail:self.emailTextField.text
															oldPassword:self.oldPasswordTextField.text
															newPassword:self.theNewPasswordTextField.text
													completionBlock:^(NSError *error, BOOL success) {
		if (error != nil) {
			[self alertChangePasswordError];
		} else {
			[self alertChangePasswordSuccess];
			[self dismissViewControllerAnimated:YES completion:nil];
		}
	}];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}		

-(void)alertChangePasswordError{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Change Password Error"
																									message:@"There was an error changing your password, try again later"
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
}

-(void)alertChangePasswordSuccess{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Change Password Succeeded"
																									message:@"Now you can log with your new password"
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
