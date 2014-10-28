//
//  FERChangePasswordViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERChangePasswordViewController.h"
#import "FERAlerts.h"

#import <Firebase/Firebase.h>

@interface FERChangePasswordViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *theNewPasswordTextField;
@property (nonatomic,strong)Firebase *firebase;
@property (nonatomic,strong)FERAlerts *alert;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@end

@implementation FERChangePasswordViewController

- (void)viewDidLoad {
  [super viewDidLoad];
	self.emailTextField.delegate=self;
	self.theNewPasswordTextField.delegate=self;
}

-(Firebase *)firebase{
	if (_firebase==nil) {
		_firebase=[[Firebase alloc]initWithUrl:FERFireBaseURL];
	}
	return _firebase;
}

-(FERAlerts *)alert{
	if (_alert==nil) {
		_alert=[[FERAlerts alloc]init];
	}
	return _alert;
}


- (IBAction)changePressed:(id)sender {
	[self.firebase changePasswordForUser:self.emailTextField.text
															 fromOld:self.oldPasswordTextField.text
																 toNew:self.theNewPasswordTextField.text
									 withCompletionBlock:^(NSError *error) {
		if (error != nil) {
			[self.alert alertChangePasswordError];
		} else {
			[self.alert alertChangePasswordSuccess];
			[self.navigationController popViewControllerAnimated:YES];
		}
	}];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}		

-(void)textFieldDidEndEditing:(UITextField *)textField{
	self.emailTextField.text=[self.emailTextField.text lowercaseString];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	if (textField.tag==3) {//newpasswordTextField
		[self.changeButton sendActionsForControlEvents:UIControlEventTouchUpInside];
		return YES;
	}
	return NO;
}



@end
