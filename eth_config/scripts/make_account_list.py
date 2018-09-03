import os
import sys
import json

CONFIG = json.loads(open(os.path.abspath('')+"/eth_config/config.json").read())
accounts_path = CONFIG['ACCOUNTS']
filenames = [f for f in os.listdir(CONFIG['KEYSTORE'])]
account_list = None
with open(accounts_path, 'w') as accounts:
    for f in filenames:
        account = '0x'+f.split("--")[-1]
        accounts.write(account+'\n')
    accounts.close()

with open(accounts_path, 'r') as accounts:
    account_list = accounts.read().split("\n")

CONFIG['SEAL_ACCOUNTS'] = []
for acc in account_list:
    CONFIG['SEAL_ACCOUNTS'].append(acc)
CONFIG['SEAL_ACCOUNTS'].remove("")
with open(os.path.abspath('')+"/eth_config/config.json", 'w') as config_new:
    config_new.write(json.dumps(CONFIG, indent=4))
    config_new.close()
    print("Account List Renewed on eth_config/accounts.txt")

