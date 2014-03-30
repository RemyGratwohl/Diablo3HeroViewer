//
//  Diablo3Hero.h
//  Diablo3HeroViewer
//
//  Created by Remy Gratwohl on 3/29/2014.
//  Copyright (c) 2014 Remy Gratwohl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Diablo3Hero : NSObject

@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *level;
@property(strong,nonatomic) NSString *classType;
@property(strong,nonatomic) NSString *gender;
@property                   BOOL *isHardcore;

@end
