module MyModule::CreditSystem {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    struct CreditAccount has store, key {
        balance: u64,  // Current balance of the account
    }

    /// Function to create a new credit account for a user.
    public fun create_account(owner: &signer) {
        let account = CreditAccount { balance: 0 };
        move_to(owner, account);
    }

    /// Function to transfer credits from one account to another.
    public fun transfer_credits(sender: &signer, recipient: address, amount: u64) acquires CreditAccount {
        let sender_account = borrow_global_mut<CreditAccount>(signer::address_of(sender));
        let recipient_account = borrow_global_mut<CreditAccount>(recipient);

        // Ensure sender has enough balance
        assert!(sender_account.balance >= amount, 100); // Error code for insufficient balance

        // Update balances
        sender_account.balance = sender_account.balance - amount;
        recipient_account.balance = recipient_account.balance + amount;
    }
}
