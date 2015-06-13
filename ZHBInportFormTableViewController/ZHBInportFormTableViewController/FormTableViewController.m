//
//  FormTableViewController.m
//  ZHBInputFormTableView
//
//  Created by zhb on 15/6/12.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "FormTableViewController.h"
#import "NSString+Utils.h"

@interface FormTableViewController()

@property (nonatomic,strong) NSMutableArray *inputFormCellFrameArray;

@property (nonatomic,strong) NSDictionary *formGetDictionary;//get以后自动填充的信息

@end

@implementation FormTableViewController

#pragma mark - life cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.inputCellFrameArray = self.inputFormCellFrameArray;
    self.title = @"注册新用户";
    __weak typeof(self) weakSelf = self;
    self.clickFormButtonBlock = ^(NSInteger buttonIndex){
        if (buttonIndex == 0) {
            if (![weakSelf checkRequired]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"表单填写有误，请检查后重新提交" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
            }else{
                NSDictionary *dict = weakSelf.commitParamDictionary;
                [[[UIAlertView alloc] initWithTitle:@"提交信息" message:dict.description delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
            }
        }else{
            [weakSelf clearAllInputView];
        }
    };
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(BOOL)checkRequired{
    BOOL superResult = [super checkRequired];
    ZHBInputFormCellFramesModel *cellFrame2 = self.inputCellFrameArray[2];
    ZHBInputFormCellFramesModel *cellFrame3 = self.inputCellFrameArray[3];
    BOOL checkPSWEquel = [cellFrame3.cellModel.inputString isEqualToString:cellFrame2.cellModel.inputString];
    if (!checkPSWEquel){
        cellFrame3.cellModel.error = YES;
        cellFrame3.cellModel.errorString = @"两次密码输入不一致";
    }
    ZHBInputFormCellFramesModel *cellFrame1 = self.inputCellFrameArray[1];
    NSString *emailGet = [self.formGetDictionary valueForKey:@"user.email"];
    BOOL checkEmail = cellFrame1.cellModel.inputString.trimmedString.length > 0;
    if (checkEmail && emailGet) {
        if ([emailGet isEqualToString:cellFrame1.cellModel.inputString.trimmedString]) {
            checkEmail = NO;
            cellFrame1.cellModel.error = YES;
            cellFrame1.cellModel.errorString = @"请填写正确邮箱地址";
        }
    }
    BOOL success = superResult && checkPSWEquel && checkEmail;
    if (!success) {
        [self.tableView reloadData];
    }
    return success;
}


#pragma mark - getter & setter
-(NSMutableArray *)inputFormCellFrameArray{
    if (!_inputFormCellFrameArray) {
        ZHBInputFormCellModel *model0 = [[ZHBInputFormCellModel alloc] initWithTitle:@"真实姓名:"
                                                                         inputString:@""
                                                                   placeHolderString:@"输入用户的真实姓名"
                                                                        noticeString:@"* 必须输入真实姓名。"
                                                                            longText:NO
                                                                            required:YES
                                                                             encrypt:NO
                                                                         propertyTag:@"user.realName"];
        
        ZHBInputFormCellModel *model1 = [[ZHBInputFormCellModel alloc] initWithTitle:@"Email邮箱:"
                                                                         inputString:@""
                                                                   placeHolderString:@"输入用户的Email邮箱完整地址"
                                                                        noticeString:@"* 必须输入完整邮箱。"
                                                                            longText:NO
                                                                            required:YES
                                                                             encrypt:NO
                                                                         propertyTag:@"user.email"];
        
        
        ZHBInputFormCellModel *model2 = [[ZHBInputFormCellModel alloc] initWithTitle:@"密码:"
                                                                         inputString:@""
                                                                   placeHolderString:@"输入初始化密码"
                                                                        noticeString:@"* 输入初始密码或者留空自动生成密码，注意密码需要和发送帐户开通时的邮件中的密码一致。"
                                                                            longText:NO
                                                                            required:NO
                                                                             encrypt:YES
                                                                         propertyTag:@"user.password"];
        
        
        ZHBInputFormCellModel *model3 = [[ZHBInputFormCellModel alloc] initWithTitle:@"密码确认:"
                                                                         inputString:@""
                                                                   placeHolderString:@"再次输入密码"
                                                                        noticeString:@"* 输入密码确认或者留空自动生成密码。"
                                                                            longText:NO
                                                                            required:YES
                                                                             encrypt:YES
                                                                         propertyTag:@"user.repeatedPassword"];
        
        
        ZHBInputFormCellModel *model4 = [[ZHBInputFormCellModel alloc] initWithTitle:@"手机号码:"
                                                                         inputString:@""
                                                                   placeHolderString:@"手机号码"
                                                                        noticeString:@"可选输入。"
                                                                            longText:NO
                                                                            required:NO
                                                                             encrypt:NO
                                                                         propertyTag:@"user.mobile"];
        
        
        ZHBInputFormCellModel *model5 = [[ZHBInputFormCellModel alloc] initWithTitle:@"用户昵称:"
                                                                         inputString:@""
                                                                   placeHolderString:@"用户昵称"
                                                                        noticeString:@"可选输入，如果不输入系统会自动生成。"
                                                                            longText:NO
                                                                            required:NO
                                                                             encrypt:NO
                                                                         propertyTag:@"contact.nickName"];
        
        
        ZHBInputFormCellModel *model6 = [[ZHBInputFormCellModel alloc] initWithTitle:@"固定电话:"
                                                                         inputString:@""
                                                                   placeHolderString:@"固定电话"
                                                                        noticeString:@"可选输入。"
                                                                            longText:NO
                                                                            required:NO
                                                                             encrypt:NO
                                                                         propertyTag:@"contact.tel"];
        
        
        ZHBInputFormCellModel *model7 = [[ZHBInputFormCellModel alloc] initWithTitle:@"所在城市:"
                                                                         inputString:@""
                                                                   placeHolderString:@"所在城市"
                                                                        noticeString:@"可选输入。"
                                                                            longText:NO
                                                                            required:NO
                                                                             encrypt:NO
                                                                         propertyTag:@"contact.city"];
        
        
        ZHBInputFormCellModel *model8 = [[ZHBInputFormCellModel alloc] initWithTitle:@"通讯地址:"
                                                                         inputString:@""
                                                                   placeHolderString:@"通讯地址"
                                                                        noticeString:@"可选输入。"
                                                                            longText:YES
                                                                            required:NO
                                                                             encrypt:NO
                                                                         propertyTag:@"contact.addr"];
        
        
        ZHBInputFormCellModel *model9 = [[ZHBInputFormCellModel alloc] initWithTitle:@"备注说明:"
                                                                         inputString:@""
                                                                   placeHolderString:@"备注说明"
                                                                        noticeString:@"可选输入。"
                                                                            longText:YES
                                                                            required:NO
                                                                             encrypt:NO
                                                                         propertyTag:@"user.description"];
        
        ZHBInputFormCellFramesModel * cellFrame0 = [[ZHBInputFormCellFramesModel alloc] initWithCellModel:model0];
        ZHBInputFormCellFramesModel * cellFrame1 = [[ZHBInputFormCellFramesModel alloc] initWithCellModel:model1];
        ZHBInputFormCellFramesModel * cellFrame2 = [[ZHBInputFormCellFramesModel alloc] initWithCellModel:model2];
        ZHBInputFormCellFramesModel * cellFrame3 = [[ZHBInputFormCellFramesModel alloc] initWithCellModel:model3];
        ZHBInputFormCellFramesModel * cellFrame4 = [[ZHBInputFormCellFramesModel alloc] initWithCellModel:model4];
        ZHBInputFormCellFramesModel * cellFrame5 = [[ZHBInputFormCellFramesModel alloc] initWithCellModel:model5];
        ZHBInputFormCellFramesModel * cellFrame6 = [[ZHBInputFormCellFramesModel alloc] initWithCellModel:model6];
        ZHBInputFormCellFramesModel * cellFrame7 = [[ZHBInputFormCellFramesModel alloc] initWithCellModel:model7];
        ZHBInputFormCellFramesModel * cellFrame8 = [[ZHBInputFormCellFramesModel alloc] initWithCellModel:model8];
        ZHBInputFormCellFramesModel * cellFrame9 = [[ZHBInputFormCellFramesModel alloc] initWithCellModel:model9];
        
        _inputFormCellFrameArray = [NSMutableArray arrayWithObjects:cellFrame0,cellFrame1,cellFrame2,cellFrame3,cellFrame4,cellFrame5,cellFrame6,cellFrame7,cellFrame8,cellFrame9, nil];
        
    }
    return _inputFormCellFrameArray;
}

@end
