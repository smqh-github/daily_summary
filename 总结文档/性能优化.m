

# 图片优化先关
    1. 优先使用[UIImage imageNamed:@""]；
    与[[UIImage alloc] initWithContentsOfFile:] 和 [UIImage alloc [initWithData:]] 相比，[UIImage imageNamed:]有着更好的效率，这是因为 iOS 会自带 cache 通过 [UIImage imageNamed:] 载入的图像，但该方法有一个缺点，那就是只能载入应用程序 bundle 中的图像，像网络下载的图像就无能无力了。我习惯的做法是自定义一个 ImageCache 类，自己来 cache 图像。

    2. 尽量不要使用全屏大小的背景图片；使用 gradient 图片来取代硬编码的 gradient；gradient 图片应当尽可能窄，然后将之拉伸运用到实际场合中去。

    3. 对于结构复杂的 View，使用 drawRect 自绘而不是从 nib 中载入

    4. 对于 TableView，重用 cell；减少 cell 初始化的工作量，延迟装载；定制复杂 cell 时，使用 drawRect 自绘；Cache 尽可能多的东西，包括 cell 高度；尽可能让 cell 不透明；避免使用图像特性，比如 gradients。

    5. 不要在 viewWillAppear 中做费时的操作。
    viewWillAppear: 在 view 显示之前被调用，出于效率考虑，在这个方法中不要处理复杂费时的事情；只应该在这个方法设置 view 的显示属性之类的简单事情，比如背景色，字体等。要不然，用户会明显感觉到 view 显示迟钝。

    6. 使用多线程来延迟加载资源。比如常见的 TableViewCell 中的网络图像显示，先使用一个默认图像，然后开启线程下载网络图像，当图像下载完成之后，再替换默认图像。

    7. 关于后台任务
    系统进入 background 之后，一般只有10分钟的运行时间，因此有很多值得注意的事项：

    a) 尽量减少内存的使用。当内存不足时，iOS将kill那些消耗内存最多的 App。
    b) 释放所有的共享资源，比如 Calendar 与 Address book。当应用程序进入后台时，如果它还在使用或没有释放共享资源，iOS会立即kill掉该应用程序。
    c) 正确处理App生命周期事件。当进入后台时，应该保持应用程序数据，以便回到前台时能够恢复。当进入 inactive 状态时，应该暂停当前的业务流。iOS运行App在后台运行的时间有限，因此后台代码不应该执行非常耗时的任务，可能的话就使用多线程。当进入后台 时，iOS会保存当前App的一个快照，以便之后在合适的时候（装载view和数据时）呈现给用户以提高用户体验，因此在进入后台时，应该避免在屏幕上呈 现用户信息，以免泄露用户个人资料。
    d) 不要更新UI或者执行大量消耗CPU或电池的代码。进入后台之后，不应该执行不必要的任务，不要执行 OpenGL ES 调用，应取消 Bonjour 相关的服务，正确处理网络链接失败，避免更新 UI，清除所有的警告或其他弹出对话框。
    e) 保证后台代码的执行工作正常，注意处理异常。
    f) 在后台时正确响应系统变化。 如： 设备旋转消息UIDeviceOrientationDidChangeNotification ，重要的时间变化（新的一天开始或时区变化）UIApplicationSignificantTimeChangeNotification ，电池变化UIDeviceBatteryLevelDidChangeNotification 和 UIDeviceBatteryStateDidChangeNotification，用户默认设置变化 NSUserDefaultsDidChangeNotification，本地化语言变化 NSCurrentLocaleDidChangeNotification 等。

    8. 如果一个方法在一个循环次数非常多的循环中使用，在进入循环前使用 methodForSelector 获取该方法 IMP，然后在循环体中直接使用该 IMP。

    9. 提高 APP 加载速度
    避免使用静态初始化，包括静态c++对象，加载时会运行的代码，如+(void) load{} ，会造成在Main函数之前运行额外的代码。

    10. 利用 cache 空间换时间。cache 是一种常见的空间换时间的提供性能的收到，可以用在相当多的场合。
    尽量 cache 那些可重复利用的对象，比如 table cell，date/number formatters，正则表达式，sqlite语句等、