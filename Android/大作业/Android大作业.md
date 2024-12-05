# 报告

### 1. 概述

该APP是一款基于Kotlin语言开发的个人笔记和新闻查看APP。它允许用户记录学习笔记、浏览科技类新闻。APP的目标用户是需要管理笔记和浏览新闻的个人用户。该APP的特点包括简洁的用户界面、易于使用的功能和快速的性能。

### 2. 功能点描述

该APP的主要功能点包括以下几个方面：

#### 2.1 笔记功能

- 用户可以创建、编辑、查看和删除笔记。
- 用户可以在笔记中添加文本、图片，其中图片可以选择调用摄像头上传或者从相册中选取。

#### 2.2 新闻功能

- 用户可以查看最新的新闻列表。
- 用户可以点击对应新闻进入官网网站浏览阅读。

### 3. 实现步骤

APP的实现步骤可以分为以下几个方面：

#### 3.1 UI设计

- 确定APP的界面设计。
  - 笔记页面布局设计
  - 新闻页面布局设计
  - 菜单设计
- 设计APP的交互流程。
  - 设置点击事件

- 实现UI设计，包括图标、颜色和字体等。

#### 3.2 数据库设计

sqlite数据库存储

- 设计APP的数据库结构。
- 实现数据库表格和字段。

#### 3.3 功能实现

- 实现笔记功能，包括创建、编辑和删除笔记，添加文本、图片。
- 实现新闻功能，包括查看新闻列表，选择新闻进行阅读。

### 4. 关键程序代码

以下是该APP的一些关键程序代码示例：

#### 4.1 初始化笔记

![image-20230503152003350](https://image.kmoon.fun//images/202305031520441.png)

定义一个名为 `initNotes()` 的私有函数，其目的是从 SQLite 数据库中读取“Note”表中的记录，并将它们添加到 `noteList` 中。

在函数中，首先创建一个 `db` 对象，它是由 `dbHelper` 中的 `writableDatabase` 方法返回的。接下来，使用 `query()` 方法从“Note”表中检索数据，并将结果存储在名为 `cursor` 的 `Cursor` 对象中。使用 `null` 作为参数表示检索所有列和行，不进行任何筛选或排序，但按 `id DESC` 的顺序排序。

接下来，如果 `cursor` 可以移动到第一行（即，如果有记录），则通过循环遍历所有行。对于每行记录，从 `cursor` 中检索 `id` 和 `title` 列，并将它们用于创建一个新的 `Note` 对象。然后将该 `Note` 对象添加到 `noteList` 中，这是一个可变的列表（`MutableList`），它在此函数之外定义。

最后，关闭 `cursor` 和 `db` 对象，以确保释放相关资源。

#### 4.2 listview点击事件

![image-20230503152031054](https://image.kmoon.fun//images/202305031520091.png)

创建一个 `NoteAdapter` 对象 `adapter`，并将其设置为 `listView` 的适配器。`NoteAdapter` 是一个自定义适配器，其构造函数需要三个参数：上下文（`Context`）、布局资源 ID（`Int`）和 `noteList` 列表。使用 `this` 作为上下文、`R.layout.note_item` 作为布局资源 ID、`noteList` 作为列表。

接下来，设置 `listView` 的 `OnItemClickListener`，当用户点击列表项时触发。这里使用了两个 Lambda 表达式，第一个参数包括 `parent`、`view`、`position` 和 `id`，但没有执行任何操作。第二个 Lambda 表达式只包含 `position`，当用户点击列表项时，该表达式会从 `noteList` 中获取相应位置的 `Note` 对象，并将其存储在 `new` 变量中。然后，它创建一个带有 `id` 数据的 `Intent`，并使用 `startActivity()` 方法启动一个名为 `ReadActivity` 的活动（Activity）。

最后，在点击列表项时，会显示一个短时长的提示消息“正在加载”，这是使用 `Toast` 创建的。这个提示消息会在屏幕上显示一小段时间，然后消失。

#### 4.3 webview实现

![image-20230503152239045](https://image.kmoon.fun//images/202305031522075.png)

定义了一个名为 `WebviewActivity` 的类，它是 `AppCompatActivity` 类的子类，用于显示一个包含网页的 `WebView` 视图。

在 `onCreate` 方法中，首先调用父类的 `onCreate` 方法，然后使用 `setContentView` 方法设置布局资源 ID。在这个例子中，使用 `R.layout.activity_main_web` 作为布局资源 ID，这意味着将显示一个包含 `WebView` 的界面。

接下来，从传递给活动的 `Intent` 中检索 `url` 字符串，这是使用 `getStringExtra` 方法完成的。`url` 字符串包含将要在 `WebView` 中显示的网址。

然后，启用 `webView` 的 JavaScript 支持，这是使用 `setJavaScriptEnabled` 方法完成的。如果您要在 `WebView` 中运行 JavaScript 代码，必须启用该选项。

接下来，为 `webView` 设置一个 `WebViewClient`，这是一个处理 `WebView` 内容的基本客户端。如果您不设置 `WebViewClient`，则默认情况下，点击 `WebView` 中的链接将打开默认浏览器。

最后，使用 `loadUrl` 方法加载从 `Intent` 中检索的 `url` 字符串。这将使 `WebView` 加载指定的网址并显示其内容。

#### 4.4 多媒体实现

![image-20230503152339715](https://image.kmoon.fun//images/202305031523770.png)



在点击事件监听器中，首先创建一个名为 `outputImage` 的 `File` 对象，用于存储拍摄的照片。使用 `externalCacheDir` 作为文件存储位置，并将照片文件命名为 `"image_"+count+".jpg"`。如果该文件已经存在，则使用 `count` 变量自增，并创建一个新的文件名。接着，使用 `createNewFile` 方法创建一个新的照片文件。

然后，使用 `FileProvider.getUriForFile` 或 `Uri.fromFile` 方法，根据 Android 版本的不同，为照片文件生成相应的 `Uri` 对象。使用 `ContextCompat.checkSelfPermission` 方法检查相机权限是否已被授权。如果没有授权，则使用 `ActivityCompat.requestPermissions` 方法请求授权。如果已经授权，则创建一个名为 `intent` 的 `Intent` 对象，设置拍照的动作为 `android.media.action.IMAGE_CAPTURE`，并将照片文件的 `Uri` 添加为额外的输出参数。最后，使用 `startActivityForResult` 方法启动相机应用程序，并指定 `takePhoto` 作为请求代码（requestCode）。

当相机应用程序拍摄完照片并返回时，`onActivityResult` 方法将被调用，以便在主应用程序中获取拍摄的照片。

### 5. 运行界面展示

以下是该APP的运行界面展示：

<img src="https://image.kmoon.fun//images/202304262121553.png" alt="uTools_1682514890507" style="zoom: 67%;" />

<img src="https://image.kmoon.fun//images/202304262121566.png" alt="uTools_1682514858614" style="zoom: 67%;" />



<img src="https://image.kmoon.fun//images/202304262121573.png" alt="uTools_1682514787637" style="zoom: 67%;" />



<img src="https://image.kmoon.fun//images/202304262121590.png" alt="uTools_1682514955150" style="zoom: 67%;" />

<img src="https://image.kmoon.fun//images/202304262121570.png" alt="uTools_1682514924040" style="zoom: 67%;" />

<img src="https://image.kmoon.fun//images/202304262121584.png" alt="uTools_1682514908340" style="zoom:67%;" />



