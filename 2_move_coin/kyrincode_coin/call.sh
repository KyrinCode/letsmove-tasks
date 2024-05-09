
# # testnet
# PACKAGE_ID=0x78738d78352565548776fbd8ca71ab21c5c71773ce1c15738930f7887072feea

# TREASURY_CAP=0xa2db7675e95660bcff7c6f0b17f62d78839117e202e3b94f18fb4f89ddcda033
# AMOUNT=100000000
# RECIPIENT=0x0f36590f2960c8b4133409623736937be071afbb30dce84b0035e556f1ef0a07 # 0xe6eb75d45aea090270b70368cb872879dbce8e922417659d182a557afe37a1b8

# # mint coin
# sui client call --package $PACKAGE_ID \
#                 --module kyrincode_coin \
#                 --function mint \
#                 --args $TREASURY_CAP $AMOUNT $RECIPIENT \
#                 --gas-budget 100000000

# mainnet
PACKAGE_ID=0x66adaa020fab967c1617d226a3d868f062aa37bb13ac44deb18f1366f6ec7980

TREASURY_CAP=0x7b3c97515740851c5986f1330b6f0caddfb47d257d96e73fb34b1adb6844bfdc
AMOUNT=100000000
RECIPIENT=0x0f36590f2960c8b4133409623736937be071afbb30dce84b0035e556f1ef0a07 # 0xe6eb75d45aea090270b70368cb872879db

# mint coin
sui client call --package $PACKAGE_ID \
                --module kyrincode_coin \
                --function mint \
                --args $TREASURY_CAP $AMOUNT $RECIPIENT \
                --gas-budget 100000000