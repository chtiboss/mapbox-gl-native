#import "NSArray+MGLStyleAttributeAdditions.h"

#import "NSArray+MGLStyleAttributeAdditions_Private.hpp"
#import "MGLStyleAttributeValue_Private.hpp"

#include <array>

@interface  NSArray(Private) <MGLStyleAttributeValue_Private>
@end

@implementation NSArray (MGLStyleAttributeAdditions)

- (mbgl::style::PropertyValue<std::array<float, 2>>)mbgl_offsetPropertyValue
{
    NSAssert(self.count == 2, @"Offset must contain 2 values (dx, dy)");
    NSNumber *dx = self[0];
    NSNumber *dy = self[1];
    return {{dx.floatValue, dy.floatValue}};
}

- (mbgl::style::PropertyValue<std::array<float, 4> >)mbgl_paddingPropertyValue
{
    NSAssert(self.count == 4, @"Padding must contain 4 values (top, left, bottom & right)");
    NSNumber *top = self[0];
    NSNumber *left = self[1];
    NSNumber *bottom = self[2];
    NSNumber *right = self[3];
    return {{top.floatValue, left.floatValue, bottom.floatValue, right.floatValue}};
}

- (mbgl::style::PropertyValue<std::vector<std::string> >)mbgl_stringArrayPropertyValue
{
    std::vector<std::string>fonts;
    
    for (NSString *font in self) {
        fonts.emplace_back(font.UTF8String);
    }
    
    return {{fonts}};
}

- (mbgl::style::PropertyValue<std::vector<float> >)mbgl_numberArrayPropertyValue
{
    std::vector<float>values;
    
    for (NSNumber *n in self) {
        values.emplace_back(n.floatValue);
    }
    
    return {{values}};
}

+ (NSArray *)mbgl_offsetPropertyValue:(mbgl::style::PropertyValue<std::array<float, 2> >)propertyValue
{
#warning Figure out if property value is undefined, constant or a function.
    std::array<float, 2> offset = propertyValue.asConstant();
    return @[@(offset[0]), @(offset[1])];
}

+ (NSArray *)mbgl_paddingPropertyValue:(mbgl::style::PropertyValue<std::array<float, 4> >)propertyValue
{
#warning Figure out if property value is undefined, constant or a function.
    std::array<float, 4> padding = propertyValue.asConstant();
    return @[@(padding[0]), @(padding[1]), @(padding[2]), @(padding[3])];
}

+ (NSArray *)mbgl_stringArrayPropertyValue:(mbgl::style::PropertyValue<std::vector<std::string> >)propertyValue
{
#warning Figure out if property value is undefined, constant or a function.
    std::vector<std::string> fonts = propertyValue.asConstant();
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:fonts.size()];
    for (auto str : fonts) {
        [array addObject:[NSString stringWithUTF8String:str.c_str()]];
    }
    return array;
}

+ (NSArray *)mbgl_numberArrayPropertyValue:(mbgl::style::PropertyValue<std::vector<float> >)propertyValue
{
#warning Figure out if property value is undefined, constant or a function.
    std::vector<float> values = propertyValue.asConstant();
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:values.size()];
    for (auto value : values) {
        [array addObject:@(value)];
    }
    return array;
}

@end
