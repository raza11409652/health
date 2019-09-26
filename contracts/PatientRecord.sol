pragma solidity >=0.4.21 <0.6.0;
contract PatientRecord {
      address private hospitalAdmin;
    address private labAdmin;

    struct Record {
        address pAddr;
        uint256 ID;
        string testName;
        string date;
        string hospitalName;
        uint256 price;
        bool isValue;
        uint256 signatureCount;
        mapping (address => uint256) signatures;
    }

    modifier signOnly {
        require (msg.sender == hospitalAdmin || msg.sender == labAdmin );
        _;
    }

    constructor () public {
         hospitalAdmin = msg.sender;
        labAdmin = 0xebB11572D276CbBA49c1C495d7518Ff82D317282;   
    }
    
    // Mapping to store records
    mapping (uint256=> Record) public _records;
    uint256[] public recordsArr;

    event recordCreated(uint256 ID, string testName, string date, string hospitalName, uint256 price);
    event recordSigned(uint256 ID, string testName, string date, string hospitalName, uint256 price);
    
    // Create new record
    function newRecord (uint256 _ID, string memory _tName, string memory _date, string memory hName,
     uint256 price) public{
        Record storage _newrecord = _records[_ID];

        // Only allows new records to be created
        require(!_records[_ID].isValue);
            _newrecord.pAddr = msg.sender;
            _newrecord.ID = _ID;
            _newrecord.testName = _tName;
            _newrecord.date = _date;
            _newrecord.hospitalName = hName;
            _newrecord.price = price;
            _newrecord.isValue = true;
            _newrecord.signatureCount = 0;

        recordsArr.push(_ID);
        emit  recordCreated(_newrecord.ID, _tName, _date, hName, price);
    }

    // Function to sign a record 
    function signRecord(uint256 _ID) signOnly public {
        Record storage records = _records[_ID];
        
        // Checks the aunthenticity of the address signing it
        require(address(0) != records.pAddr);
        require(msg.sender != records.pAddr);
        
        // Doesn't allow the same person to sign twice
        require(records.signatures[msg.sender] != 1);

        records.signatures[msg.sender] = 1;
        records.signatureCount++;

        // Checks if the record has been signed by both the authorities to process insurance claim
        if(records.signatureCount == 2)
            emit  recordSigned(records.ID, records.testName, records.date, records.hospitalName, records.price);

    }
}
