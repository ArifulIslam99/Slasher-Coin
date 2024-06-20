module slasher::slasher{
    use sui::coin::{Self, TreasuryCap, Coin};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::option;
    use sui::object::{Self, UID};
    use sui::url;
    use std::ascii;

    struct SLASHER has key {}
    
    struct TreasuryCapHolder has key {
        id: UID,
        treasury_cap: TreasuryCap<SLASHER>
    }
}
