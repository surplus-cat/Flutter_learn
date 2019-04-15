新建Flutter项目的结构和原生android的工程结构不一样，
我们不能用android那种多module 多lib的结构去创建module和lib，
因为我们的代码都是在lib目录里面完成的，
除非要用到原生交互的代码，你可以在android目录里面去写，然后在lib目录里面去引用这些交互的代码。

android目录
这里存放的是Flutter与android原生交互的一些代码，这个路径的文件和创建单独的Android项目的基本一样的。不过里面的代码配置跟单独创建Android项目有些不一样。
ios目录

这里存放的是Flutter与ios原生交互的一些代码。

lib目录

这里存放的是Dart语言编写的代码，这里是核心代码。
不管是Android平台，还是ios平台，安装配置好环境，
可以把dart代码运行到对应的设备或模拟器上面。刚才的示例中，就是运行的lib目录下的main.dart这个文件。
我们可以在这个lib目录下面创建不同的文件夹，里面存放不同的文件，使用Dart语言写我们的自己的代码。

pubspec.yaml文件

这个是配置依赖项的文件，比如配置远程pub仓库的依赖库，或者指定本地资源（图片、字体、音频、视频等）。
例如刚才创建的项目的pubspec.yaml里面的：cupertino_icons: ^0.1.2，表示项目要依赖cupertino_icons这个库，版本号为0.1.2。
如果新增package 要 执行 flutter package get来下载