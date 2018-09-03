import os
import sys
import json

accounts_path = json.loads(open("/home/jwpyo/blockchain/eth_config/config.json").read())['ACCOUNTS']
filenames = [f for f in os.listdir(sys.argv[1])]

with open(accounts_path, 'w') as accounts:
    for f in filenames:
        account = '0x'+f.split("--")[-1]
        accounts.write(account+'\n')
    accounts.close()
