# # testnet
# PACKAGE_ID=0x082611c2c7c648ff229a5e76f1a7370ea6b6cb4039eb22686576eb45626fe54d

# TREASURY_CAP=0xf4760623131e8b59f988fae55057bc9115171f8fd1538b962e9df2455f54614b
# AMOUNT=100000000
# RECIPIENT=0x0f36590f2960c8b4133409623736937be071afbb30dce84b0035e556f1ef0a07 # 0xe6eb75d45aea090270b70368cb872879dbce8e922417659d182a557afe37a1b8

# # mint coin
# sui client call --package $PACKAGE_ID \
#                 --module kyrincode_faucet_coin \
#                 --function mint \
#                 --args $TREASURY_CAP $AMOUNT $RECIPIENT \
#                 --gas-budget 100000000

# mainnet
PACKAGE_ID=0xde2d0d163530740d7587d71d4e9503338c2a7596c221688311a912d33f40bc97

TREASURY_CAP=0xe082f774cc045f3a81ae8e5469a58d025a934fc69d22a22f593d9084575dd107
AMOUNT=100000000
RECIPIENT=0x0f36590f2960c8b4133409623736937be071afbb30dce84b0035e556f1ef0a07 # 0xe6eb75d45aea090270b70368cb872879dbce8e922417659d182a557afe37a1b8

# mint coin
sui client call --package $PACKAGE_ID \
                --module kyrincode_faucet_coin \
                --function mint \
                --args $TREASURY_CAP $AMOUNT $RECIPIENT \
                --gas-budget 100000000