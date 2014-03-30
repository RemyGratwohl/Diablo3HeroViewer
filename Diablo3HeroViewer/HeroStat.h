//
//  HeroStat.h
//  Diablo3HeroViewer
//
//  Created by Remy Gratwohl on 3/30/2014.
//  Copyright (c) 2014 Remy Gratwohl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroStat : NSObject

@property(strong,atomic) NSString *name;
@property(strong,atomic) NSNumber *value;

@end
