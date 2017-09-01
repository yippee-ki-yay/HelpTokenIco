var HelpToken = artifacts.require('./HelpToken');

module.exports = (deployer) => {
    deployer.deploy(HelpToken);
}