pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/poseidon.circom";

// Circuit for CompressedAccount hashing
template CompressedAccountHash() {
    // Inputs as field elements
    signal input owner_hashed;
    signal input leaf_index;
    signal input merkle_tree_hashed;
    signal input lamports;
    signal input discriminator;
    signal input has_data;
    signal input data_hash;

    // Output
    signal output hash;

    // We'll use Poseidon with 7 inputs
    component poseidon = Poseidon(7);

    // Connect inputs to the Poseidon component
    poseidon.inputs[0] <== owner_hashed;
    poseidon.inputs[1] <== leaf_index;
    poseidon.inputs[2] <== merkle_tree_hashed;
    poseidon.inputs[3] <== lamports + 18446744073709551616; // + lamports domain
    poseidon.inputs[4] <== discriminator + 36893488147419103232; // + discriminator domain
    poseidon.inputs[5] <== has_data;
    poseidon.inputs[6] <== data_hash;

    // Output the Poseidon hash
    hash <== poseidon.out;
}

component main { public [owner_hashed, leaf_index, merkle_tree_hashed, lamports, discriminator, has_data, data_hash] } = CompressedAccountHash();
