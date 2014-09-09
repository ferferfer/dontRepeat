//
//  FERDontRepeatViewController.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 03/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FERUser.h"
#import "DontRepeat.h"

@protocol FERDontRepeatViewControllerDelegate <NSObject>
-(void)addDontRepeat:(DontRepeat *)dontRepeat forUser:(FERUser *)user;
-(void)removeDontRepeat;
@end


@interface FERDontRepeatViewController : UIViewController

@property	(nonatomic,strong)FERUser *user;
@property	(nonatomic, weak)	id<FERDontRepeatViewControllerDelegate> delegate;

@end
