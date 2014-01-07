//
//  VIRSettingsViewController.h
//  HomeworkStaticTable
//
//  Created by Administrator on 25.12.13.
//  Copyright (c) 2013 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    VIRSettingsLoginField = 1,
    VIRSettingsPasswordField,
    VIRSettingsFirstNameField,
    VIRSettingsLastNameField,
    VIRSettingsAgeField,
    VIRSettingsPhoneField,
    VIRSettingsEmailField
} VirSettingsFields;

@interface VIRSettingsViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldButtons;
@property (assign, nonatomic) VirSettingsFields VIRSettingsFiled;
@property (weak, nonatomic) IBOutlet UIButton *clearAllButon;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;


- (IBAction)actionClearAll:(UIButton *)sender;
- (IBAction)actionTextChangeField:(UITextField *)sender;
- (IBAction)actionValueChangeSwitch:(UISwitch *)sender;


@end
