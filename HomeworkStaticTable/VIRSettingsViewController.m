//
//  VIRSettingsViewController.m
//  HomeworkStaticTable
//
//  Created by Administrator on 25.12.13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import "VIRSettingsViewController.h"
#import "VIRHelpMethods.h"

@interface VIRSettingsViewController ()

@end

static NSString *kSettingsLoginKey = @"login";
static NSString *kSettingsPasswordKey = @"password";
static NSString *kSettingsFirstNameKey= @"firstname";
static NSString *kSettingsLastNameKey = @"lastname";
static NSString *kSettingsAgeKey = @"age";
static NSString *kSettingsPhoneKey = @"phone";
static NSString *kSettingsEmailKey = @"email";

@implementation VIRSettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadSettings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSInteger currentTextField = [self.textFieldButtons indexOfObject:textField];
    NSInteger lastText = [self.textFieldButtons indexOfObject:[self.textFieldButtons lastObject]];
    
    if(currentTextField < [self.textFieldButtons count]) {
        if(currentTextField != lastText){
            if(currentTextField < [self.textFieldButtons count]) {
                
                UITextField *nextTextFielf = [self.textFieldButtons objectAtIndex:currentTextField + 1];
                
                [nextTextFielf becomeFirstResponder];
            }
        } else {
            [textField resignFirstResponder];
        }
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    VIRHelpMethods *helpMethods = [[VIRHelpMethods alloc] init];
  
    if([textField isEqual:[self.textFieldButtons objectAtIndex:4]]){
        
        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *component = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if([component count] > 1) {
            return NO;
        }
        
        return [textField.text length] < 2;
    }
   
    if([textField isEqual:[self.textFieldButtons objectAtIndex:5]]) {
        /*
        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *component = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if([component count] > 1) {
            return NO;
        }
        
        NSString *newString = [textField.text  stringByReplacingCharactersInRange:range withString:string];
        
        NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
        
        newString = [validComponents componentsJoinedByString:@""];

        static const int localNumberMaxLenght = 7;
        static const int areaCodeMaxLenght = 3;
        static const int countryCodeMaxLenght = 3;
        
        if([newString length] > localNumberMaxLenght + areaCodeMaxLenght + countryCodeMaxLenght) {
            return NO;
        }
        
        NSMutableString *resultString = [NSMutableString string];
        
        NSInteger localNumberLenght = MIN([newString length], localNumberMaxLenght);
        
        if(localNumberLenght > 0) {
            
            NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLenght];
            
            [resultString appendString:number];
            
            if([resultString length] > 3) {
                [resultString insertString:@"-" atIndex:3];
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
        }*/

        textField.text = [helpMethods textFieldFormat:textField range:range andString:string];
        
        return NO;
    }
    return YES;
}

#pragma mark - Action

- (IBAction)actionClearAll:(UIButton *)sender {
    
    NSString *appName = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appName];

    for(UITextField *tf in self.textFieldButtons) {
        tf.text = @"";
        [[self.textFieldButtons objectAtIndex:0] becomeFirstResponder];
    }
}

- (IBAction)actionTextChangeField:(UITextField *)sender {
    [self saveSettings];
}

- (IBAction)actionValueChangeSwitch:(id)sender {
    
    switch (self.switchButton.on) {
        case YES:
            self.clearAllButon.enabled = YES;
            break;
        case NO:
            self.clearAllButon.enabled = NO;
            break;;
    }
}

#pragma mark - Save and Load Methods
- (void)saveSettings {
    NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
    for(UITextField* tf in self.textFieldButtons) {
        switch (tf.tag) {
            case VIRSettingsLoginField:
                [userSettings setObject:tf.text forKey:kSettingsLoginKey];
                break;
            case VIRSettingsPasswordField:
                [userSettings setObject:tf.text forKey:kSettingsPasswordKey];
                break;
            case VIRSettingsFirstNameField:
                [userSettings setObject:tf.text forKey:kSettingsFirstNameKey];
                break;
            case VIRSettingsLastNameField:
                [userSettings setObject:tf.text forKey:kSettingsLastNameKey];
                break;
            case VIRSettingsAgeField:
                [userSettings setObject:tf.text forKey:kSettingsAgeKey];
                break;
            case VIRSettingsPhoneField:
                [userSettings setObject:tf.text forKey:kSettingsPhoneKey];
                break;
            case VIRSettingsEmailField:
                [userSettings setObject:tf.text forKey:kSettingsEmailKey];
                break;
        }
        [userSettings synchronize];
    }
}

- (void)loadSettings {
     NSUserDefaults *userSettings = [NSUserDefaults standardUserDefaults];
    for(UITextField* tf in self.textFieldButtons) {
        switch (tf.tag) {
            case VIRSettingsLoginField:
                tf.text = [userSettings objectForKey:kSettingsLoginKey];
                break;
            case VIRSettingsPasswordField:
                tf.text = [userSettings objectForKey:kSettingsPasswordKey];
                break;
            case VIRSettingsFirstNameField:
                tf.text = [userSettings objectForKey:kSettingsFirstNameKey];
                break;
            case VIRSettingsLastNameField:
                tf.text = [userSettings objectForKey:kSettingsLastNameKey];
                break;
            case VIRSettingsAgeField:
                tf.text = [userSettings objectForKey:kSettingsAgeKey];
                break;
            case VIRSettingsPhoneField:
                tf.text = [userSettings objectForKey:kSettingsPhoneKey];
                break;
            case VIRSettingsEmailField:
                tf.text = [userSettings objectForKey:kSettingsEmailKey];
                break;
        }
    }
}
@end
