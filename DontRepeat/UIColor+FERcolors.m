//
//  UIColor+FERcolors.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 30/09/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "UIColor+FERcolors.h"

@implementation UIColor (FERcolors)

+ (UIColor *)appBeigeColor{
	return [UIColor colorWithRed:242.0f/255.0f green:230.0f/255.0f blue:199.0f/255.0f alpha:1];
}

+ (UIColor *)appPolaroidTheme{
	UIImage	*image =[UIImage imageNamed:@"themePolaroid"];
	return [UIColor colorWithPatternImage:image];
}

@end
