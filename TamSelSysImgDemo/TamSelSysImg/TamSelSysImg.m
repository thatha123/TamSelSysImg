//
//  TamSelSysImg.m
//  TamSelSysImgDemo
//
//  Created by xin chen on 2017/8/21.
//  Copyright © 2017年 涂怀安. All rights reserved.
//

#import "TamSelSysImg.h"

@interface TamSelSysImg()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic,strong)UIViewController *vc;
@property(nonatomic,copy)ImgBlock imgBlock;

@end

@implementation TamSelSysImg

+(TamSelSysImg *)shareInstance
{
    static dispatch_once_t onceToken;
    static TamSelSysImg *_selImgTool;
    dispatch_once(&onceToken, ^{
        _selImgTool = [[TamSelSysImg alloc]init];
    });
    return _selImgTool;
}

/**
 *  系统图片选择器
 *
 */
+(void)selImage:(UIViewController *)sender isShowCamera:(BOOL)isShowCamera isShowEdit:(BOOL)isShowEdit imgBlock:(ImgBlock)imgBlock
{
    [TamSelSysImg shareInstance].vc = sender;
    [TamSelSysImg shareInstance].imgBlock = imgBlock;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSUInteger sourceType = 0;
        // 相机
        sourceType = UIImagePickerControllerSourceTypeCamera;
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = sourceType;
        imagePicker.delegate = [TamSelSysImg shareInstance];
        imagePicker.allowsEditing = isShowEdit;
        [sender presentViewController:imagePicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction *alertAction3 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUInteger sourceType = 0;
        // 相册
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = sourceType;
        imagePicker.delegate = [TamSelSysImg shareInstance];
        imagePicker.allowsEditing = isShowEdit;
        [sender presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && isShowCamera)
    {
        [alertController addAction:alertAction];
        [alertController addAction:alertAction2];
        [alertController addAction:alertAction3];
    }
    else {
        [alertController addAction:alertAction];
        [alertController addAction:alertAction3];
        
    }
    
    [sender presentViewController:alertController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSMutableDictionary * dict= [NSMutableDictionary dictionaryWithDictionary:editingInfo];
    
    [dict setObject:image forKey:@"UIImagePickerControllerEditedImage"];
    
    //直接调用3.x的处理函数
    [self imagePickerController:picker didFinishPickingMediaWithInfo:dict];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //    if (picker == UIImagePickerControllerSourceTypeCamera)
    //    {
    //        //如果是 来自照相机的image，那么先保存
    //        UIImage* original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //        UIImageWriteToSavedPhotosAlbum(original_image, self,
    //                                       @selector(image:didFinishSavingWithError:contextInfo:),
    //                                       nil);
    //    }
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if (self.imgBlock) {
        self.imgBlock(image);
    }
    
    [self.vc dismissViewControllerAnimated:YES completion:nil];
}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [ApplicationShared setStatusBarStyle:UIStatusBarStyleDefault];
//    [self.vc dismissViewControllerAnimated:YES completion:nil];
//}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

@end
