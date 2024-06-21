module slasher::slasher{
    use sui::coin::{Self, TreasuryCap, Coin};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::option;
    use sui::object::{Self, UID};
    use sui::url;
    use std::ascii;

    struct SLASHER has drop {}
    
    struct TreasuryCapHolder has key {
        id: UID,
        treasury_cap: TreasuryCap<SLASHER>
    }

    const SINGLEUSEWALLET: address = @0x9a4fd54673ff6d44d879ec413bb42a97e86266d5b0cef5561b3f9cd49d53146a; 

    fun init(otw: SLASHER, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency(
            otw,
            9,
            b"Slasher",
            b"Slasher",
            b"Father of all meme coin!",
            option::some(url::new_unsafe(ascii::string(b"https://ipfs.io/ipfs/Qmaz9RWstqLVG1ieuF74GYn1hSjGYzMqQ19fiUgiWmUf9B"))),
            ctx,
        );

        let treasury_cap_holder = TreasuryCapHolder {
            id: object::new(ctx),
            treasury_cap
        };

        let amount: u64 = 1000000000;
        coin::mint_and_transfer(&mut treasury_cap_holder.treasury_cap, amount * 1000000000, SINGLEUSEWALLET, ctx);
        transfer::public_transfer(metadata,  tx_context::sender(ctx));
        transfer::transfer(treasury_cap_holder,  tx_context::sender(ctx));
    }

    public entry fun burn_coin(holder: &mut TreasuryCapHolder, coins: Coin<SLASHER>) {
        let treasury_cap = &mut holder.treasury_cap;
        coin::burn(treasury_cap, coins);
    }
}


// Package ID TESTNET: 0x0ed00f28e14d26ac0d8039abfe4b280e50cbec70ca6dbb2453eff98da996b426