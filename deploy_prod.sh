dfx stop

dfx start --clean --background

dfx canister --network ic --no-wallet create --all

dfx build

OWNER="principal \"$( \
   dfx identity --network ic get-principal
)\""

CAP_ID="principal \"lj532-6iaaa-aaaah-qcc7a-cai\""

BALL_ID="principal \"$( \
   dfx canister --network ic --no-wallet id ball_coin
)\""

NFT_ID="principal \"$( \
   dfx canister --network ic --no-wallet id player_nft
)\""

dfx canister --network ic --no-wallet install ball_coin --argument="(\"data:image/jpeg;base64,$(base64 ./ball-coin-logo.png)\", \"Ball Coin\", \"\$BALL\", 3, 1000000, $OWNER, 1, $OWNER, 1.0, $OWNER, $CAP_ID, $NFT_ID)" --mode=reinstall

dfx canister --network ic --no-wallet install wicp --argument="(\"\", \"wicp\", \"WICP\", 3, 1000000, $OWNER, 1, $OWNER, $CAP_ID)" --mode=reinstall

dfx canister --network ic --no-wallet install player_nft --argument "($OWNER, \"BSKT\", \"Basketball game\", $CAP_ID, $BALL_ID)" --mode=reinstall

echo
echo Transfer 1000 \$BALL coin to passed/given plug wallet account
echo
eval dfx canister --network ic --no-wallet call ball_coin transfer "'(principal \"${1}\", 1000)'"
