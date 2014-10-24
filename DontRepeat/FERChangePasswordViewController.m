//
//  FERChangePasswordViewController.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERChangePasswordViewController.h"
#import "FERAlerts.h"
#import "KBKeyboardHandler.h"

#import <Firebase/Firebase.h>

//NSString *const FERFireBaseURL = @"https://dontrepeat.firebaseio.com/";

@interface FERChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *theNewPasswordTextField;
@property (nonatomic,strong)Firebase *firebase;
@property (nonatomic,strong)FERAlerts *alert;
@end

@implementation FERChangePasswordViewController{
	KBKeyboardHandler *keyboard;
}

- (void)viewDidLoad {
  [super viewDidLoad];
	[self initKeyBoard];
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

-(void)initKeyBoard{
	keyboard = [[KBKeyboardHandler alloc] init];
	keyboard.delegate = self;
}

- (void)keyboardSizeChanged:(CGSize)delta
{
	// Resize / reposition your views here. All actions performed here
	// will appear animated.
	// delta is the difference between the previous size of the keyboard
	// and the new one.
	// For instance when the keyboard is shown,
	// delta may has width=768, height=264,
	// when the keyboard is hidden: width=-768, height=-264.
	// Use keyboard.frame.size to get the real keyboard size.
	
	// Sample:
	CGRect frame = self.view.frame;
	frame.size.height -= delta.height;
	self.view.frame = frame;
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
