
安装`docker-compose`

1. 安装标准版本`docker-compose`

```shell
# 输入
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 输出
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   638  100   638    0     0    127      0  0:00:05  0:00:05 --:--:--   181
100 11.6M  100 11.6M    0     0   294k      0  0:00:40  0:00:40 --:--:--  314k
```

2. 授权权限

```shell 
# 输入
$ sudo chmod +x /usr/local/bin/docker-compose
```

3. 安装完成确认版本

```shell 
# 输入
$ docker-compose --version

# 输出
docker-compose version 1.26.2, build eefe0d31
```

显示版本即表示已经完成安装。
