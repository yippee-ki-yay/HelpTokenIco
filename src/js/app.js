App = {
  web3Provider: null,
  contracts: {},

  init: function() {
    return App.initWeb3();
  },

  initWeb3: function() {
    // Initialize web3 and set the provider to the testRPC.
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      // set the provider you want from Web3.providers
      App.web3Provider = new web3.providers.HttpProvider('http://localhost:8545');
      web3 = new Web3(App.web3Provider);
    }

    return App.initContract();
  },

  initContract: function() {
    $.getJSON('Crowdsale.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract.
      var CrowdsaleArtifact = data;
      App.contracts.Crowdsale = TruffleContract(CrowdsaleArtifact);

      // Set the provider for our contract.
      App.contracts.Crowdsale.setProvider(App.web3Provider);

    });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '#transferButton', App.handleTransfer);
    $(document).on('change paste keyup', '#num_tokens', App.priceInEther);
  },

  priceInEther: function () {
    var value = $('#num_tokens').val();

    if(!$.isNumeric(value)) {
      return;
    }

    var num_eth = $('#num_tokens').val() / 1000;

    $('#eth_price').val(num_eth + " ether");
  },

  handleTransfer: function() {
    event.preventDefault();

    var amount = parseInt($('#num_tokens').val());

    if(!$.isNumeric(amount)) {
      return;
    }

    console.log('Number of tokens: ' + amount);

    var crowdsaleInstance;

    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      var account = accounts[0];

      if(amount < 1) {
        return;
      }

      var num_eth = amount / 1000;

      App.contracts.Crowdsale.deployed().then(function(instance) {
        crowdsaleInstance = instance;

         return crowdsaleInstance.buyTokens.sendTransaction(account, {from: account, value: web3.toWei(num_eth.toString(), 'ether')});

      }).then(function(res) {
          console.log("Congratulations you bought " + amount + " tokens!!!");
          $('#num_tokens').val("");
      })
      .catch(function(err) {
        console.log(err.message);
      });
    });
  },

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
