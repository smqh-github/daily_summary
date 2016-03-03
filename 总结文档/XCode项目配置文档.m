
#pragma mark XCode 项目配置说明

// 项目配置：
// 基本项（Basic）

// 1、Architectures(指令集)——设置你想支持的指令集，目前ios的指令集有以下几种：

（1）armv6,支持的机器iPhone,iPhone2,iPhone3G及对应的iTouch 2，
（2）armv7,支持的机器iPhone4,iPhone4S
（3）armv7s,支持的机器iPhone5,iPhone5C
（4）arm64，支持的机器：iPhone5S
//注意：机器对指令集的支持是向下兼容的，因此armv7的指令集是可以运行在iphone5S的，只是效率没那么高而已~

Valid architectures : 指即将编译的指令集。
Build Active Architecture Only : 是否只编译当前适用的指令集。

现在是2014年初，其实4和4S的用户还是蛮多的，而iphone3之类的机器几乎没有了，所以我们的指令集最低必须基于armv7. 因此,Architecture的值选择：armv7 armv7s arm64(选arm64时需要最低支持5.1.1，这块不太明白）
                                                                                                        
1、如果想自己的app在各个机器都能够最高效率的运行，则需要将Build Active Architecture Only改为NO,Valid architectures选择对应的指令集：armv7 armv7s arm64。这个会为各个指令集编译对应的代码，因此最后的 ipa体积基本翻了3倍。（如果不在乎app大小的话，应该这样做）
                                                                                                        
2，如果想让app体积保持最小，则现阶段应该选择Valid architectures为armv7,这样Build Active Architecture Only选YES或NO就无所谓了。
                                                                                                        
// Base SDK ----当前编译用的SDK版本。
                                                                                                        
iPhone OS Deployment Target----指的是编译出的程序将在哪个系统版本上运行。
                                                                                                        
iPhone OS的版本众多，很多用户由于各种各样的原因没有升级到最新版，这就给我们开发者带了麻烦。作为开发者，我们都希望软件的受众越多越好。怎么样让软件尽量适应最多的iPhone OS？
                                                                                                        
这里我们就应该了解iPhone项目的Base SDK和iPhone OS Deployment Target。 Base SDK指的是当前编译用的SDK版本。iPhone OS Deployment Target指的是编译出的程序将在哪个系统版本上运行。
                                                                                                        
用更简单实用的语句描述如下：
                                                                                                        
Base SDK设置为当前xcode所支持的最高的sdk版本，比如"iphone Device 4.0"。iPhone OS Deployment Target设置为你所支持的最低的iPhone OS版本，比如"iPhone OS 3.0"。
                                                                                                        
这样设置之后，你的程序就可以运行于从iPhone OS 3.0 到 4.0的设备之上。当然，前提是你没有用到4.0新加的API。
                                                                                                        
                                                                                                        
2、Build Options:
                                                                                                        
validate Built Product:boolean 类型，指定是否执行产品验证测试（就是说是否使用你的证书进行验证测试）。一般在Debug版本设置成NO，release版本设置成Yes。
                                                                                                        
// 当你使用的证书无效时，常提示错误：
                                                                                                        
warning: Application failed codesign verification. The signature was invalid, contains disallowed entitlements, or it was not signed with an iPhone Distribution Certificate. (-19011)
当然你可以设置成No，不进行验证。
在targets》build setting》validate built Product里面设置release为NO，警告消失。
                                                                                                        
问题描述：在做ios开发过程中，曾多次撤销过原证书，并颁发新的证书。原来使用xcode3也有什么问题，自从使用xcode4之后（本人目前xcode 4.3.2）每次真机测试。连上真机之后，直接调试会报错，提示错误问题就是证书不止一个。错误代码如下：
                                                                                                        
Code Sign error: Certificate identity 'iPhone Developer:******************' appears more than once in the keychain. The codesign tool requires there only be one.
                                                                                                        
解决办法：打开keychain（钥匙串访问）之后，发现多个证书，都是历次请求的证书。把之前的证书全部都干掉，就留下最后一次请求的证书（参考过期日期），之后再次调试可以正常真机测试。

3、Code Signing 代码签名
Code Signing Identity-----代码签名的身份，即选择签名证书，一是开发证书，二是发布证书。
                                                                                                        
开发的时候用Development，比如下模拟器，下真机测试。如果是上传app store 上就应该用Distribution 设置的时候全部统一设置成一样就好了。
                                                                                                        
Code signing 对你来说，最主要的意义就是它能让你的App在设备上运行。不管是你自己的设备，甲方客户的，还是在App store上购买你的消费者。如果没有code signing，你只可以在模拟器上，或者一台越狱过的机器上运行你的应用----当然，仅仅如此是不能满足我们的。模拟器的测试仅仅是一种初步测试，模拟器不能替代真机调试，因为真正的设备会通常比模拟器慢。模拟器使用的是你的MAC机上的处理器，而一台真正的iphone可远远没有这种条件。所以如果你不在设备上真正运行，你可能就会忽略实际的性能问题。

4、Search Paths 查询路径
                                                                                                        
Always Search User Paths --- 是否搜索用户路径
                                                                                                        
Xcode Header Path的设置 Header Search Paths是一定会去搜索的。 而UserHeader Search Paths只有在Always Search User Paths为Yes时才会被搜索。
                                                                                                        
Header Search Paths (HEADER_SEARCH_PATHS) ------This is a list of paths to folders to be searched by the compilerfor included or imported header files when compiling C,Objective-C, C++, or Objective-C++ source files.
                                                                                                        
Library Search Paths (LIBRARY_SEARCH_PATHS) -------This is a list of paths to folders to be searched by the linker forstatic and dynamic libraries used by the product.
                                                                                                        
Framework Search Paths (FRAMEWORK_SEARCH_PATHS) -------This is a list of paths to folders containing frameworks to besearched by the compiler for both included or imported header fileswhen compiling C, Objective-C, C++, or Objective-C++, and by thelinker for frameworks used by the product.
                                                                                                        
Rez Search Paths (REZ_SEARCH_PATHS) ----This is a list of paths to search for files included by CarbonResource Manager resources and compiled with the Rez tool.
                                                                                                        
5、Apple LLVM5.0 -Language - ObjectC
其中，Objective-C Automatic Reference Counting 设置ObejctC 是否使用ARC技术。
                                                                                                        
该机能在 iOS 5/ Mac OS X 10.7 开始导入，利用 Xcode4.2 可以使用该机能。简单地理解ARC，就是通过指定的语法，让编译器(LLVM 3.0)在编译代码时，自动生成实例的引用计数管理部分代码。有一点，ARC并不是GC，它只是一种代码静态分析（Static Analyzer）工具。
                                                                                                        
详细参考：http://blog.csdn.net/zkdemon/article/details/7446385
                                                                                                        
