#!/bin/bash
USER_NAME=`jq -r '.USER_NAME' eth_config/config.json`
DATADIR=`jq -r '.DATADIR' eth_config/config.json`
CONFIG=`jq -r '.CONFIG' eth_config/config.json`
GENESIS_JSON=`jq -r '.GENESIS_JSON' eth_config/config.json`
PASSWORD=`jq -r '.PASSWORD' eth_config/config.json`
ACCOUNTS=`jq -r '.ACCOUNTS' eth_config/config.json`


## USAGE: sh poa.sh --bootnode
## make this container as bootnode
if [ $1 == '--bootnode' ]
then
    echo "NotImplemented"
fi
## USAGE: sh poa.sh --node
## make genesis block and start node

if [ $1 == '--node' ]
then
    # generate genesis block
    geth --datadir $DATADIR init $GENESIS_JSON

    #execute geth node
    geth --datadir $DATADIR --syncmode "full" --port $PORT --rpc --rpcaddr $IP --rpcport $RPCPORT --rpcapi 'personal,db,eth,web3,miner,txpool' --bootnodes 'enode://9de8cb8e69385c2dd2e49aa78b77a1377e885516dcdd0096c75a0d2411b261346bfa2d28c2e912367422e98f0343d76b7c3ce396f64e4272738e6f94edc2a49a@147.47.206.13:30310' --networkid 2018 --gasprice '0' --unlock '0x61b6278f505f7f6108429d277cc2fb89ee9b853d' --password $PASSWORD --mine console
fi

## USAGE: sh poa.sh --account {num}
## make multiple accounts

if [ $1 == '--account' ]
then
    if ! [ -z "$2" ]
    then
    # create new account(only first time)
        counter=0
        while [ $counter -lt $2 ]
        do
            echo 'Account #'$counter 'created'
            geth --datadir $DATADIR account new --password $PASSWORD
            ((counter++))
        done
    fi
    # make list of accounts
    python $CONFIG/scripts/make_account_list.py $DATADIR/keystore
fi
