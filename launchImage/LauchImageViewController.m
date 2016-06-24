//
//  LauchImageViewController.m
//  launchImage
//
//  Created by 俊洋洋 on 16/6/24.
//  Copyright © 2016年 俊洋洋. All rights reserved.
//

#import "LauchImageViewController.h"

@interface LauchImageViewController ()
@property (nonatomic,strong)UIImageView *backgroudImageView;
@end

@implementation LauchImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupData];
}
- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    _backgroudImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_backgroudImageView];
}
- (void)setupData
{
    NSString *url  =[ DEFAULTS objectForKey:launchkey];
    if (url)
        [_backgroudImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    [LYHttpsTool get:launchUrl parame:nil success:^(id JSON) {
        [self getUrl:JSON[@"img"]];
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
    

}
- (void)getUrl:(NSString *)urlStr
{
    [DEFAULTS setObject:urlStr forKey:launchkey];
    [DEFAULTS synchronize];
    [_backgroudImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:2.0f animations:^{
            _backgroudImageView.alpha = 0.1;
            _backgroudImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [[NSNotificationCenter defaultCenter]postNotificationName:stateNotification object:nil];
        }];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
