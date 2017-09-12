var Crowdsale = artifacts.require("Crowdsale");
var HelpToken = artifacts.require("HelpToken");

contract('Crowdsale', async (accounts) => {
  it("Test if we can buy tokens from the crowd sale", async () => {
   
    const crowdsaleInstance = await Crowdsale.deployed();
    const tokenAddress = await crowdsaleInstance.token.call();

    const tokenContract = await HelpToken.at(tokenAddress);

    const owner = await tokenContract.owner.call();

    console.log(owner, accounts[0])

    const buyToken = await crowdsaleInstance.buyTokens.sendTransaction(accounts[1], {
                    value: web3.toWei('1', 'ether'), 
                    from: accounts[1]});

    const numTokens = await tokenContract.balanceOf(accounts[1]);

    console.log(numTokens);

  });
 

});