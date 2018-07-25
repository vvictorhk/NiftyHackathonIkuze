var CitizenSim = artifacts.require("./CitizenSim.sol");

module.exports = function(deployer) {
  deployer.deploy(CitizenSim);
};