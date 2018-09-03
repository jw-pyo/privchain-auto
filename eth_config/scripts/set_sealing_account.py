import os
import sys
import json

CONFIG = json.loads(open(os.path.abspath('')+"/eth_config/config.json").read())
accounts_path = CONFIG['ACCOUNTS']
genesis_path = CONFIG['GENESIS_JSON']
account_list = None
account_stream = ''
with open(accounts_path, 'r') as accounts:
    account_list = accounts.read().split("\n")
    for account in account_list:
        account_stream += account[2:]

GENESIS = None
with open(genesis_path, 'r') as genesis:
    GENESIS = json.loads(genesis.read())
    genesis.close()

GENESIS["extraData"] = "0x"+"0"*64 + account_stream + "0"*130
with open(genesis_path, 'w') as genesis:
    genesis.write(json.dumps(GENESIS, indent=4))
    genesis.close()
    print("{} updated. ".format(genesis_path))
