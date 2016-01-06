//
//  SKTextureAtlas+JY.m
//  04-mole
//
//  Created by qingyun on 16/1/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SKTextureAtlas+JY.h"
#import "Common.h"
@implementation SKTextureAtlas (JY)

+ (SKTextureAtlas *)atlasWithName:(NSString *)atlasName
{
    if (IS_IPAD) {
        atlasName = [NSString stringWithFormat:@"%@-ipad", atlasName];
    } else if (IS_IPHONE_5) {
        atlasName = [NSString stringWithFormat:@"%@-568", atlasName];
    }
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlasName] ;
    return atlas;
}


@end
