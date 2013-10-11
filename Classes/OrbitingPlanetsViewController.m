//
//  OrbitingPlanetsViewController.m
//  CALayerAnimTest
//
//  Created by Michael Nachbaur on 10-11-28.
//  Copyright 2010 Decaf Ninja Software. All rights reserved.
//

#import "OrbitingPlanetsViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation OrbitingPlanetsViewController

-(NSArray *)createAnimationOfCirlce:(NSInteger *)radius
                    borderWidth:(NSInteger *) borderWidth
                    DotWidth:(NSInteger *) dotWidth
{
    CALayer *orbit1 = [self createOrbit:radius borderWidth:borderWidth];
    
	CALayer *planet1 = [self createDot:dotWidth  position:radius];
    
	[orbit1 addSublayer:planet1];

	CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	anim1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	anim1.fromValue = [NSNumber numberWithFloat:0];
	anim1.toValue = [NSNumber numberWithFloat:((360*M_PI)/180 )];
	anim1.repeatCount = HUGE_VALF;
	anim1.duration = 8.0;
	[orbit1 addAnimation:anim1 forKey:@"transform"];
    
	[self.view.layer addSublayer:orbit1];
    NSArray *returnObj = [[NSArray alloc] initWithObjects:orbit1 ,planet1, nil];
    return returnObj;
}

-(CALayer *)createOrbit: (NSInteger *) radius
       borderWidth: (NSInteger *)borderWidth
{
	// Orbit #1
    int radius_int = radius;
    int border_int  = borderWidth;
	CALayer *orbit1 = [CALayer layer];
	orbit1.bounds = CGRectMake(0, 0, radius_int*2, radius_int*2);
	orbit1.position = self.view.center;
	orbit1.cornerRadius = radius_int;
	orbit1.borderColor = [UIColor redColor].CGColor;
	orbit1.borderWidth = border_int;
	
    return orbit1;
    
}
-(CALayer *)createDot: (NSInteger *) radius
             position:(NSInteger *)position
{
    int radius_int = radius;
    int position_int = position;
	CALayer *planet1 = [CALayer layer];
	planet1.bounds = CGRectMake(0, 0, radius_int*2, radius_int*2);
	planet1.position = CGPointMake(position_int,0);
	planet1.cornerRadius = radius_int;
	planet1.backgroundColor = [UIColor redColor].CGColor;
    return planet1;
}

- (void)loadView {
	[super loadView];
	self.view.backgroundColor = [UIColor blackColor];

	// Orbit #1
    
    NSArray *returnObject = [self createAnimationOfCirlce:100 borderWidth:2 DotWidth:10];
    
    CALayer *planet1 = [returnObject lastObject];
    
    CALayer *orbit1 = [returnObject objectAtIndex:0];
	
    
    NSArray *returnObject2 = [self createAnimationOfCirlce:60 borderWidth:2 DotWidth:10];
    
    CALayer *planet2 = [returnObject2 lastObject];
    
    CALayer *orbit2 = [returnObject2 objectAtIndex:0];


	[orbit1 addSublayer:orbit2];
	
	// Orbit #3
	CALayer *orbit3 = [CALayer layer];
	orbit3.bounds = CGRectMake(0, 0, 72, 72);
	orbit3.position = planet2.position;
	orbit3.cornerRadius = 36;
	orbit3.borderColor = [UIColor grayColor].CGColor;
	orbit3.borderWidth = 1.5;
	
	CALayer *planet3 = [CALayer layer];
	planet3.bounds = CGRectMake(0, 0, 12, 12);
	planet3.position = CGPointMake(36, 0);
	planet3.cornerRadius = 6;
	planet3.backgroundColor = [UIColor grayColor].CGColor;
	[orbit3 addSublayer:planet3];
	
	CABasicAnimation *anim3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	anim3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	anim3.fromValue = [NSNumber numberWithFloat:0];
	anim3.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
	anim3.repeatCount = HUGE_VALF;
	anim3.duration = 2.0;
	[orbit3 addAnimation:anim3 forKey:@"transform"];
	
	[orbit2 addSublayer:orbit3];

    // Orbit #4
	CALayer *orbit4 = [CALayer layer];
	orbit4.bounds = CGRectMake(0, 0, 72, 72);
	orbit4.position = planet3.position;
	orbit4.cornerRadius = 36;
	orbit4.borderColor = [UIColor grayColor].CGColor;
	orbit4.borderWidth = 1.5;
	
	CALayer *planet4 = [CALayer layer];
	planet4.bounds = CGRectMake(0, 0, 12, 12);
	planet4.position = CGPointMake(36, 0);
	planet4.cornerRadius = 6;
	planet4.backgroundColor = [UIColor grayColor].CGColor;
	[orbit3 addSublayer:planet4];
	
	CABasicAnimation *anim4 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	anim4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	anim4.fromValue = [NSNumber numberWithFloat:0];
	anim4.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
	anim4.repeatCount = HUGE_VALF;
	anim4.duration = 2.0;
	[orbit4 addAnimation:anim4 forKey:@"transform"];
	
	[orbit3 addSublayer:orbit4];
}

@end
