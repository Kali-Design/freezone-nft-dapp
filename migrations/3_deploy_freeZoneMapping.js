const freeZoneMapping = artifacts.require('freeZoneMapping');

module.exports = async (deployer, accounts) => {
  await deployer.deploy(freeZoneMapping, accounts[0], { from: accounts[0] });
};
