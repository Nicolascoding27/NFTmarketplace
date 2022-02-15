require("@nomiclabs/hardhat-waffle");
require('dotenv').config();

const PRIVATE_KEY = process.env.PRIVATE_KEY;

module.exports = {
  solidity: "0.8.4",
  networks:{
    rinkeby:{
      url:"https://rinkeby.infura.io/v3/1f5718128a8748d18b913b7842d813ac",
      accounts:[PRIVATE_KEY]
    }
  }
};
