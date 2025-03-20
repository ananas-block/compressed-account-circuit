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

## Test Values

The test generates the following values:

- Original Mint Pubkey: `0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef`
- Hashed Mint: `0084fdaafea47c29fea7159d0daddd9c085d6200e1359e85bb81736af6b7c837`
- Mint Field: `234974564384405454338400878224811014633568910695081077826838136014050412599`

- Original Owner Pubkey: `fedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210`
- Hashed Owner: `002e4d6374b604562a5d8c04a4dfc035fa499ec7ad373bd48bd2bd62ca75c3b5`
- Owner Field: `81809080774331860018275665161366441680881842191687855875890120042694951861`

- Amount: `1000000`
- Amount bytes: `00000000000000000000000000000000000000000000000000000000000f4240`
- Amount Field: `1000000`

- Original Delegate Pubkey: `aabbccddeeff00112233445566778899aabbccddeeff00112233445566778899`
- Hashed Delegate: `00216bdbddb256a9c661c2f6844cdba5ca81d1d9b4225153f0834c58d027fc8d`
- Delegate Field: `59050367572494053109860423088265265986069532314379372217527226165667298445`

- State: Frozen
- State bytes: `0000000000000000000000000000000000000000000000000000000000000002`
- State Field: `2`

- Poseidon Hash Result: `5928395827810351341553386648434140975090063364054237590393532089755288768847`

Each of these byte arrays is converted to a field element for circuit input.