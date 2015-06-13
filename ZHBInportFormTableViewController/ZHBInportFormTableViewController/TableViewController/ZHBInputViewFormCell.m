//
//  ZHBInputViewFormCell.m
//  ZHBInputFormTableView
//
//  Created by zhb on 15/6/12.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "ZHBInputViewFormCell.h"
#import "ZHBInputFormConstants.h"

@interface ZHBInputViewFormCell()<UITextFieldDelegate,UITextViewDelegate>

@end

@implementation ZHBInputViewFormCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.starLabel];
        [self.contentView addSubview:self.inputTextView];
        [self.contentView addSubview:self.inputTextField];
        [self.contentView addSubview:self.noticeLabel];
        [self.contentView addSubview:self.placeHolderLabel];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    ZHBInputFormCellModel *cellModel = self.cellFrame.cellModel;
    self.titleLabel.frame = self.cellFrame.titleLabelFrame;
    self.starLabel.frame = self.cellFrame.starLabelFrame;
    self.inputTextView.frame = self.cellFrame.inputFrame;
    self.inputTextField.frame = self.cellFrame.inputFrame;
    self.noticeLabel.frame = self.cellFrame.noticeAndErrorLabelFrame;
    self.placeHolderLabel.frame = self.cellFrame.placeHolderLabelFrame;
    
    self.inputTextField.hidden = cellModel.longText;
    self.inputTextView.hidden = !cellModel.longText;
    if (cellModel.inputString.length != 0) {
        self.placeHolderLabel.hidden = YES;
    }else{
        self.placeHolderLabel.hidden = !cellModel.longText;
    }
    self.starLabel.hidden = !cellModel.required;
    if (cellModel.error) {
        self.noticeLabel.textColor = [UIColor redColor];
        self.noticeLabel.text = cellModel.errorString;
    }else{
        self.noticeLabel.textColor = [UIColor grayColor];
        self.noticeLabel.text = cellModel.noticeString;
    }
    self.titleLabel.text = cellModel.title;
    if (cellModel.longText) {
        self.inputTextView.text = cellModel.inputString;
    }else{
        self.inputTextField.text = cellModel.inputString;
    }
    self.placeHolderLabel.text = cellModel.placeHolderString;
    self.inputTextField.placeholder = cellModel.placeHolderString;
    if (cellModel.encrypt){
        self.inputTextField.secureTextEntry = YES;
    }else{
        self.inputTextField.secureTextEntry = NO;
    }
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (self.cellFrame.cellModel.error) {
        self.cellFrame.cellModel.error = NO;
        self.noticeLabel.text = self.cellFrame.cellModel.noticeString;
        self.noticeLabel.textColor = [UIColor grayColor];
    }
    CGPoint point = [self.tableView convertPoint:textView.frame.origin fromView:self.contentView];
    CGFloat offsetY = point.y - self.tableView.contentInset.top;
    if (offsetY < 0) {
        offsetY = 0;
    }else if (offsetY > self.tableView.contentSize.height - self.tableView.frame.size.height + self.tableView.contentInset.bottom){
        offsetY = self.tableView.contentSize.height - self.tableView.frame.size.height + self.tableView.contentInset.bottom;
    }
    [self.tableView setContentOffset:CGPointMake(0, offsetY) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        self.placeHolderLabel.hidden = YES;
    }else{
        self.placeHolderLabel.hidden = NO;
    }
    self.cellFrame.cellModel.inputString = textView.text;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.cellFrame.cellModel.error) {
        self.cellFrame.cellModel.error = NO;
        self.noticeLabel.text = self.cellFrame.cellModel.noticeString;
        self.noticeLabel.textColor = [UIColor grayColor];
    }
    CGPoint point = [self.tableView convertPoint:textField.frame.origin fromView:self.contentView];
    CGFloat offsetY = point.y - self.tableView.contentInset.top;
    if (offsetY < 0) {
        offsetY = 0;
    }else if (offsetY > self.tableView.contentSize.height - self.tableView.frame.size.height + self.tableView.contentInset.bottom){
        offsetY = self.tableView.contentSize.height - self.tableView.frame.size.height + self.tableView.contentInset.bottom;
    }
    [self.tableView setContentOffset:CGPointMake(0, offsetY) animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

#pragma mark - event response
- (void)textFieldDidChange:(UITextField *)textfield{
    self.cellFrame.cellModel.inputString = textfield.text;
}

#pragma mark - getter & setter
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = ZHBInputFormCellTitleLabelFont;
    }
    return _titleLabel;
}

-(UILabel *)starLabel{
    if (!_starLabel) {
        _starLabel = [[UILabel alloc] init];
        _starLabel.text = @"*";
        _starLabel.textColor = [UIColor redColor];
    }
    return _starLabel;
}

-(UITextView *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [[UITextView alloc] init];
        _inputTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _inputTextView.layer.borderWidth = 0.5f;
        _inputTextView.layer.cornerRadius = 4.0f;
        _inputTextView.backgroundColor = [UIColor whiteColor];
        _inputTextView.font = ZHBInputFormCellInputFont;
        _inputTextView.delegate = self;
    }
    return _inputTextView;
}

-(UILabel *)placeHolderLabel{
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.textAlignment = NSTextAlignmentLeft;
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
        _placeHolderLabel.textColor = UIColorFromRGB(0xc8c8c8);
        _placeHolderLabel.userInteractionEnabled = NO;
        _placeHolderLabel.font = ZHBInputFormCellInputFont;
    }
    return _placeHolderLabel;
}

-(UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _inputTextField.layer.borderWidth = 0.5f;
        _inputTextField.layer.cornerRadius = 4.0f;
        _inputTextField.backgroundColor = [UIColor whiteColor];
        _inputTextField.font = ZHBInputFormCellInputFont;
        _inputTextField.delegate = self;
        [_inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTextField;
}

-(UILabel *)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc] init];
        _noticeLabel.backgroundColor = [UIColor clearColor];
        _noticeLabel.textAlignment = NSTextAlignmentLeft;
        _noticeLabel.numberOfLines = 0;
        _noticeLabel.font = ZHBInputFormCellNoticeFont;
    }
    return _noticeLabel;
}

@end
