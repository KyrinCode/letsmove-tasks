PACKAGE_ID=0x33dae8c1b1fcf47da7718194c0ae1c5e7bf903ac049b3dc51b8610030dd27e0c

# # mint nft
# IMAGE_URL="https://avatars.githubusercontent.com/u/30864546?s=40&v=4"
# STATE_ID=0xabda40be35d691fe787072982dcf97d5356b08fde41c113143f89269b60d8c54

# sui client call  --package $PACKAGE_ID \
#                 --module kyrincode_nft \
#                 --function mint \
#                 --args "KyrinCode NFT Name" "KyrinCode NFT Description" $IMAGE_URL $STATE_ID \
#                 --gas-budget 100000000

# transfer nft
NFT_ID=0x937e536b0139e3e2f205489405c3ca5f85d3012577a6caf7aa8bf8c040fc1f47
RECIPIENT=0xe6eb75d45aea090270b70368cb872879dbce8e922417659d182a557afe37a1b8

sui client call --package $PACKAGE_ID \
                --module kyrincode_nft \
                --function transfer \
                --args $NFT_ID $RECIPIENT \
                --gas-budget 100000000