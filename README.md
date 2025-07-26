# Token Hash Circom Circuit

This project implements a Circom circuit for proving the correct hashing of token data, replicating the behavior of the Rust implementation.

## Overview

The circuit takes the following inputs as field elements:
- `mint` - Hashed mint pubkey as a field element
- `owner` - Hashed owner pubkey as a field element
- `amount` - Amount in big-endian as a field element
- `delegate` - Hashed delegate pubkey as a field element
- `state` - State byte as a field element (0 or 2 for Initialized/Frozen)

The circuit computes a Poseidon hash of these field elements to produce the token hash output.

## Structure

- `circuits/token_hash.circom` - The main circuit implementation
- `test/token_hash.test.js` - Basic test for Poseidon hashing
- `test/token_hash_circuit.test.js` - Full circuit test that compiles and runs the circuit
- `compile.js` - Script to compile the circuit

## Installation

```bash
npm install
```

## Compilation

```bash
npm run compile
```

## Testing

```bash
# Run all tests
npm test

# Run only the hash test (doesn't require circuit compilation)
npm run test:hash

# Run full circuit test (requires circuit compilation)
npm run test:circuit
```

## Implementation Notes

- The circuit uses the actual Poseidon hash implementation from circomlib 2.0.5
- All byte arrays are represented as single field elements in the circuit
- The test scripts show how to:
  1. Convert byte arrays to field elements
  2. Use the circuit to compute the token hash
  3. Verify the output against the expected hash computed using the JavaScript Poseidon implementation

## Compressed Account Test Values

https://github.com/Lightprotocol/program-examples/blob/f593b2a226b8823261439eb22447e7f258339280/lowlevel/tests/test.rs#L55
