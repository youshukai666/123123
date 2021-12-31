# StaticServerForPages

项目简介：利用Pages服务来部署更新助手的静态服务端

使用前提，确保你满足以下几点要求，否则不推荐使用本项目：

1. 了解Git的基本操作（提交、推送、简单分支管理，合并提交）
2. 阅读过静态服务端搭建教程（因为本项目是基于更新助手的静态服务端搭建的）
3. 电脑上安装有Python3和Git
4. 基础的英文阅读能力
5. 使用正式版客户端3.1.3或以上版本；或者使用Jar版客户端1.0.0或以上版本

## 文件说明

| 文件               | 描述                                                         |
| ------------------ | ------------------------------------------------------------ |
| gitee-pages-action | 一个开源项目，用来自动更新GiteePages                         |
| update             | 更新助手的静态服务端文件                                     |
| .nojekyll          | **不能删除**，否则可能无法访问带有下划线`_`的文件            |
| index.html         | **不能删除**，否则Pages站点可能无法正常访问（这是GiteePages的要求） |
| README.md          | 本文件（对，就是你正在看的这个文件）                         |
| Tool-v3.1.3.exe    | 静态服务端的小工具，用来生成校验文件                         |
| 仅更新Pages.bat    | 双击运行，用来更新GiteePages（GithubPages不需要更新）        |
| 仅更新校验文件.cmd | 双击运行，用来更新校验文件                                   |
| 仅提交Git.cmd      | 双击运行，用来提交Git修改（也可以自己手动提交Git）           |

## 使用限制

1. GiteePages的更新有1分钟冷却时间，不要频繁部署/更新。GithubPages无此限制
2. Gitee仓库单文件大小限制为50Mb（免费版），如果仓库里有超过50Mb的文件可能会提交失败
3. Gitee单个仓库容量限制为500Mb（免费版），总提交超过此大小可能推送失败
4. 受仓库容量限制，请不定期使用rebase命令整理/合并提交，否则可能会超出仓库容量限制推送失败
5. 本项目不支持GitLFS

## 使用教程

1. Fork本项目并Clone到本地
2. 将要参与更新文件，比如模组文件等，复制到`update/res/.minecraft/mods/`里面（`res/.minecraft/mods/`目录请自行创建）
3. 将其它要参与更新的文件同样按上面的方法，复制到对应的目录上（比如Vexview的贴图复制到`update/res/.minecraft/vexview/textures/`下）
4. 编辑服务端配置文件`update/index.yml`，具体方法参考[静态服务端安装教程](https://updater-for-minecraft.gitee.io/docs-mirror/#/StaticServerInstallation)
5. 双击运行`仅更新校验文件.cmd`来生成/更新`res.yml`校验文件
6. 然后提交Git，双击运行`仅提交Git.cmd`来一键提交并推送Git。当然也不一定非得用这个脚本，也可以手动使用命令行，或者用图形化Git客户端来提交并推送到远端，以代替执行这个脚本
7. 然后请根据你使用的Git服务提供商，继续阅读下面对应的教程章节

### Gitee

1. 在使用GiteePages要曾经有过成功部署GiteePages的记录。在仓库的**服务**页面，找到**Gitee Pages**，设置好后点击**启动/更新**按钮，就算完成了第一次GiteePages的部署。此步骤只需要手动操作一次，后面会使用开源的[gitee-pages-action](https://github.com/yanglbme/gitee-pages-action)项目来代替我们完成这个操作
2. 接着配置GiteePages的自动化刷新功能，打开`gitee-pages-action`目录
3. 重命名`_config.exam.yml`为`_config.yml`并打开编辑`_config.yml`
4. 按下面的表格填写`_config.yml`并保存关闭，请确保下面的信息填写准确，不能有任何错误，也不能留空，如果要填写空字符串，请使用`''`代替。如果填写信息有误，可能会导致Pages出现404无法访问的情况

| 配置项    | 描述                                 | 实例              |
| --------- | ------------------------------------ | ----------------- |
| username  | Gitee 用户名                         | asforest          |
| password  | Gitee 密码（明文）                   | 123456            |
| repo      | Gitee 完整仓库名（包严格区分大小写） | asforest/ssfp     |
| branch    | 要部署的分支（分支必须存在）         | main              |
| directory | 要部署的分支上的目录                 | 一般留空或者`src` |
| https     | 是否强制使用 HTTPS                   | true/false        |

5. 注意：虽然`_config.yml`文件默认已经被添加到了`.gitignore`里，但千万不要手贱把`_config.yml`文件给提交推送了，这个文件包含你的用户名和明文密码，泄露可能会造成非常严重的后果（建议专门开个Gitee小号来做文件更新的推送）
6. 运行`仅更新Pages.bat`（第一次运行可能需要安装virtualenv和一些依赖（默认使用清华源）），就会自动提交当前仓库的修改了，然后会自动更新Pages，有关Pages的一些限制，请往下阅读
7. 将`https://<asforest>.gitee.io/<ssfp>/update/index.yml`粘贴到客户端配置文件里，记得把`<asforest>`换成你自己的用户名，把`<ssfp>`换成你实际的仓库名
8. 启动客户端测试

### Github

Github不像Gitee在每次推送后要主动点击Pages更新按钮，Github会在每次推送时自动更新。所以每次推送后不需要做额外的操作，就能马上看到效果

开启GithubPages的步骤也非常简单：打开仓库页面，点击`Settings`，点击左侧的`Pages`，将Source下面的None切换为main或者master，然后将后面的文件夹选项改为`/(root)`，点击`Save`按钮，即可开启Pages服务

## GiteePages的问题

> 本章节内容大部分参考自[gitee-pages-action](https://github.com/yanglbme/gitee-pages-action)原项目中的README文件

如果GiteePages一切配置正常，且正常更新了Pages，我们会在 Gitee 公众号收到一条登录通知。这是 Gitee Pages Action 程序帮我们登录到 Gitee 官网，并为我们点击了项目的部署按钮

如果输出的最后几行是这样，那么就代表Pages更新成功了

```
Rebuild Gitee Pages successfully
Success, thanks for using @yanglbme/gitee-pages-action!
```

如果发生错误，请按下面的错误及解决方案来排查问题：

| #    | 错误                                                         | 解决方案                                                     |
| ---- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 1    | Error: Wrong username or password, login failed .            | 帐号或密码错误，请检查参数 `gitee-username`、`gitee-password`是否准确配置。 |
| 2    | Error: Need captcha validation, please visit https://gitee.com/login, login to validate your account. | 需要图片验证码校验。可以手动登录 Gitee 官方，校验验证码。    |
| 3    | Error: Need phone captcha validation, please follow wechat official account "Gitee" to bind account to turn off authentication. | 需要短信验证码校验。可以关注 Gitee 微信公众号，并绑定 Gitee 帐号，接收登录提示。[#6](https://gitee.com/link?target=https%3A%2F%2Fgithub.com%2Fyanglbme%2Fgitee-pages-action%2Fissues%2F6) |
| 4    | Error: Do not deploy frequently, try again one minute later. | 短期内频繁部署 Gitee Pages 导致，可以稍后再触发自动部署。    |
| 5    | Error: Deploy error occurred, please check your input `gitee-repo`. | `gitee-repo` 参数格式如：`doocs/leetcode`，并且严格区分大小写，请准确填写。[#10](https://gitee.com/link?target=https%3A%2F%2Fgithub.com%2Fyanglbme%2Fgitee-pages-action%2Fissues%2F10) |
| 6    | Error: Unknown error occurred in login method, resp: ...     | 登录出现未知错误，请在 [issues](https://gitee.com/link?target=https%3A%2F%2Fgithub.com%2Fyanglbme%2Fgitee-pages-action%2Fissues) 区反馈。 |
| 7    | Error: Rebuild page error, status code: xxx                  | 更新 Pages 时状态码异常，请尝试再次触发 Action 执行。也可能为 gitee pages 未初始化，第一次需要手动部署 gitee pages。 |
| 8    | Error: HTTPSConnectionPool(host='gitee.com', port=443): Read timed out. (read timeout=6)  Error: HTTPSConnectionPool(host='gitee.com', port=443): Max retries exceeded with url: /login (Caused by ConnectTimeoutError(<urllib3.connection.HTTPSConnection object at 0x7f6c889d42e8>, 'Connection to gitee.com timed out. (connect timeout=6)')) | 网络请求出错，请尝试 Re-run jobs 。[#27](https://gitee.com/link?target=https%3A%2F%2Fgithub.com%2Fyanglbme%2Fgitee-pages-action%2Fissues%2F27) |
| 9    | [git@github.com](mailto:git@github.com): Permission denied (publickey). fatal: Could not read from remote repository. Please make sure you have the correct access rights and the repository exists.. | SSH 公私钥配置有问题，或是使用了带密码的私钥，请参照上文提及的密钥配置步骤进行相应配置。[#29](https://gitee.com/link?target=https%3A%2F%2Fgithub.com%2Fyanglbme%2Fgitee-pages-action%2Fissues%2F29) |
| 10   | Hexo Gitee Pages 自动部署站点问题。                          | [@No5972](https://gitee.com/link?target=https%3A%2F%2Fgithub.com%2FNo5972) 详细给出了一种解决方案。[#34](https://gitee.com/link?target=https%3A%2F%2Fgithub.com%2Fyanglbme%2Fgitee-pages-action%2Fissues%2F34) |