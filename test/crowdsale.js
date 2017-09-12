var Crowdsale = artifacts.require("Crowdsale");
var HelpToken = artifacts.require("HelpToken");

contract('Crowdsale', async (accounts) => {
  it("Test if we can buy tokens from the crowd sale", async () => {
   
   
    const crowdsaleInstance = await Crowdsale.deployed();
    const tokenAddress = await crowdsaleInstance.token.call();

    const tokenContract = await HelpToken.at(tokenAddress);

    const owner = await tokenContract.owner.call();
    const ico = await tokenContract.ico.call();

    const buyToken = await crowdsaleInstance.buyTokens.sendTransaction(accounts[0], {
                    value: web3.toWei('1', 'ether'), 
                    from: accounts[0]});

    console.log(buyToken);

    const numTokens = await tokenContract.balanceOf(accounts[0]);
    const icoTokens = await tokenContract.balanceOf(ico);

    console.log(numTokens, icoTokens);

  });
 

});