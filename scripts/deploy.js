// const {ethers}= require("hardhat");

const { ethers } = require("hardhat");
const deploy = async () => {
  const [deployer] = await ethers.getSigners(); // Filled by hardhat config
  console.log("Deploying address by", deployer.address);

  //Creating an instance of the deployed contract
  /**
   * Accesibg to the smatt contract
   */
  const nfts = await ethers.getContractFactory("NFT");
  const deployed = await nfts.deploy(10000);
};
deploy()
  .then(() => process.exit(0))
  .catch(error => {
    console.log(error);
    process.exit(1);
  });
