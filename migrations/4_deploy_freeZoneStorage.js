const freeZoneStorage = artifacts.require('freeZoneStorage');

module.exports = async (deployer, accounts) => {
  await deployer.deploy(freeZoneStorage, accounts[0], { from: accounts[0] });
};
