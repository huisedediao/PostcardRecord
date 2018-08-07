//
//  XBLocalizedString.h
//  XBMultithreadingTest
//
//  Created by xxb on 2016/12/21.
//  Copyright © 2016年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBLocalizedString : NSObject
 
#define XBLocalizedString(key)   \
({\
NSString *result = [XBLocalizedString localizedStrFromBundleName:@"AnXin_language" forKey:key];\
result;\
})

+ (NSString *)localizedStrFromBundleName:(NSString *)bundleName forKey:(NSString *)key;
    
+ (NSString *)autoLocalizedStrFromBundleName:(NSString *)bundleName forKey:(NSString *)key;
    
@end
