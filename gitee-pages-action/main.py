import os.path
import sys
from action import Action
import yaml

# 原项目https://github.com/yanglbme/gitee-pages-action （无须人为干预，由 GitHub Actions 自动部署 Gitee Pages）
# 版权归原作者所有https://github.com/yanglbme

def checkFields(fields, object):
    for field in fields:
        if field not in object or object[field] is None:
            print('Not found field: '+field)
            sys.exit(1)

config_file = '_config.yml'

if not os.path.isfile(config_file):
    print('Not found file: '+config_file)
    sys.exit(1)

# 读取配置文件文件
with open(config_file, 'r', encoding='utf-8') as f:
    cfg = yaml.load(f.read(), Loader=yaml.SafeLoader)
    # print(cfg)

    checkFields(['username', 'password', 'repo', 'branch', 'directory', 'https'], cfg)

    username = cfg['username']
    password = cfg['password']
    repo = cfg['repo']
    branch = cfg['branch']
    directory = cfg['directory']
    https = cfg['https']

    print('Username: '+username)
    print('Repo: '+repo)
    print('Branch: '+branch)
    print('Directory: '+directory)
    print('Force Https: '+str(https))
    print('--------------------')

    try:
        print('Logining..')
        action = Action(username, password, repo, branch, directory, 'true' if https else 'false')

        action.login()
        print('Login successfully')

        action.rebuild_pages()
        print('Rebuild Gitee Pages successfully')

        print('Success, thanks for using @yanglbme/gitee-pages-action!')
    except Exception as e:
        print(str(e))
        sys.exit(1)
