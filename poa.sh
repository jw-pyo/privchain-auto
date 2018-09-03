#!/bin/bash
USER_NAME=`jq -r '.USER_NAME' eth_config/config.json`
DATADIR=`jq -r '.DATADIR' eth_config/config.json`
CONFIG=`jq -r '.CONFIG' eth_config/config.json`
GENESIS_JSON=`jq -r '.GENESIS_JSON' eth_config/config.json`
PASSWORD=`jq -r '.PASSWORD' eth_config/config.json`
ACCOUNTS=`jq -r '.ACCOUNTS' eth_config/config.json`
RPCPORT=`jq -r '.RPC_PORT' eth_config/config.json`
PORT=`jq -r '.PORT' eth_config/config.json`
IP=`jq -r '.IP' eth_config/config.json`


## USAGE: sh poa.sh --bootnode
## make this container as bootnode
if [ $1 == '--help' ]
then
    echo "sh poa.sh --help"
    echo "sh poa.sh --clear"
    echo "sh poa.sh --bootnode"
    echo "sh poa.sh --node"
    echo "sh poa.sh --node --no-bootnode"
    echo "sh poa.sh --init"
    echo "sh poa.sh --account [NUM]"
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
    python $CONFIG/scripts/make_account_list.py
fi

## USAGE: sh poa.sh --bootnode
## make this container as bootnode
if [ $1 == '--bootnode' ]
then
    echo "NotImplemented"
fi

## USAGE: sh poa.sh --clear
## delete the geth datadir
if [ $1 == '--clear' ]
then
    sudo rm -r $DATADIR/geth && sudo rm $DATADIR/history
fi

## USAGE: sh poa.sh --init
## make genesis block through genesis json file
if [ $1 == '--init' ]
then
    # generate genesis block
    geth --datadir $DATADIR init $GENESIS_JSON
fi

## USAGE: sh poa.sh --node
## make genesis block and start node
if [ $1 == '--node' ]
then
    if [ $2 == '--no-bootnode' ]
    then
        #execute geth node
        geth --datadir $DATADIR --syncmode 'full' --rpccorsdomain '*' --rpc --rpcaddr $IP --rpcport $RPCPORT --rpcapi 'personal,db,eth,web3,miner,txpool' --port $PORT --networkid 2018 --gasprice '0' --unlock '0x48ceeab4d02b5478e52fa8f39ec08a5fe770545e' --password $PASSWORD --mine console
    else
        #execute geth node
        geth --datadir $DATADIR --syncmode "full" --port $PORT --rpc --rpcaddr $IP --rpcport $RPCPORT --rpcapi 'personal,db,eth,web3,miner,txpool' --bootnodes 'enode://9de8cb8e69385c2dd2e49aa78b77a1377e885516dcdd0096c75a0d2411b261346bfa2d28c2e912367422e98f0343d76b7c3ce396f64e4272738e6f94edc2a49a@147.47.206.13:30310' --networkid 2018 --gasprice '0' --unlock '0x48ceeab4d02b5478e52fa8f39ec08a5fe770545e' --password $PASSWORD --mine console
    fi
fi

