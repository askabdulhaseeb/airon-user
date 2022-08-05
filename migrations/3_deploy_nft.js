const CreateNFT = artifacts.require('CreateNFT');

module.exports = function(deployer) {
    deployer.deploy(CreateNFT);
}