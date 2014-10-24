//
//  FERChangePasswordViewController.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 20/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBKeyboardHandlerDelegate.h"

@interface FERChangePasswordViewController : UIViewController<KBKeyboardHandlerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end
