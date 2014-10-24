//
//  FERInfoViewController.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 24/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol FERInfoViewControllerDelegate <NSObject>

- (void)startedEditing;
- (void)finishedEditing;

@end

@interface FERInfoViewController : UIViewController

@property (nonatomic, weak) id<FERInfoViewControllerDelegate> delegate;

@end
