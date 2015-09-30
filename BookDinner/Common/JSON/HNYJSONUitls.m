//
//  HNYJSONUitls.m
//  Demo
//
//  Created by chenzq on 5/13/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "HNYJSONUitls.h"
#import "HNTModel.h"
#import "HNYModel.h"
#import <objc/runtime.h>

@implementation HNYJSONUitls

+ (void)mappingDictionary:(NSDictionary *)dictionary toObject:(id)object{
    if ([dictionary isKindOfClass:[NSNull class]] || [object isKindOfClass:[NSNull class]])
        return;
    if (dictionary == nil || object == nil)
        return;

    NSArray *keyAry = [dictionary allKeys];
    if ([keyAry isKindOfClass:[NSArray class]]) {
        for (NSString *string in keyAry) {
            if ([object respondsToSelector:NSSelectorFromString(string)]) {
                [object setValue:[dictionary objectForKey:string] forKey:string];
            }
        }
    }
}


+ (id)mappingDictionary:(NSDictionary *)dictionary toObjectWithClassName:(NSString *)className{
    id object = [[NSClassFromString(className) alloc] init];
    [HNYJSONUitls mappingDictionary:dictionary toObject:object];
    return object;
}

+ (NSMutableArray *)mappingDicAry:(NSArray *)DicAry toObjectAryWithClassName:(NSString *)className{
    NSMutableArray *array = [NSMutableArray array];
    for (id dic in DicAry) {
        id object = [HNYJSONUitls mappingDictionary:dic toObjectWithClassName:className];
        [array addObject:object];
    }
    return array;
}

+ (NSDictionary *)getDictionaryFromObject:(id)object{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    unsigned int outCount = 0;
    //获取属性列表
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    
    for (int i = 0 ; i < outCount; i++) {
        //根据属性取值
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id value = [object valueForKey:propertyName];
        
        if ([propertyName isKindOfClass:[NSString class]] && value != nil && ![value isKindOfClass:[NSNull class]]) {
            
            if ([value isKindOfClass:[NSDate class]]) {
                NSDateFormatter *formater = [[NSDateFormatter alloc] init];
                [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                [dictionary setValue:[formater stringFromDate:value] forKey:propertyName];
            }
            
            else if ([value isKindOfClass:[HNTModel class]]) {
                [dictionary setValue:[HNYJSONUitls getDictionaryFromObject:value] forKey:propertyName];
            }

            else if ([value isKindOfClass:[NSArray class]]){
                NSMutableArray *array = [NSMutableArray array];
                
                for (id object in value) {
                    if ([object isKindOfClass:[HNYModel class]])
                        [array addObject:[HNYJSONUitls getDictionaryFromObject:object]];
                    else
                        [array addObject:object];
                    [dictionary setValue:array forKey:propertyName];
                }
                [dictionary setValue:array forKey:propertyName];
            }
            else if ([value isKindOfClass:[NSDictionary class]]){
                [dictionary setValue:value forKey:propertyName];
            }
            else
                [dictionary setValue:value forKey:propertyName];
        }
    }
    return dictionary;
}



@end
