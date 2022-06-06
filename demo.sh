# clear
dfx stop
rm -rf .dfx


eval dfx identity new ALICE
eval dfx identity use ALICE
ALICE_PUBLIC_KEY="principal \"$( \
    dfx identity get-principal
)\""

eval dfx identity new BOB
eval dfx identity use BOB
BOB_PUBLIC_KEY="principal \"$( \
    dfx identity get-principal
)\""

eval dfx identity new DAN
eval dfx identity use DAN
DAN_PUBLIC_KEY="principal \"$( \
    dfx identity get-principal
)\""

eval dfx identity new FEE
eval dfx identity use FEE
FEE_PUBLIC_KEY="principal \"$( \
    dfx identity get-principal
)\""

eval dfx identity new ROYALTY
eval dfx identity use ROYALTY
ROYALTY_PUBLIC_KEY="principal \"$( \
    dfx identity get-principal
)\""

echo Alice id = $ALICE_PUBLIC_KEY
echo Bob id = $BOB_PUBLIC_KEY
echo Dan id = $DAN_PUBLIC_KEY
echo Fee id = $FEE_PUBLIC_KEY
echo Royalty id = $ROYALTY_PUBLIC_KEY

eval dfx identity use ALICE

dfx start --clean --background

dfx deploy cap

dfx canister --no-wallet create --all
dfx build

CAP_ID="principal \"$( \
   dfx canister --no-wallet id cap
)\""

TOKENID=$(dfx canister --no-wallet id ball_coin)
TOKENID="principal \"$TOKENID\""

echo Ball coin id: $TOKENID


NFTID=$(dfx canister --no-wallet id player_nft)
NFTID="principal \"$NFTID\""

echo NFT id: $NFTID

echo
echo == Install token canister
echo

eval dfx identity use ALICE
eval dfx canister --no-wallet install ball_coin --argument="'(\"Ball Coin Logo\", \"Ball Coin\", \"\$BALL\", 3, 1000000, $ALICE_PUBLIC_KEY, 1.0, $FEE_PUBLIC_KEY, 10.2, $ROYALTY_PUBLIC_KEY, $CAP_ID, $NFTID)'"

eval dfx canister --no-wallet install player_nft --argument "'($ALICE_PUBLIC_KEY, \"BSKT\", \"Basketball game\", $CAP_ID, $TOKENID)'"


echo
echo == Mint NFT players
echo

eval dfx canister --no-wallet call player_nft mintDip721 "'($ALICE_PUBLIC_KEY, vec{} )'"
eval dfx canister --no-wallet call player_nft mintDip721 "'($ALICE_PUBLIC_KEY, vec{} )'"
eval dfx canister --no-wallet call player_nft mintDip721 "'($ALICE_PUBLIC_KEY, vec{} )'"
eval dfx canister --no-wallet call player_nft mintDip721 "'($ALICE_PUBLIC_KEY, vec{} )'"
eval dfx canister --no-wallet call player_nft mintDip721 "'($ALICE_PUBLIC_KEY, vec{} )'"

echo
echo == NFT list for sale
echo

eval dfx canister --no-wallet call player_nft listForSale "'(0: nat64, 100: nat)'"
eval dfx canister --no-wallet call player_nft listForSale "'(1: nat64, 100: nat)'"
eval dfx canister --no-wallet call player_nft listForSale "'(2: nat64, 100: nat)'"
eval dfx canister --no-wallet call player_nft listForSale "'(3: nat64, 100: nat)'"
eval dfx canister --no-wallet call player_nft listForSale "'(4: nat64, 100: nat)'"


echo
echo == Initial ball_coin balances for Alice and Bob, Dan, FeeTo
echo

echo Alice = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($ALICE_PUBLIC_KEY)'" \
)
echo Bob = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($BOB_PUBLIC_KEY)'" \
)
echo Dan = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($DAN_PUBLIC_KEY)'" \
)
echo FeeTo = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($FEE_PUBLIC_KEY)'" \
)
echo RoyaltyTo = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($ROYALTY_PUBLIC_KEY)'" \
)

echo
echo == Transfer 1000 tokens from Alice to Bob
echo

eval dfx canister --no-wallet call ball_coin transfer "'($BOB_PUBLIC_KEY, 1000)'"

echo
echo == Transfer 1000 tokens from Alice to Dan
echo

eval dfx canister --no-wallet call ball_coin transfer "'($DAN_PUBLIC_KEY, 1000)'"

echo
echo == ball_coin balances for Alice and Bob, Dan, FeeTo after transfer
echo

echo Alice = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($ALICE_PUBLIC_KEY)'" \
)
echo Bob = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($BOB_PUBLIC_KEY)'" \
)
echo Dan = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($DAN_PUBLIC_KEY)'" \
)
echo FeeTo = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($FEE_PUBLIC_KEY)'" \
)
echo RoyaltyTo = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($ROYALTY_PUBLIC_KEY)'" \
)

echo
echo Principal IDs of all users
echo Alice id = $ALICE_PUBLIC_KEY
echo Bob id = $BOB_PUBLIC_KEY
echo Dan id = $DAN_PUBLIC_KEY
echo Fee id = $FEE_PUBLIC_KEY
echo Fee id = $ROYALTY_PUBLIC_KEY

echo
echo Owner of 0th NFT before buying = $( eval dfx canister --no-wallet call player_nft ownerOfDip721 "'(0)'" )
echo

echo
echo == Bob buying 0th NFT token player
echo

eval dfx identity use BOB
#eval dfx canister --no-wallet call ball_coin approve "'($NFTID, 10)'"
#echo Bob allowance for NFT = $( eval dfx canister --no-wallet call ball_coin allowance "'($BOB_PUBLIC_KEY, $NFTID)'" )
eval dfx canister --no-wallet call player_nft buyDip721 "'(0: nat64)'"

echo
echo Owner of 0th NFT after buying = $( eval dfx canister --no-wallet call player_nft ownerOfDip721 "'(0)'" )
echo

echo
echo BOB put their purchased player for sale = $( eval dfx canister --no-wallet call player_nft listForSale "'(0: nat64, 200: nat)'" )
echo

echo
echo Owner of 1th NFT before buying = $( eval dfx canister --no-wallet call player_nft ownerOfDip721 "'(1)'" )
echo

echo
echo == Dan buying 1th NFT token player
echo

eval dfx identity use DAN
#eval dfx canister --no-wallet call ball_coin approve "'($NFTID, 10)'"
#echo Bob allowance for NFT = $( eval dfx canister --no-wallet call ball_coin allowance "'($DAN_PUBLIC_KEY, $NFTID)'" )
eval dfx canister --no-wallet call player_nft buyDip721 "'(1: nat64)'"

echo
echo Owner of 1th NFT after buying = $( eval dfx canister --no-wallet call player_nft ownerOfDip721 "'(1)'" )
echo

echo
echo DAN put their purchased player for sale = $( eval dfx canister --no-wallet call player_nft listForSale "'(1: nat64, 200: nat)'" )
echo

echo
echo Display sale tokens excluding DAN =
eval dfx canister --no-wallet call player_nft getSaleTokenIdsForUser "'($DAN_PUBLIC_KEY)'"
echo

echo
echo == ball_coin balances for Alice and Bob, Dan, FeeTo after buying NFT token player
echo

echo Alice = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($ALICE_PUBLIC_KEY)'" \
)
echo Bob = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($BOB_PUBLIC_KEY)'" \
)
echo Dan = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($DAN_PUBLIC_KEY)'" \
)
echo FeeTo = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($FEE_PUBLIC_KEY)'" \
)
echo RoyaltyTo = $( \
    eval dfx canister --no-wallet call ball_coin balanceOf "'($ROYALTY_PUBLIC_KEY)'" \
)

echo
echo == Remove newly created identities
echo
eval eval dfx identity use default
eval eval dfx identity remove ALICE
eval eval dfx identity remove BOB
eval eval dfx identity remove DAN
eval eval dfx identity remove FEE
eval eval dfx identity remove ROYALTY

dfx stop