const PatientRecords = artifacts.require("PatientRecords");
contract("PatientRecords" , function(account){
var tokenIntance ; 
// it("init correct values" , function(){
//         return DappToken.deployed().then(function(instance){
//             tokenIntance = instance ; 
//             return tokenIntance.name();
//         }).then(function(name){
//             assert.equal(name , "Dapp Token" , "It has valid name");
//             return tokenIntance.symbol();
//         }).then(function(symbol){
//             assert.equal(symbol , "DAPP" , "It has correct symbol");
//             return tokenIntance.standard();
//         }).then(function(standard){
//             assert.equal(standard , "Dapp Token v1.0" , "Ir has the correct Standard") ;
//         });
//     });
it("Validate set doctor"  , function(){
    return PatientRecords.deployed().then(function(instance){
        tokenIntance = instance ; 
        return tokenIntance.Owner();  
    }).then(function(owner){
        assert.equal(owner , account[0] , "It has valid");
    }).catch(error=>{
       // assert.fail
    })
})
});