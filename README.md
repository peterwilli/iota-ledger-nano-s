# IOTA App for Ledger Blue & Ledger Nano S

Here we try to use natively available crypto logic to create IOTA Seeds and sign transactions on the fly. It's currently heavily in alpha so don't trust this yet!

See [Ledger's documentation](http://ledger.readthedocs.io) to get more info about the inner workings.

## How to get started

- Clone this repo, and set up your dev environment according to this: <https://github.com/LedgerHQ/ledger-nano-s>

  - While I do have some scripts to automate this process in the repo, they are not ready yet.

- Inside the blue-app-iota, run make load and watch the magic happen. Be sure to connect your Ledger and open it at the dashboard to load the app.

## Todo

- [x] Currently we can generate (very shitty) IOTA seeds derived from a BIP32 seed. I say shitty because they only consist of 48 bytes of randomness.
- [ ] Try to get better entropy for the seeds, this seems like a good start: <https://github.com/LedgerHQ/blue-app-password-manager/blob/master/src/main.c#L96>
- [ ] Move to native Keccak (see: https://github.com/LedgerHQ/blue-app-eth/blob/cdc8c7436c76d7600d855f1411b5bc00e55980b7/src_genericwallet/main.c#L2430)
- [ ] Generate actual addresses from the seeds
- [ ] Create or sign transactions
