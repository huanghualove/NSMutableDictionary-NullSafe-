//
//  ViewController.m
//  CircleBut
//
//  Created by 黄华 on 2017/10/17.
//  Copyright © 2017年 huanghua. All rights reserved.
//

#import "ViewController.h"
#import "ARSegmentView.h"
#import "NSMutableDictionary+NullSafe.h"
#import "Person.h"

@interface ViewController ()

@property(nonatomic,strong) NSThread *myThread;


@end

@implementation ViewController

- (NSArray *)getWebsitesWithString:(NSString *)string
{
    NSError *error;
    //    NSString *regulaStr = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    NSMutableArray *result = [NSMutableArray array];
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString *substringForMatch = [string substringWithRange:match.range];
        NSLog(@"%@",substringForMatch);
        [result addObject:substringForMatch];
    }
    return (NSArray *)result;
}

-(int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % (to - from + 1)));
}


-(NSMutableAttributedString*)subStr:(NSString *)string
{
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    //NSString *subStr;
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSArray *rangeArr=[[NSMutableArray alloc]init];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches)
    {
        NSString* substringForMatch;
        substringForMatch = [string substringWithRange:match.range];
        [arr addObject:substringForMatch];
        
    }
    NSString *subStr=string;
    for (NSString *str in arr)
    {
        subStr=[subStr  stringByReplacingOccurrencesOfString:str withString:@"网页链接"];
    }
    rangeArr = [self rangesOfString:@"网页链接" inString:subStr];
    
    //    //计算大小
    UIFont *font = [UIFont systemFontOfSize:15];
    NSMutableAttributedString *attributedText;
    
    attributedText=[[NSMutableAttributedString alloc]initWithString:subStr attributes:@{NSFontAttributeName :font}];
    
    for(NSValue *value in rangeArr)
    {
        NSInteger index=[rangeArr indexOfObject:value];
        NSRange range=[value rangeValue];
        [attributedText addAttribute: NSLinkAttributeName value: [NSURL URLWithString:[NSString stringWithFormat:@"%@",[arr objectAtIndex:index]]] range:range];
    }
    return attributedText;
    
    
}

//获取查找字符串在母串中的NSRange
- (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSRange searchRange = NSMakeRange(0, [str length]);
    
    NSRange range;
    
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        
        [results addObject:[NSValue valueWithRange:range]];
        
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
        
    }
    
    return results;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //[self xiancehng];
    
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"xiancehng"];
    
    Person *p = [[Person alloc] init];
    
    p.name = str;
    
    
    // person中的属性会被修改
    [str appendString:@" cool"];
    
    NSLog(@"name = %@", p.name);
    
    
    id obj = nil;
    
    NSMutableDictionary *m_dict = [NSMutableDictionary dictionary];
    
    [m_dict setObject:obj forKey:@"666"];

    
    m_dict.name = @"hhhh";
    
    
    
//    int index1 =  [self getRandomNumber:0 to:2];
//
//
//    int index2 =  [self getRandomNumber:0 to:4];
//
//
    
//    NSArray *array = [self getWebsitesWithString:@"差多就啥的沮丧和从第三djhttps://www.baidu.com dsk零库存聚餐"];
//
//    NSLog(@"array =%@ \n ",array);
    

//    NSLog(@"index1 =%d \n index2 = %d",index1,index2);
    
    
    /*
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(18, 100, self.view.bounds.size.width-36, 100)];
    [self.view addSubview:textView];
    [textView setEditable:NO];
    
    textView.textColor = [UIColor blackColor];
    
    NSMutableAttributedString *string = [self subStr:@"我是一段中文wwwhttps://github.com/TinyQ我还是一段中文阿里科技屌丝拉法基是拉萨江东父老阿斯蒂芬阿斯蒂芬四缸发动机333whttps://www.baidu.com发送"];
    
    
    textView.attributedText = string;
    
    //NSLog(@" string = %@",string);
    */
    
    //创建UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"视频", @"声音",@"图片"]];
    segmentedControl.frame = CGRectMake(40, 100, 300, 40);
    [self.view addSubview:segmentedControl];
    // 默认选中下标为1的item
    segmentedControl.selectedSegmentIndex = 0;
    // 添加触发方法
    [segmentedControl addTarget:self action:@selector(click:) forControlEvents:UIControlEventValueChanged];
    
    
//    CGRect frame = CGRectMake(200, 200, 40, 40);
//
//    UIView *timeView = [[UIView alloc] initWithFrame:frame];
//    timeView.layer.cornerRadius = 20;
//    timeView.layer.masksToBounds = YES;
//    timeView.backgroundColor = [UIColor  clearColor];
//    [self.view addSubview:timeView];
//
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    label.text = @"跳过";
//    label.font = [UIFont systemFontOfSize:12];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor blackColor];
//    [timeView addSubview:label];
//
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer.lineWidth = 2.0;
//    [timeView.layer addSublayer:shapeLayer];
//
//    CGFloat w = CGRectGetWidth(frame);
//    CGFloat h = CGRectGetHeight(frame);
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(w/2, h/2)
//                                                        radius:MIN(w, h)/2
//                                                    startAngle:-M_PI_2
//                                                      endAngle:3 * M_PI_2
//                                                     clockwise:YES];
//    shapeLayer.path = path.CGPath;
//
//    // 倒计时的时间
//    NSInteger time = 3;
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
//    animation.duration = time;
//    animation.fromValue = @(0.f);
//    animation.toValue = @(1.f);
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeBoth;
//    animation.repeatCount = MAXFLOAT;
//    [shapeLayer addAnimation:animation forKey:nil];
    

}

// 点击修改背景颜色
-(void)click:(UISegmentedControl *)seg {
    // 获取当前选中的按钮编号
    NSInteger index = seg.selectedSegmentIndex;
    // 根据获取到的index,修改背景颜色
    switch (index)
    {
        case 0:
            self.view.backgroundColor = [UIColor redColor]; break;
        case 1:
            self.view.backgroundColor = [UIColor yellowColor]; break;
        case 2:
            self.view.backgroundColor = [UIColor blueColor]; break;
        default:  break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)xiancehng{
    
//    while (1) {
//        NSLog(@"while begin");
//        // the thread be blocked here
//        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//        [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//        // this will not be executed
//        NSLog(@"while end");
//
//    }
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        while (1) {
//            NSLog(@"while begin");
//            NSPort *macPort = [NSPort port];
//            NSRunLoop *subRunLoop = [NSRunLoop currentRunLoop];
//            [subRunLoop addPort:macPort forMode:NSDefaultRunLoopMode];
//            [subRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//            NSLog(@"while end");
//            NSLog(@"%@",subRunLoop);
//        }
//    });
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        [self performSelector:@selector(backGroundThread) onThread:[NSThread currentThread] withObject:nil waitUntilDone:NO];
//
//        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
//        [runLoop run];
//
//    });
    
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(myThreadRun) object:@"etund"];
    self.myThread = thread;
    [self.myThread start];
    
}

- (void)myThreadRun{

    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"my thread run");
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"%@",self.myThread);
    [self performSelector:@selector(doBackGroundThreadWork) onThread:self.myThread withObject:nil waitUntilDone:NO];
}
- (void)doBackGroundThreadWork{
    
    NSLog(@"do some work %s",__FUNCTION__);
    
}

- (void)backGroundThread{
    
    NSLog(@"%u",[NSThread isMainThread]);
    
    NSLog(@"execute %s",__FUNCTION__);
    
}

@end
