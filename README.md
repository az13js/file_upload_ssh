# 文件同步与发布脚本

`upload.sh`用来把本地文件上传到服务器。`setup.sh`是服务器上面执行的定时检查的脚本，检查到文件后会解压并复制覆盖到已有的文件内。两个脚本都会删除临时文件。支持`Linux`系统。
