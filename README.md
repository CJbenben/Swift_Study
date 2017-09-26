#### 20170926更新
随着 iPhone 8+ 的发布，xcode9带来了 swift4.0，在兼容 swift4.0 的过程中：出现以下问题。
- when calling this function in Swift 4 or later, you must pass a '()' tuple; did you mean for the input type to be '()'?
    lazy var asHTML: (Void) -> String
![16自动引用计数部分](http://upload-images.jianshu.io/upload_images/674752-d47a979c4fcf2f61.png)

![21扩展部分](http://upload-images.jianshu.io/upload_images/674752-b7d4a0e4133bfb8d.png)
***
Swift_Study 为根据中文版 swift3.0.1 版本翻译成代码篇。仅为日后 swift 版本迭代更新、学习使用。