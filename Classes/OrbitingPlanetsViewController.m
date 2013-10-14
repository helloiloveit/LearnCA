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

-(NSArray *)createAnimationOfCirlceFirst:(NSInteger *)radius
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
-(CALayer *)createOrbit2: (NSInteger *) radius
             borderWidth: (NSInteger *)borderWidth
             dotPosition: (CALayer *)dotPosition
{
	// Orbit #1
    int radius_int = radius;
    int border_int  = borderWidth;
	CALayer *orbit1 = [CALayer layer];
	orbit1.bounds = CGRectMake(0, 0, radius_int*2, radius_int*2);
	orbit1.position = dotPosition.position;
	orbit1.cornerRadius = radius_int;
	orbit1.borderColor = [UIColor clearColor].CGColor;
	orbit1.borderWidth = border_int;
	
    return orbit1;
}

-(NSArray *)createAnimationOfCirlce:(NSInteger *)radius
                             borderWidth:(NSInteger *) borderWidth
                                DotWidth:(NSInteger *) dotWidth
                            dotPosition:(CALayer *)dotPosition
{

    CALayer *orbit1 = [self createOrbit2:radius borderWidth:borderWidth dotPosition:dotPosition];
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
	orbit1.borderColor = [UIColor clearColor].CGColor;
	orbit1.borderWidth = border_int;
	
    return orbit1;
    
}

-(UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 4.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
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
	planet1.backgroundColor = [self randomColor].CGColor;
    return planet1;
}

- (void)loadView {
	[super loadView];
	self.view.backgroundColor = [UIColor blackColor];


    NSArray *returnObject = [self createAnimationOfCirlceFirst:80 borderWidth:2 DotWidth:40];
    
    CALayer *planet1 = [returnObject lastObject];
    
    CALayer *orbit1 = [returnObject objectAtIndex:0];
	
    
    NSArray *returnObject2 = [self createAnimationOfCirlce:80 borderWidth:2 DotWidth:10 dotPosition:planet1];
    
    CALayer *planet2 = [returnObject2 lastObject];
    
    CALayer *orbit2 = [returnObject2 objectAtIndex:0];
    
    
	[orbit1 addSublayer:orbit2];
    
	// Orbit #1
    for (int i=0; i<8; i++) {
        NSArray *returnObject2 = [self createAnimationOfCirlce:80 borderWidth:2 DotWidth:40 dotPosition:planet1];
        
        CALayer *planet2 = [returnObject2 lastObject];
        
        CALayer *orbit2 = [returnObject2 objectAtIndex:0];
        
        
        [orbit1 addSublayer:orbit2];
        
        NSArray *returnObject3 = [self createAnimationOfCirlce:80 borderWidth:2 DotWidth:40 dotPosition:planet2];
        
        CALayer *planet3 = [returnObject3 lastObject];
        
        CALayer *orbit3 = [returnObject3 objectAtIndex:0];
        
        
        [orbit2 addSublayer:orbit3];
        
        planet1 = planet3;
        orbit1 = orbit3;
    }
    

}

@end
