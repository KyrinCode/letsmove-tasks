#[test_only]
module move_nft::move_nft_tests {
    // uncomment this line to import the module
    use move_nft::kyrincode_nft;
    use std::ascii;
    use std::string::utf8;
    use sui::test_scenario::{Self, next_tx, ctx};
    use std::debug::print;
    use sui::url;

    const ENftNameError: u64 = 0;
    const ENftImageError: u64 = 1;

    #[test]
    fun test_move_nft() {
        let addr1 = @0xA;
        let addr2 = @0xB;

        let img_url = b"https://avatars.githubusercontent.com/u/30864546?s=40&v=4";
        // print img_url use move language and use println module
        print(&img_url);

        let mut scenario = test_scenario::begin(addr1);
        {
            kyrincode_nft::test_init(ctx(&mut scenario));
        };

        // test mint
        next_tx(&mut scenario, addr1);
        {
            let mut state = test_scenario::take_shared<kyrincode_nft::State>(&scenario);
            kyrincode_nft::mint(
                utf8(b"KyrinCode NFT Name"),
                utf8(b"KyrinCode NFT Description"),
                ascii::string(img_url),
                &mut state,
                ctx(&mut scenario)
            );
            test_scenario::return_shared<kyrincode_nft::State>(state);
        };

        // test transfer
        next_tx(&mut scenario, addr1);
        {
            let nft = test_scenario::take_from_address<kyrincode_nft::KyrinCodeNFT>(&scenario, addr1);
            let image_url = kyrincode_nft::image_url(&nft);
            assert!(utf8(b"KyrinCode NFT Name") == kyrincode_nft::name(&nft), ENftNameError);
            assert!(url::inner_url(image_url) == img_url.to_ascii_string(), ENftImageError);
            kyrincode_nft::transfer(nft, addr2, ctx(&mut scenario));
        };

        test_scenario::end(scenario); // scenario.end();
    }

    // #[test, expected_failure(abort_code = move_nft::move_nft_tests::ENotImplemented)]
    // fun test_move_nft_fail() {
    //     abort ENotImplemented
    // }
}

