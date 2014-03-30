//
//  DiabloButton.m
//  Diablo3HeroViewer
//
//  Created by Remy Gratwohl on 3/29/2014.
//  Copyright (c) 2014 Remy Gratwohl. All rights reserved.
//

#import "DiabloButton.h"

@implementation DiabloButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //General Declarations
    UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    
    //Drawing the Rounded Rectangle
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0,0,150,30) cornerRadius:6];

    [color setFill];
    [roundedRectanglePath fill];
    [[UIColor blackColor] setStroke];
    roundedRectanglePath.lineWidth = 0.5;
    [roundedRectanglePath stroke];
    
}


@end
