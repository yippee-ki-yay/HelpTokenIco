var Crowdsale = artifacts.require('./Crowdsale');

module.exports = (deployer) => {
    deployer.deploy(Crowdsale, "0x16a6b20f69fe1f90fd8ab8db10ddacf1a6ef9729", 365);
}