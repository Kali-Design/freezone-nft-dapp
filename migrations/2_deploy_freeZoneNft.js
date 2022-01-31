const freeZoneNft = artifacts.require('freeZoneNft');

module.exports = async (deployer, accounts) => {
  await deployer.deploy(freeZoneNft, accounts[0], { from: accounts[0] });
};
