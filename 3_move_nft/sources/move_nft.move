module move_nft::kyrincode_nft {
	use sui::tx_context::sender;
    use std::ascii;
	use std::string::{utf8, String};
    use sui::url::{Self, Url};
    use sui::event;

    // The creator bundle: these two packages often go together.
    use sui::package;
    use sui::display;

    // One-Time-Witness for the module.
    public struct KYRINCODE_NFT has drop {}

    public struct KyrinCodeNFT has key, store {
        id: UID,
        name: String,
        token_id: u64,
        description: String,
        image_url: Url,
    }

    public struct State has key, store {
        id: UID,
        count: u64,
    }

    #[test_only]
    public fun name(nft: &KyrinCodeNFT): &String {
        &nft.name
    }

    #[test_only]
    public fun image_url(nft: &KyrinCodeNFT): &Url {
        &nft.image_url
    }

    // Events

    public struct Minted has copy, drop {
        object_id: ID,
        minter: address,
        name: String,
    }

    public struct Transferred has copy, drop {
        object_id: ID,
        from: address,
        to: address,
    }

    /// In the module initializer one claims the `Publisher` object
    /// to then create a `Display`. The `Display` is initialized with
    /// a set of fields (but can be modified later) and published via
    /// the `update_version` call.
    ///
    /// Keys and values are set in the initializer but could also be
    /// set after publishing if a `Publisher` object was created.
    fun init(otw: KYRINCODE_NFT, ctx: &mut TxContext) {
        let initial_state = State {
            id: object::new(ctx),
            count: 0
        };

        let keys = vector[
            utf8(b"name"),
            utf8(b"description"),
            utf8(b"image_url"),
            utf8(b"creator"),
        ];

        let values = vector[
            utf8(b"{name}"), // KyrinCode NFT Name
            utf8(b"{description}"), // KyrinCode NFT Description
            utf8(b"{image_url}"), // https://avatars.githubusercontent.com/u/30864546?s=40&v=4
            utf8(b"{sender(ctx)}")
        ];
        // Claim the `Publisher` for the package!
        let publisher = package::claim(otw, ctx);
        // Get a new `Display` object for the `Hero` type.
        let mut display = display::new_with_fields<KyrinCodeNFT>(
            &publisher, keys, values, ctx
        );
        // Commit first version of `Display` to apply changes.
        display::update_version(&mut display);

        transfer::public_transfer(publisher, sender(ctx));
        transfer::public_transfer(display, sender(ctx));

        transfer::share_object(initial_state);
    }

    #[test_only]
    public fun test_init(ctx: &mut TxContext) {
        init(KYRINCODE_NFT {}, ctx);
    }

    /// Anyone can mint `KyrinCodeNFT`!
    public entry fun mint(name: String, description: String, url: ascii::String, state: &mut State, ctx: &mut TxContext) {
        state.count = state.count + 1;

        let nft = KyrinCodeNFT {
            id: object::new(ctx),
            name: name,
            token_id: state.count,
            description: description,
            image_url: url::new_unsafe(url),
        };

        event::emit(Minted {
        	object_id: object::id(&nft),
        	minter: sender(ctx),
        	name: nft.name,
        });

        transfer::public_transfer(nft, sender(ctx));
    }

    public entry fun transfer(nft: KyrinCodeNFT, recipient: address, ctx: &mut TxContext) {
        event::emit(Transferred {
            object_id: object::id(&nft),
            from: sender(ctx),
            to: recipient,
        });

        transfer::public_transfer(nft, recipient);
    }

    public entry fun burn(nft: KyrinCodeNFT, _: &mut TxContext) {
        let KyrinCodeNFT { id, name: _, token_id: _, description: _, image_url: _} = nft;
        object::delete(id)
    }
}