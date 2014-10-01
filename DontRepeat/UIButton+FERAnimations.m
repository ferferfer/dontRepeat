//
//  UIButton+FERAnimations.m
//  DontRepeat
//
//  Created by Fernando Garcia Corrochano on 1/10/14.
//  Copyright (c) 2014 FernandoGarciaCorrochano. All rights reserved.
//

#import "UIButton+FERAnimations.h"

@implementation UIButton (FERAnimations)

-(void)shakeAnimate{
	CAKeyframeAnimation * anim = [ CAKeyframeAnimation animationWithKeyPath:@"transform" ] ;
	anim.values = @[ [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-5.0f, 0.0f, 0.0f) ], [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(5.0f, 0.0f, 0.0f) ] ] ;
	anim.autoreverses = YES ;
	anim.repeatCount = 2.0f ;
	anim.duration = 0.07f ;
	[self.layer addAnimation:anim forKey:nil ] ;
}

@end
