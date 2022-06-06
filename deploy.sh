dfx stop

dfx start --clean --background

dfx deploy cap

dfx canister --no-wallet create --all

dfx build

OWNER="principal \"$( \
   dfx identity get-principal
)\""

CAP_ID="principal \"$( \
   dfx canister --no-wallet id cap
)\""

BALL_ID="principal \"$( \
   dfx canister --no-wallet id ball_coin
)\""

NFT_ID="principal \"$( \
   dfx canister --no-wallet id player_nft
)\""

dfx canister --no-wallet install ball_coin --argument="(\"\", \"Ball Coin\", \"\$BALL\", 3, 1000000, $OWNER, 1, $OWNER, 10.0, $OWNER, $CAP_ID, $NFT_ID)"

dfx canister --no-wallet install wicp --argument="(\"\", \"wicp\", \"WICP\", 3, 1000000, $OWNER, 1, $OWNER, $CAP_ID)"

dfx canister --no-wallet install player_nft --argument "($OWNER, \"BSKT\", \"Basketball game\", $CAP_ID, $BALL_ID)"

echo
echo Make passed/given 1st plug wallet account \(user\) an admin
echo
eval dfx canister --no-wallet call player_nft add_admin "'(principal \"${1}\")'"

echo
echo Transfer 10000 \$BALL coin to 2nd passed/given plug wallet account
echo
eval dfx canister --no-wallet call ball_coin transfer "'(principal \"${2}\", 10_000)'"
