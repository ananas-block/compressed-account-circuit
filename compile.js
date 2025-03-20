const util = require('util');
const exec = util.promisify(require('child_process').exec);

async function compileCircuit() {
  try {
    console.log('Compiling circuit...');
    const { stdout, stderr } = await exec('circom circuits/token_hash.circom --r1cs --wasm --sym');
    console.log('Compilation output:');
    console.log(stdout);
    if (stderr) {
      console.error('Compilation errors:');
      console.error(stderr);
      return false;
    }
    console.log('Circuit compiled successfully!');
    return true;
  } catch (error) {
    console.error('Error compiling circuit:', error.message);
    return false;
  }
}

if (require.main === module) {
  compileCircuit().then(success => {
    if (!success) {
      process.exit(1);
    }
  });
}

module.exports = { compileCircuit };