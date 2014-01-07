//
//  VIRHelpMethods.m
//  HomeworkStaticTable
//
//  Created by Administrator on 25.12.13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "VIRHelpMethods.h"

@implementation VIRHelpMethods

- (NSString *)textFieldFormat:(UITextField* )textFieldFormat range:(NSRange)range andString:(NSString *)str {
    
    NSString *newString = [textFieldFormat.text  stringByReplacingCharactersInRange:range withString:str];
    
    NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet]invertedSet]];
    
    newString = [validComponents componentsJoinedByString:@""];
    
    static const int localNumberMaxLenght = 6;
    static const int areaCodeMaxLenght = 4;
    static const int countryCodeMaxLenght = 1;
    
    if([newString length] > localNumberMaxLenght + areaCodeMaxLenght + countryCodeMaxLenght) {
        return NO;
    }
    
    NSMutableString *resultString = [NSMutableString string];
    
    NSInteger localNumberLenght = MIN([newString length], localNumberMaxLenght);
    
    if(localNumberLenght > 0) {
        
        NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLenght];
        
        [resultString appendString:number];
        
        if([resultString length] > 2) {
            [resultString insertString:@"-" atIndex:2];
        }
        
        if([resultString length] > 5) {
            [resultString insertString:@"-" atIndex:5];
        }
    }
    
    if([newString length] > localNumberMaxLenght) {
        
        NSInteger areaCodeLenght = MIN([newString length] - localNumberMaxLenght, areaCodeMaxLenght);
        
        NSRange areaRange = NSMakeRange((int)[newString length] - localNumberMaxLenght - areaCodeLenght, areaCodeLenght);
        
        NSString *area = [newString substringWithRange:areaRange];
        
        
        area = [NSString stringWithFormat:@"(%@) ", area];
        
        [resultString insertString:area atIndex:0];
    }
    
    
    if([newString length] > localNumberMaxLenght + areaCodeMaxLenght) {
        
        NSInteger countryCodeLenght = MIN([newString length] - localNumberMaxLenght - areaCodeMaxLenght, countryCodeMaxLenght);
        
        NSRange countryCodeRange = NSMakeRange(0, countryCodeLenght);
        
        NSString *countryCode = [newString substringWithRange:countryCodeRange];
        
        
        countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
        
        [resultString insertString:countryCode atIndex:0];
    }
    
    return resultString;
}




@end
