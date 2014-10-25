//
//  FERAlerts.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 24/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "FERAlerts.h"

@implementation FERAlerts

-(void)alertRegisterError{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Error"
																									message:@"User Name or password incorect"
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
}

-(void)alertNewUserCreated{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Successful"
																									message:@"You are now logged"
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

-(void)alertError{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Error"
																									message:@"There was an error logging in to this account."
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
	
}

-(void)alertPasswordsNotMatch{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Error"
																									message:@"Passwords do not match."
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
	
}

-(void)alertPasswordCannotBeBlank{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Register Error"
																									message:@"Passwords cannot be blank."
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
	
}

-(void)alertInfo{
	UIAlertView *alert = [[UIAlertView alloc]
												initWithTitle:@"Recomendation"
												message:@"Enter a valid email for password  recovery. \nIn case you lost it ;)"
												delegate:nil
												cancelButtonTitle:@"OK"
												otherButtonTitles:nil];
	[alert show];
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

-(void)alertLoginNetworkError{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Networ Error"
																									message:@"You need internet access to login"
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
}

-(void)alertSigninNetworkError{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Networ Error"
																									message:@"You need internet access to login"
																								 delegate:nil
																				cancelButtonTitle:@"OK"
																				otherButtonTitles:nil];
	[alert show];
}

@end
