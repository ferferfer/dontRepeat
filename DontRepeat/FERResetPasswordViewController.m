//
//  FERResetPasswordViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERResetPasswordViewController.h"

#import <Firebase/Firebase.h>

//NSString *const FERFireBaseURL = @"https://dontrepeat.firebaseio.com/";

@interface FERResetPasswordViewController ()

@property (nonatomic,strong)Firebase *firebase;

@end

@implementation FERResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(Firebase *)firebase{
	if (_firebase==nil) {
		_firebase=[[Firebase alloc]initWithUrl:FERFireBaseURL];
	}
	return _firebase;
}

- (IBAction)resetPressed:(id)sender {
	
	[self.firebase resetPasswordForUser:self.emailTextField.text withCompletionBlock:^(NSError *error) {
		if (error != nil) {
			[self alertResetPasswordError];
		} else {
			[self alertResetPasswordSuccess];
			[self.navigationController popViewControllerAnimated:YES];
		}
		
	}];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
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
