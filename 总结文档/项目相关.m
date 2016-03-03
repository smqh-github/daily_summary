
何时何处做何事

#pragma mark 导航条和状态栏的设置
1. ios 之后导航条由 navigationBar 进行管理
2. ios 之前状态栏交给 application 进行管理

#pragma mark 追踪用户行为，对用户行为进行分析
1. 使用的是 Google analytic

#pragma mark 判断账号类型
1. 根据账号类型和用户角色进行权限申请

#pragma mark 将字符串转换成二进制数据
 NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil]

#pragma mark 数据的本地化处理
1. 首先将需要保存的对象转化成二进制数据（进行归档操作），然后通过用户偏好设置进行本地化保存，同时记得同步到本地，否则数据容易丢失

#pragma mark 请求权限逻辑
1. getAuth 该方法从服务器端获取权限
2. 从服务器请求权限之后，对请求回来的数据进行分析，从网络请求数据的时候，要给用户联网提示和等待提示。从网络请求回来的数据有两种可能
    1. NSError 类型的对象，如果是这种情况，给用户提示获取权限失败之后之后直接返回即可
    2. 字符串
        1. 首先判断字符串中是否有 “TrainsErrMsgAndroidIOS” 字符串，如果有的话，将返回的字符串交给统一的请求错误类进行解析处理，然后将解析后的结果（model）中的错误信息，弹窗提示给用户。要对各种存在的可能，都进行处理。
        2. 如果不存在上诉字符串，就将返回的字符串交给相应的 Model 类去解析。然后对返回的 Model 中的相关属性进行分析。
            1. 首先判断是否成功属性是不是为 “1”，如果不是的话就弹窗提示用户，提示内容可自定义。
            2. 如果是就说明返回的数据和解析都正确，然后就可以对数据进行进一步操作了，例如，提取字典中的相关键值对。对请求到的数据进行本地化处理。如果请求回来的数据对数据源中的数据有影响，要刷新数据



#pragma mark 添加权限，改动文件列表
1. getAuth 方法中
2. - (void)getImageAndDescription:(NSString *)menuItemName withFunctionType:(NSString *)type


3.- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
    派单管理单数刷新还没做


4. + (void)SHGoToModule:(NSString *)menuItem basedOn:(UINavigationController *)navigationController

5. 通过权限传递获取派单管理红点 数据类型参数5时传1  6时传0



