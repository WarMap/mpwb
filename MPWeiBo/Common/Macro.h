//
//  Macro.h
//  TaetaoDoc
//



#pragma mark - 工具

#pragma  -  weakify  / strongify

#ifndef    weakify_self
#if __has_feature(objc_arc)
#define weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
#else
#define weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
#endif
#endif

#ifndef    strongify_self
#if __has_feature(objc_arc)
#define strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;
#else
#define strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;
#endif
#endif

#ifndef    weakify
    #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
    #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
    #endif
#endif

#ifndef    strongify
    #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = weak##_##object;
    #else
        #define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = block##_##object;
    #endif
#endif

#define dispatch_after_time(time,block)                          \
dispatch_time_t delayInNanoSeconds =                      \
dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC); \
dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), block);

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

//机型判断
#define DEVICE_IS_IPHONE4 ([[UIScreen mainScreen] bounds].size.height == 480)
#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define DEVICE_IS_IPHONE6 ([[UIScreen mainScreen] bounds].size.height == 667)
#define DEVICE_IS_IPHONE6P ([[UIScreen mainScreen] bounds].size.height == 736)
// 8版本判断

#define IS_IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
// 7版本判断
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
// 屏幕宽度
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight                                \
(IS_IOS7 ? [[UIScreen mainScreen] bounds].size.height \
: [[UIScreen mainScreen] bounds].size.height - 20)

#define NavigationBarHeight 64

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define MPKeyWindow [UIApplication sharedApplication].keyWindow
