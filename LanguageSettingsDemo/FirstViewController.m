//
//  FirstViewController.m
//  LanguageSettingsDemo
//
//  Created by 孙杰 on 2019/11/7.
//  
//

#import "FirstViewController.h"
#import "PrefixHeader.pch"
#import "NSBundle+DAUtils.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.image setImage:[UIImage imageNamed:PJLocalString(@"imageName")]];
    [self.image setImage:[UIImage imageNamed:NSLocalizedString(@"imageName", nil)]];
//    [self update];
}

// update中的异步执行部分会回调viewDidLoad,因此不能在viewDidLoad中update，会死循环。
- (void) update
{
    //更新当前storyboard
    UITabBarController *tbc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
//    tbc.selectedIndex = 0;
    FirstViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:NSStringFromClass([FirstViewController class])];
    UINavigationController *nvc = tbc.selectedViewController;
    NSMutableArray *vcs = nvc.viewControllers.mutableCopy;
    
    [vcs addObject:vc];
    //解决奇怪的动画bug。异步执行
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].keyWindow.rootViewController = tbc;
        nvc.viewControllers = vcs;
        NSLog(@"homepage已切换到语言 %@", [NSBundle currentLanguage]);
    });
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
