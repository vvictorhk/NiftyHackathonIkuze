var CitizenSim = artifacts.require("./CitizenSim.sol");

module.exports = function(deployer, network, accounts) {
  deployer.deploy(CitizenSim);
};
