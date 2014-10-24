//
//  KBKeyboardHandler.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 24/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//
#import "KBKeyboardHandler.h"
#import "KBKeyboardHandlerDelegate.h"

@implementation KBKeyboardHandler

- (id)init
{
	self = [super init];
	if (self)
		{
		[[NSNotificationCenter defaultCenter] addObserver:self
																						 selector:@selector(keyboardWillShow:)
																								 name:UIKeyboardWillShowNotification
																							 object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
																						 selector:@selector(keyboardWillHide:)
																								 name:UIKeyboardWillHideNotification
																							 object:nil];
		}
	
	return self;
}


@synthesize delegate;
@synthesize frame;

- (void)keyboardWillShow:(NSNotification *)notification
{
	CGRect oldFrame = self.frame;
	[self retrieveFrameFromNotification:notification];
	
	if (oldFrame.size.height != self.frame.size.height)
		{
		CGSize delta = CGSizeMake(self.frame.size.width - oldFrame.size.width,
															self.frame.size.height - oldFrame.size.height);
		if (self.delegate)
			[self notifySizeChanged:delta notification:notification];
		}
}

- (void)keyboardWillHide:(NSNotification *)notification
{
	if (self.frame.size.height > 0.0)
		{
		[self retrieveFrameFromNotification:notification];
		CGSize delta = CGSizeMake(-self.frame.size.width, -self.frame.size.height);
		
		if (self.delegate)
			[self notifySizeChanged:delta notification:notification];
		}
	
	self.frame = CGRectZero;
}

- (void)retrieveFrameFromNotification:(NSNotification *)notification
{
	CGRect keyboardRect;
	[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardRect];
	self.frame = [[UIApplication sharedApplication].keyWindow.rootViewController.view convertRect:keyboardRect fromView:nil];
}

- (void)notifySizeChanged:(CGSize)delta notification:(NSNotification *)notification
{
	NSDictionary *info = [notification userInfo];
	
	UIViewAnimationCurve curve;
	[[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
	
	NSTimeInterval duration;
	[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&duration];
	
	void (^action)(void) = ^{
		[self.delegate keyboardSizeChanged:delta];
	};
	
	[UIView animateWithDuration:duration
									 animations:action
									 completion:nil];
}

@end