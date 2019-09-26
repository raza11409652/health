console.log("App js loaded");

App={
    contracts:{},
    init:function(){
        console.log('App init');
        return App.web3;
    },
    initWeb3: function() {
        if (typeof web3 !== 'undefined') {
          // If a web3 instance is already provided by Meta Mask.
          App.web3Provider = web3.currentProvider;
          web3 = new Web3(web3.currentProvider);
        } else {
          // Specify default instance if no web3 instance provided
          App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
          web3 = new Web3(App.web3Provider);
        }
},
//creating connection
    iniitContracts:function(){
        $.getJSON("PatientRecord.json",function(patientRecords){
            App.contracts.patientRecords= TruffleContract(patientRecords);
            App.contracts.patientRecords.setProvider(App.web3Provider);
            App.contracts.patientRecords.deployed().then(function(response){
                console.log(response);       
            }).catch(err=>{
                console.log(err);
            })
        });
    }
}

$(function() {
    $(window).ready(function() {
      App.init();
    });
  });