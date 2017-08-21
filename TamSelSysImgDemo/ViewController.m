//
//  ViewController.m
//  TamSelSysImgDemo
//
//  Created by xin chen on 2017/8/21.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "ViewController.h"
#import "TamSelSysImg.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)selImgAction:(UIButton *)sender {
    [TamSelSysImg selImage:self isShowCamera:YES isShowEdit:YES imgBlock:^(UIImage *img) {
        self.imgView.image = img;
    }];
}


@end
