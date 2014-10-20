//
//  FERChangePasswordViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERChangePasswordViewController.h"

#import <Firebase/Firebase.h>

//NSString *const FERFireBaseURL = @"https://dontrepeat.firebaseio.com/";

@interface FERChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *theNewPasswordTextField;
@property (nonatomic,strong)Firebase *firebase;
@end

@implementation FERChangePasswordViewController

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

- (IBAction)changePressed:(id)sender {
	[self.firebase changePasswordForUser:self.emailTextField.text
															 fromOld:self.oldPasswordTextField.text
																 toNew:self.theNewPasswordTextField.text
									 withCompletionBlock:^(NSError *error) {
		if (error != nil) {
			[self alertChangePasswordError];
		} else {
			[self alertChangePasswordSuccess];
			[self.navigationController popViewControllerAnimated:YES];
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
