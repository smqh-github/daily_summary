
#pragma mark 子控件布局相关
// 子控件布局相关
1. 控件在 init 方法中的 frame 全是 0，所以不能在初始化方法中设置控件的frame

2. -(void)layoutSubviews 的调用时机
    1. init 方法不会触发layoutSubviews，但是 initWithFrame 方法会触发
    2. addSubViews 会触发 layoutSubviews
    3. 设置 view 的 Frame 会触发 layoutSubviews，当然前提是 frame 的值设置前后发生了变化
    4. 滚动一个 UIScrollView 会触发 layoutSubviews
    5. 旋转 Screen 会触发父 UIView 上的 layoutSubviews 事件
    6. 改变一个 UIView 大小的时候也会触发父 UIView 上的 layoutSubviews 事件
 注意：
    1. 当我们在某个类的内部调整子视图的时候需要调用，如果是在外部就不需要了
    2. layoutSubviews 方法，默认没有做任何事情，需要我们进行重写
    3. setNeedsLayout：标记为需要重新布局。异步调用 layoutIfNeeded 刷新布局，不立即刷新，但 layoutSubviews 一定会被调用
    4. layoutIfNeeded：如果，有需要刷新的标记，立即调用 layoutSubviews 进行布局（如果没有标记，不会调用 layoutSubviews）
    5. 如果需要立即刷新布局，要先调用 setNeedsLayout 设置需要刷新标记，然后再调用 layoutIfNeeded 进行刷新布局

3. UIView的 setNeedsDisplay 和 setNeedsLayout 方法。
    1. 首先两个方法都是异步执行的。
    2. setNeedsDisplay会调用自动调用drawRect方法，这样可以拿到UIGraphicsGetCurrentContext，就可以画画了。
    3. setNeedsLayout会默认调用layoutSubViews，就可以处理子视图中的一些数据。
    4. 综上所诉，setNeedsDisplay方便绘图，而layoutSubViews方便出来数据。
4. 绘图相关
    1. drawRect:(CGRect)rect方法：重写此方法，执行重绘任务
    2. setNeedsDisplay方法：标记为需要重绘，异步调用 drawRect
    3. setNeedsDisplayInRect:(CGRect)invalidRect方法：标记为需要局部重绘
    4. sizeToFit 会自动调用 sizeThatFits 方法；
    5. sizeToFit 不应该在子类中被重写，应该重写 sizeThatFits
    6. sizeThatFits 传入的参数是 receiver 当前的size，返回一个适合的size
    7. sizeToFit 可以被手动直接调用
    8. sizeToFit 和 sizeThatFits 方法都没有递归，对 subviews 也不负责，只负责自己
注意:
    1. layoutSubviews 对 subviews 重新布局
    2. layoutSubviews 方法调用先于 drawRect（先布局再重绘）
    3. setNeedsLayout 在 receiver 标上一个需要被重新布局的标记，在系统 runloop 的下一个周期自动调用 layoutSubviews
    4. layoutIfNeeded 方法如其名，UIKit会判断该 receiver 是否需要 layout.根据 Apple 官方文档, layoutIfNeeded 方法应该是这样的 layoutIfNeeded 遍历的不是 superview 链，应该是 subviews 链
    5. drawRect 是对 receiver 的重绘，能获得 context
    6. setNeedDisplay 在 receiver 标上一个需要被重新绘图的标记，在下一个draw周期自动重绘，iphone device 的刷新频率是60hz，也就是1/60秒后重绘
5. 后台更新界面和内容
    1. 第一个 API 后台获取 backGroundFetch ,该 API 允许开发者在一个周期间隔后进行特定的动作，如获取网络数据、更新用户界面等等。
    2. 第二个 API 是远程通知（Remote Notification），它是一个新特性，它在当新事件发生时利用推送通知（push Notification）去通知程序。这两个新特性都是在后台进行的，这样更加有利于多任务执行。