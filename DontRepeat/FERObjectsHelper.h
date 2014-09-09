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

- (void)titlePressed:(FERDontRepeatObjects *)obj;
- (void)datePressed:(FERDontRepeatObjects *)obj;
- (void)descriptionPressed:(FERDontRepeatObjects *)obj;
- (void)picturePressed:(FERDontRepeatObjects *)obj;
- (void)originalPosition:(FERDontRepeatObjects *)obj;
- (void)hideFields:(FERDontRepeatObjects *)obj;


@end
