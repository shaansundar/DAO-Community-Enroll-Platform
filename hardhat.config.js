require('@nomiclabs/hardhat-waffle');
const secret = require("./env/secrets.json");

module.exports = {
  solidity: "0.8.4",
  paths:{
    sources: "./blockchain/contracts",
    tests: "./blockchain/tests",
    cache: "./blockchain/cache",
    artifacts: "./blockchain/artifacts",
  },
  networks:{
    mumbai:{
      url: secret.MUMBAI_RPC,
      accounts: [secret.PRIVATE_KEY]
    },
    bsctestnet:{
      url: secret.BSCTESTNET_RPC,
      accounts: [secret.PRIVATE_KEY]
    }
  }
};
