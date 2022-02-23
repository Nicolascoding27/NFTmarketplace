// const {ethers}= require("hardhat");

const { ethers } = require("hardhat");
const deploy = async () => {
  const  [deployer]  = await ethers.getSigners(); // Filled by hardhat config
  console.log("Deploying address by", deployer.address);

  //Creating an instance of the deployed contract
  /**
   * Accesibg to the smatt contract
   */
  const nfts = await ethers.getContractFactory("NFT");
  const deployed = await nfts.deploy();

  console.log("Nico Baby token deployed at:", deployed.address);
  //Promise aftes
  process.exit(1);
};

