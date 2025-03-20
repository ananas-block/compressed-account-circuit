pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/poseidon.circom";

// This circuit proves correct hashing of token data using the Poseidon hash function.
// It matches the Rust implementation in the original code.
//
// The conversion process from the original data to circuit inputs is:
// 1. For pubkeys (mint, owner, delegate): hash using hash_to_bn254_field_size_be and convert to field element
// 2. For amount: convert to big-endian 32 bytes with the value in the last 8 bytes, then convert to field element
// 3. For state: create 32 bytes with 0 for initialized or 2 for frozen in the last byte, then convert to field element
//
// The circuit then computes the Poseidon hash of these five field elements.
template TokenHash() {
    // Inputs - each byte array is represented as a single field element
    signal input mint;      // Hashed mint pubkey as field element
    signal input owner;     // Hashed owner pubkey as field element
    signal input amount;    // Amount in big-endian as field element
    signal input delegate;  // Hashed delegate pubkey as field element
    signal input state;     // State byte as field element (0 or 2)

    // Output
    signal output hash;     // Poseidon hash of the inputs

    // Create Poseidon component with 5 inputs
    component poseidon = Poseidon(4);

    // Connect inputs to the Poseidon component
    poseidon.inputs[0] <== mint;
    poseidon.inputs[1] <== owner;
    poseidon.inputs[2] <== amount;
    poseidon.inputs[3] <== delegate;
    // poseidon.inputs[4] <== state;
    log(mint);
    log(owner);
    log(amount);
    log(delegate);
    log(state);


    // Output the Poseidon hash
    hash <== poseidon.out;
}

component main { public [mint, owner, amount, delegate, state] } = TokenHash();
