//
//  Cell.m
//  驾照通
//
//  Created by Tarena on 16/5/14.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ZZCell.h"
#import "UIImageView+WebCache.h"
#import "ZZCellStateArray.h"
#import "ZZCellContentState.h"
#import "ZZManeger.h"
#import "ZZAllCollectionViewController.h"
@interface ZZCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *Abutton;
@property (weak, nonatomic) IBOutlet UIButton *Bbutton;
@property (weak, nonatomic) IBOutlet UIButton *Cbutton;
@property (weak, nonatomic) IBOutlet UIButton *Dbutton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UILabel *AAnwserLabel;
@property (weak, nonatomic) IBOutlet UILabel *BAnwserLabel;
@property (weak, nonatomic) IBOutlet UILabel *CAnwserLabel;
@property (weak, nonatomic) IBOutlet UILabel *DAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *ExplainLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *questionConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextButtonConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextLabelConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lastButtonConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lastLabelConstraint;
@property (nonatomic,strong) NSString *answer;
@property (nonatomic,strong) NSString *AbuttonImage;
@property (nonatomic,strong) NSString *BbuttonImage;
@property (nonatomic,strong) NSString *CbuttonImage;
@property (nonatomic,strong) NSString *DbuttonImage;
@property (nonatomic,strong) NSString *statePath;
@property (nonatomic,strong) NSString *wrongPath;
@property (nonatomic,strong) NSString *collectPath;
@property (nonatomic,strong) ZZAllCollectionViewController *vc;
@end
@implementation ZZCell
#pragma mark --懒加载
-(ZZAllCollectionViewController *)vc
{
    if (_vc==nil) {
        _vc=(ZZAllCollectionViewController*)[self viewController];
    }
    return _vc;
}

//获取当前控制器
- (UIViewController *)viewController {
    UIResponder *next = self.nextResponder;
    do {
        //判断响应者是否为视图控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    } while (next != nil);
    
    return nil;
}


-(NSString*)wrongPath
{
    if (_wrongPath==nil) {
        _wrongPath=[ZZManeger getWrongPathWithModel:self.model subject:self.subject];
    }
    return _wrongPath;
}
-(NSString*)collectPath
{
    if (_collectPath==nil) {
        _collectPath=[ZZManeger getCollectPathWithModel:self.model subject:self.subject];
    }
    return _collectPath;
}

//状态文件路径
-(NSString *)statePath
{
    if (_statePath==nil) {
        _statePath=[ZZManeger getCellStatePathWithModel:self.model subject:self.subject who:self.who];
    }
    return _statePath;
}

#pragma mark -- 初始化Cell

- (void)awakeFromNib {
    self.backgroundColor=[UIColor whiteColor];
}
//设置每项
-(void)setCell:(ZZResult *)result
{
    self.collectButton.hidden=YES;
    self.collectLabel.hidden=YES;
    self.questionLabel.text=[NSString stringWithFormat:@"问题%d:%@",(self.num+1),result.question];
    self.AAnwserLabel.text=[NSString stringWithFormat:@"A:%@",result.item1];
    self.BAnwserLabel.text=[NSString stringWithFormat:@"B:%@",result.item2];
    self.ExplainLabel.text=[NSString stringWithFormat:@"分析:%@",result.explains];
    self.answer=result.answer;
    [self reset];
    [self setCLabel:result];
    [self setDLabel:result];
    [self setImage:result];
    [self setupCellState];
    [self setupCollectButtonAndCollectLabel];
}

//当复用cell时重置
-(void)reset
{
    self.ExplainLabel.hidden=YES;
    self.imageView.hidden=NO;
    self.Cbutton.hidden=NO;
    self.CAnwserLabel.hidden=NO;
    self.Dbutton.hidden=NO;
    self.DAnswerLabel.hidden=NO;
    self.resultLabel.text=nil;
    [self setupButton:self.Abutton];
    [self setupButton:self.Bbutton];
    [self setupButton:self.Cbutton];
    [self setupButton:self.Dbutton];
}
//设置button
-(void)setupButton:(UIButton*)sender
{
    sender.enabled=YES;
    [sender setBackgroundImage:[UIImage imageNamed:@"un_selected"] forState:UIControlStateNormal];
}

//根据有没有C选项设置
-(void)setCLabel:(ZZResult*)result
{
    if ([result.item3 isEqualToString:@""]) {
        self.Cbutton.hidden=YES;
        self.CAnwserLabel.hidden=YES;
    }
    else
    {
        self.CAnwserLabel.text=[NSString stringWithFormat:@"C:%@",result.item3];
    }
    
}
//根据有没有D选项设置
-(void)setDLabel:(ZZResult*)result
{
    if ([result.item4 isEqualToString:@""]) {
        self.Dbutton.hidden=YES;
        self.DAnswerLabel.hidden=YES;
    }
    else{
        self.DAnswerLabel.text=[NSString stringWithFormat:@"D:%@",result.item4];
    }
}
//根据有没有图片设置并用三方库下载
-(void)setImage:(ZZResult*)result
{
    if (result.url.length==0) {
        self.imageView.hidden=YES;
    }
    else{
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:result.url] placeholderImage:[UIImage imageNamed:@"placeholder_image"]];
    }
}
//设置cell的状态
-(void)setupCellState
{
    if ([self.who isEqualToString:@"考试"]) {
        [self CellFromTest];
    }
    else
    {
        [self CellFromAllOrWrongOrCollect];
    }
}
//cell属于考试
-(void)CellFromTest
{
    for (ZZCellContentState *state in self.stateArray) {
        if (state.num==self.num) {
            [self setState:state];
        }
    }
}

//cell属于练习或错题或收藏
-(void)CellFromAllOrWrongOrCollect
{
    NSArray *readArray;
    if ([ZZCellStateArray getCellStateArray:self.who])
    {
        readArray=[ZZCellStateArray getCellStateArray:self.who];
        if (self.num<=readArray.count) {
            [self decode:readArray];
        }
    }
    else
    {
        readArray=[NSArray arrayWithContentsOfFile:self.statePath];
        if (readArray) {
            [self decode:readArray];
        }
    }
}

//解码
-(void)decode:(NSArray*)readArray
{
    NSMutableArray *readMuarray=[NSMutableArray array];
    for (NSData *readData in readArray) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:readData];
        ZZCellContentState * cellState= [unarchiver decodeObjectForKey:@"cellState"];
        [unarchiver finishDecoding];
        [readMuarray addObject:cellState];
        for (ZZCellContentState *state in readMuarray) {
            if (state.num==self.num)
            {
                [self setState:state];
            }
        }
    }
}

//读取cell的状态
-(void)setState:(ZZCellContentState*)state
{
    self.ExplainLabel.hidden = state.isButtonEnabled;
    self.resultLabel.hidden = state.isButtonEnabled;
    self.resultLabel.text=state.anwser;
    [self.Abutton setBackgroundImage:[UIImage imageNamed:state.AbuttonImage] forState:UIControlStateNormal];
    [self.Bbutton setBackgroundImage:[UIImage imageNamed:state.BbuttonImage] forState:UIControlStateNormal];
    [self.Cbutton setBackgroundImage:[UIImage imageNamed:state.CbuttonImage] forState:UIControlStateNormal];
    [self.Dbutton setBackgroundImage:[UIImage imageNamed:state.DbuttonImage] forState:UIControlStateNormal];
    self.Abutton.enabled = state.isButtonEnabled;
    self.Bbutton.enabled = state.isButtonEnabled;
    self.Cbutton.enabled = state.isButtonEnabled;
    self.Dbutton.enabled = state.isButtonEnabled;
}

//设置cell中下方收藏按钮和收藏文本
-(void)setupCollectButtonAndCollectLabel
{
    if ([self.who isEqualToString:@"练习"]) {
        self.collectLabel.hidden=NO;
        self.collectButton.hidden=NO;
    }
    else if ([self.who isEqualToString:@"收藏"]) {
        self.collectButton.hidden=NO;
        self.collectLabel.hidden=NO;
        self.collectLabel.text=@"取消收藏";
    }
}
//复用时先移除图片
-(void)removeAllContent
{
    self.imageView.image=nil;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}
//更新约束
-(void)updateConstraints
{
    [super updateConstraints];
    if (self.imageView.image==nil) {
        self.questionConstrain.constant=20;
        if (self.Cbutton.hidden) {
            self.resultConstrain.constant=0;
        }
        else
        {
            self.resultConstrain.constant=80;
        }
    }
    else
    {
        self.questionConstrain.constant=110;
        if (self.Cbutton.hidden) {
            self.resultConstrain.constant=0;
        }
        else
        {
            self.resultConstrain.constant=80;
        }
    }
    if (self.collectButton.hidden==NO) {
        self.nextButtonConstraint.constant=-self.bounds.size.width*1.0/6;
        self.lastButtonConstraint.constant=-self.bounds.size.width*1.0/6;
        self.nextLabelConstraint.constant=-self.bounds.size.width*1.0/6;
        self.lastLabelConstraint.constant=-self.bounds.size.width*1.0/6;
    }
}

#pragma mark --点击答题按键（ABCD）后的一系列处理

//点击button后的处理
- (IBAction)buttonClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [self result:@"1" :sender];
            break;
        case 1:
            [self result:@"2" :sender];
            break;
        case 2:
            [self result:@"3" :sender];
            break;
        default:
            [self result:@"4" :sender];
            break;
    }
    self.ExplainLabel.hidden=NO;
    [self setButtonEnabled];
    [self noteCellState];
}
//点击后判断结果并设置各个button的图片并记录图片名称
-(void)result:(NSString*)selected :(UIButton*)button
{
    NSString *changeAnswer;
    switch ([self.answer intValue]) {
        case 1:
            changeAnswer=@"A";
            break;
        case 2:
            changeAnswer=@"B";
            break;
        case 3:
            changeAnswer=@"C";
            break;
        default:
            changeAnswer=@"D";
            break;
    }
    if ([selected isEqualToString:self.answer])
    {
        self.resultLabel.text=@"回答正确";
        [button setBackgroundImage:[UIImage imageNamed:@"correct_icon"] forState:UIControlStateNormal];
        [self setDidClickButtonImage:button andIsRight:YES];
        self.scoreblock();
    }
    else
    {
        self.resultLabel.text=[NSString stringWithFormat:@"回答错误,答案是%@",changeAnswer];
        [button setBackgroundImage:[UIImage imageNamed:@"wrong_icon"] forState:UIControlStateNormal];
        //当在练习时做错自动加入错题
        if ([self.who isEqualToString:@"练习"]) {
            [self addWrong];
        }
        [self setDidClickButtonImage:button andIsRight:NO];
    }
}
//设置点击完后各个buttonimage的值
-(void)setDidClickButtonImage:(UIButton*)button andIsRight:(BOOL)right
{
    self.DbuttonImage=@"un_selected";
    self.BbuttonImage=@"un_selected";
    self.CbuttonImage=@"un_selected";
    self.AbuttonImage=@"un_selected";
    switch (button.tag) {
        case 0:
            self.AbuttonImage=right?@"correct_icon":@"wrong_icon";
            break;
        case 1:
            self.BbuttonImage=right?@"correct_icon":@"wrong_icon";
            break;
        case 2:
            self.CbuttonImage=right?@"correct_icon":@"wrong_icon";
            break;
        default:
            self.DbuttonImage=right?@"correct_icon":@"wrong_icon";
            break;
    }
}

//点击后设置各个button失效
-(void)setButtonEnabled
{
    self.Abutton.enabled=NO;
    self.Bbutton.enabled=NO;
    self.Cbutton.enabled=NO;
    self.Dbutton.enabled=NO;
}

//记录cell状态
-(void)noteCellState
{
    ZZCellContentState *cellState=[[ZZCellContentState alloc]init];
    cellState.isButtonEnabled=self.Abutton.enabled;
    cellState.anwser=self.resultLabel.text;
    cellState.AbuttonImage=self.AbuttonImage;
    cellState.BbuttonImage=self.BbuttonImage;
    cellState.CbuttonImage=self.CbuttonImage;
    cellState.DbuttonImage=self.DbuttonImage;
    cellState.num=self.num;
    [self WriteCellStateTofile:cellState];
}

//把cell的状态写入文件，存储
-(void)WriteCellStateTofile:(ZZCellContentState*)cellState
{
    NSMutableArray * muArray;
    if ([self.who isEqualToString:@"考试"]) {
        self.stateFromTestblock(cellState);
    }
    else
    {
        //编码
        NSMutableData *mutableData = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
        [archiver encodeObject:cellState forKey:@"cellState"];
        [archiver finishEncoding];
        muArray=[ZZCellStateArray getCellStateArray:self.who];
        [muArray addObject:mutableData];
        [muArray writeToFile:self.statePath atomically:YES];
    }
}

#pragma mark -- 加入错题

//加入错题
-(void)addWrong
{
    NSMutableArray *MuArray=[NSMutableArray arrayWithContentsOfFile:self.wrongPath];
    if (MuArray) {
        for (int i=0; i<MuArray.count; i++) {
            if ([MuArray[i] isEqualToNumber:[NSNumber numberWithInt:self.num]]) {
                return;
            }
            else if (i==MuArray.count-1) {
                [MuArray addObject:[NSNumber numberWithInt:self.num]];
                [self addWrongAndWriteToFile:MuArray];
            }
        }
    }
    else
    {
        MuArray =[NSMutableArray array];
        [MuArray addObject:[NSNumber numberWithInt:self.num]];
        [self addWrongAndWriteToFile:MuArray];
    }
}
//写入文件

-(void)addWrongAndWriteToFile:(NSMutableArray*)array
{
    [array writeToFile:self.wrongPath atomically:YES];
}


#pragma mark -- 收藏按钮和取消收藏按钮

//收藏按钮事件
- (IBAction)collectButton:(UIButton*)sender {
    if ([self.who isEqualToString:@"练习"]) {
        [self addCollect];
        [self creatAlert:self.who];
    }
    else
    {
        [self creatAlert:self.who];
    }
}
//弹窗
-(void)creatAlert:(NSString*)who
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:[self.who isEqualToString:@"练习"]?@"收藏成功":@"已取消收藏" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.who isEqualToString:@"收藏"]) {
            [self deleteCollect];
        }
    }];
    [alert addAction:action];
    [[self viewController].navigationController presentViewController:alert animated:YES completion:nil];
}


//添加收藏
-(void)addCollect
{
    NSMutableArray *MuArray=[NSMutableArray arrayWithContentsOfFile:self.collectPath];
    if (MuArray) {
        for (int i=0; i<MuArray.count; i++) {
            if ([MuArray[i] isEqualToNumber:[NSNumber numberWithInt:self.num]]) {
                return;
            }
            else if (i==MuArray.count-1) {
                [MuArray addObject:[NSNumber numberWithInt:self.num]];
                [self addCollectWriteTofile:MuArray];
            }
        }
    }
    else
    {
        MuArray =[NSMutableArray array];
        [MuArray addObject:[NSNumber numberWithInt:self.num]];
        [self addCollectWriteTofile:MuArray];
    }
}

-(void)addCollectWriteTofile:(NSMutableArray *)array
{
    [array writeToFile:self.collectPath atomically:YES];
}
//取消收藏
-(void)deleteCollect
{
    NSMutableArray *array=[NSMutableArray arrayWithContentsOfFile:self.collectPath];
    if (array.count==1) {
        NSString *collectPath=[ZZManeger getCollectPathWithModel:self.model subject:self.subject];
        [[NSFileManager defaultManager]removeItemAtPath:collectPath error:nil];
        [self.vc.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [array removeObjectAtIndex:self.num];
        [self addCollectWriteTofile:array];
        [self.vc.collectionView reloadData];
    }
    
}
//下一题
- (IBAction)nextQuestionButton:(id)sender {
    if (self.num==self.allNum-1) {
        [self TheQuestionAlert:NO];
    }
    else
    {
        self.vc.collectionView.contentOffset=CGPointMake(self.bounds.size.width*(self.num+1), 0);
    }
    
}
//上一题
- (IBAction)lastQuestionButton:(id)sender {
    if (self.num==0) {
        [self TheQuestionAlert:YES];
    }
    else
    {
       self.vc.collectionView.contentOffset=CGPointMake(self.bounds.size.width*(self.num-1), 0);
    }
    
}

-(void)TheQuestionAlert:(BOOL)isFirst
{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:isFirst?@"已经是第一题":@"已经是最后一题" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self.vc presentViewController:alert animated:YES completion:nil];
}




@end
