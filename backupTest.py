# !/usr/bin/python
# coding=utf-8

import os

import time


# 列出需要备份的文件路径,用列表存放
needBackupSource = ['/Users/gaoqinghua/Desktop/test_backup','/Users/gaoqinghua/Desktop/card']
targetBackupPath = '/Users/gaoqinghua/Desktop/backup/'
targetBackupPath_fileName = targetBackupPath + time.strftime('%Y%m%d%H%M%S') + '.zip'
print 'targetBackupPath_fileName = ',targetBackupPath_fileName

zip_command = 'zip -qr "%s" %s' % (targetBackupPath_fileName,' '.join(needBackupSource))
print 'zip_command = ',zip_command

# wget命令
# url_source = 'http://img.xmpig.com/forum/201610/20/201816z4zvp3zov8vtpp5g.jpg'
# wget_command = 'wget "%s"' % ('http://img.xmpig.com/forum/201610/20/201816z4zvp3zov8vtpp5g.jpg',)
# print 'wget_command = ', wget_command

#运行脚本命令
if os.system(zip_command) == 0:
    print '备份成功'

else:
    '备份失败'
