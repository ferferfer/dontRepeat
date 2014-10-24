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

//NSString *const FERFireBaseURL = @"https://dontrepeat.firebaseio.com/";

@interface FERChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *theNewPasswordTextField;
@property (nonatomic,strong)Firebase *firebase;
@property (nonatomic,strong)FERAlerts *alert;
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


@end
