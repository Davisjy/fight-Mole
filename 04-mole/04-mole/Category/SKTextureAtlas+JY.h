//
//  SKTextureAtlas+JY.h
//  04-mole
//
//  Created by qingyun on 16/1/3.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKTextureAtlas (JY)

/**
 *  返回一个纹理集
 *
 *  @param atlasName 纹理集前缀
 */
+ (SKTextureAtlas *)atlasWithName:(NSString *)atlasName;
@end
