//
//  FERObjectsHelper.h
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 09/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FERDontRepeatObjects.h"

@interface FERObjectsHelper : NSObject

- (void)titlePressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone;
- (void)datePressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone;
- (void)descriptionPressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone;
- (void)picturePressed:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone;
- (void)originalPosition:(FERDontRepeatObjects *)obj foriPhone:(BOOL)iPhone;
- (void)hideFields:(FERDontRepeatObjects *)obj;


@end
