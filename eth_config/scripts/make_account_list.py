import os
import sys
import json

CONFIG = open(os.path.abspath('')+"/eth_config/config.json").read()
accounts_path = json.loads(CONFIG)['ACCOUNTS']
filenames = [f for f in os.listdir(json.loads(CONFIG)['KEYSTORE'])]

with open(accounts_path, 'w') as accounts:
    for f in filenames:
        account = '0x'+f.split("--")[-1]
        accounts.write(account+'\n')
    accounts.close()

with open(accounts_path, 'r') as accounts:
    account_list = accounts.read().split("\n")
    account_list[0]
