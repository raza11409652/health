const PatientRecords = artifacts.require("PatientRecord");

module.exports = function(deployer) {
  deployer.deploy(PatientRecords);
};

