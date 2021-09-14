// migrating the appropriate contracts
var FarmerRole = artifacts.require("./FarmerRole.sol");
var SiloRole = artifacts.require("./SiloRole.sol");
var TransporterRole = artifacts.require("./TransporterRole.sol");
var MillRole = artifacts.require("./MillRole.sol");
var DistributorRole = artifacts.require("./DistributorRole.sol");
var RetailerRole = artifacts.require("./RetailerRole.sol");
var ConsumerRole = artifacts.require("./ConsumerRole.sol");
var WheatSupplyChain = artifacts.require("./WheatSupplyChain.sol");

module.exports = function(deployer) {
    deployer.deploy(FarmerRole);
    deployer.deploy(SiloRole);
    deployer.deploy(TransporterRole);
    deployer.deploy(MillRole);
    deployer.deploy(DistributorRole);
    deployer.deploy(RetailerRole);
    deployer.deploy(ConsumerRole);
    deployer.deploy(WheatSupplyChain);

};