# ShareReader

[![CI Status](http://img.shields.io/travis/snaill/ShareReader.svg?style=flat)](https://travis-ci.org/snaill/ShareReader)
[![Version](https://img.shields.io/cocoapods/v/ShareReader.svg?style=flat)](http://cocoapods.org/pods/ShareReader)
[![License](https://img.shields.io/cocoapods/l/ShareReader.svg?style=flat)](http://cocoapods.org/pods/ShareReader)
[![Platform](https://img.shields.io/cocoapods/p/ShareReader.svg?style=flat)](http://cocoapods.org/pods/ShareReader)

ShareReader是由分享派提供内容展示的SDK，通过ShareReader，您可以将您创建的内容嵌入到您的APP中，适用于系统帮助、特性展示等场景。

## Getting Started
* 下载[分享派](https://itunes.apple.com/cn/app/fen-xiang-pai/id997062404?l=zh&ls=1&mt=8)
* 通过分享派编辑您的内容
* 使用`pod ShareReader`将ShareReader嵌入您的APP中
* 您的APP中调用ShareReader显示您的内容

## Installation

* via CocoaPods

```ruby
pod "ShareReader"
```

* ShareReader基于[ShareOne](https://github.com/snaill/ShareOne)库，默认提供分享到微信/QQ的功能，您需要在AppDelegate.m中注册微信/QQ的APP ID

```ruby
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [ShareOne registerWX:@"wx11111"];
    [ShareOne registerQQ:@"22222"];
```
* 为完成分享功能，您还需要调用handle函数

```ruby
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [ShareOne handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [ShareOne handleOpenURL:url];
}
```
* 您需要在需要显示内容的地方引用ShareReader的头文件

```ruby
#import <ShareReader/ShareReader.h>
```

* 最后调用ShareReader完成内容的展示，当然您需要提供您的内容ID，这个ID可以在分享派APP中找到：

```ruby
	UIViewController * vc = [ShareReader readerWithID:@"P-xxxx-xxxx-xxxx-xxxx-xxxxxxx"];
	[self.navigationController pushViewController:vc animated:YES];
```

## Requirements
* iOS 8
* ARC

## License

ShareReader is available under the MIT license. See the LICENSE file for more info.
