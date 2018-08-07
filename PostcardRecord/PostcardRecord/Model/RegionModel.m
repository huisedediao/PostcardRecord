//
//  RegionModel.m
//  PostcardRecord
//
//  Created by xxb on 2018/8/6.
//  Copyright © 2018年 xxb. All rights reserved.
//

#import "RegionModel.h"

@implementation RegionModel
- (void)encodeWithCoder:(NSCoder *)encoder{
    NSArray *allPropertyName = [[self class] getAllPropertyName];
    for (NSString *key in allPropertyName)
    {
        [encoder encodeObject:[self valueForKeyPath:key] forKey:key];
    }
}

- (instancetype)initWithCoder:(NSCoder *)decoder{
    NSArray *allPropertyName = [[self class] getAllPropertyName];
    for (NSString *key in allPropertyName)
    {
        id value = [decoder decodeObjectForKey:key];
        [self setValue:value forKeyPath:key];
    }
    return self;
}

+ (NSMutableArray *)getAllPropertyName
{
    NSMutableArray *arrM_property = [NSMutableArray new];
    
    NSMutableArray *arrM_allClass = [NSMutableArray new];
    Class tempClass = [self class];
    while ([NSStringFromClass(tempClass) isEqualToString:NSStringFromClass([NSObject class])] == NO)
    {
        [arrM_allClass addObject:NSStringFromClass(tempClass)];
        tempClass = [tempClass superclass];
    }
    
    for (NSString *className in arrM_allClass)
    {
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(NSClassFromString(className), &count);
        for (int i =0; i < count; i ++)
        {
            objc_property_t property = properties[i];
            const char *name = property_getName(property);
            NSString *key = [NSString stringWithUTF8String:name];
            [arrM_property addObject:key];
        }
    }

    return arrM_property;
}
@end
