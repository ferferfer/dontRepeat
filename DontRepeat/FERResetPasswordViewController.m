//
//  FERResetPasswordViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERResetPasswordViewController.h"
#import "FERAlerts.h"

#import <Firebase/Firebase.h>

//NSString *const FERFireBaseURL = @"https://dontrepeat.firebaseio.com/";

@interface FERResetPasswordViewController ()

@property (nonatomic,strong)Firebase *firebase;
@property (nonatomic,strong)FERAlerts *alert;

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

-(FERAlerts *)alert{
	if (_alert==nil) {
		_alert=[[FERAlerts alloc]init];
	}
	return _alert;
}


- (IBAction)resetPressed:(id)sender {
	
	[self.firebase resetPasswordForUser:self.emailTextField.text withCompletionBlock:^(NSError *error) {
		if (error != nil) {
			[self.alert alertResetPasswordError];
		} else {
			[self.alert alertResetPasswordSuccess];
			[self.navigationController popViewControllerAnimated:YES];
		}
		
	}];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
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
