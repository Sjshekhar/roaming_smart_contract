pragma solidity >=0.4.22 <0.6.0;

contract CallDataRecord {

    struct record {
        uint16 callID;     //unique id of the call
        uint16 caller;     //calling number
        uint16 receiver;   //called number
        uint16 duration;   //duration of the call in sec
        uint16 start;      //start time of the call
        uint16 end;        //end time of the call
    }

    address roamingOperator;
    mapping(address => mapping (uint16 => mapping (uint16 => record))) records;

    constructor() public {
        roamingOperator = msg.sender;
    }

    function registerCall(uint16 callerID, uint16 callID, uint16 caller, uint16 receiver, uint16 start, uint16 end, uint16 duration) public payable verifySenderAndBalance {

            records[roamingOperator][callerID][callID].start = start;
            records[roamingOperator][callerID][callID].end = end;
            records[roamingOperator][callerID][callID].caller = caller;
            records[roamingOperator][callerID][callID].receiver = receiver;
            records[roamingOperator][callerID][callID].duration = duration;
            records[roamingOperator][callerID][callID].callID = callID;
    }

    function getCallDetails(uint16 callerID, uint16 callID) public view returns (uint16, uint16, uint16, uint16, uint16) {
            return (
            records[roamingOperator][callerID][callID].start,
            records[roamingOperator][callerID][callID].end,
            records[roamingOperator][callerID][callID].caller,
            records[roamingOperator][callerID][callID].receiver,
            records[roamingOperator][callerID][callID].duration
            );
    }

    function changeStartTime(uint16 callerID, uint16 callID, uint16 start) public payable verifySenderAndBalance {
             records[roamingOperator][callerID][callID].start = start;
    }

    function changeEndTime(uint16 callerID, uint16 callID, uint16 end) public payable verifySenderAndBalance {
             records[roamingOperator][callerID][callID].end = end;
    }

    function changeCaller(uint16 callerID, uint16 callID, uint16 caller) public payable verifySenderAndBalance {
             records[roamingOperator][callerID][callID].caller = caller;
    }

    function changeReceiver(uint16 callerID, uint16 callID, uint16 receiver) public payable verifySenderAndBalance {
             records[roamingOperator][callerID][callID].receiver = receiver;
    }

    function checkIfRecordExists(uint16 callerID, uint16 callID) public view returns (bool) {
             return records[roamingOperator][callerID][callID].callID != 0;
    }

    function deleteRecord(uint16 callerID, uint16 callID) public payable verifySenderAndBalance {
              delete records[roamingOperator][callerID][callID].callID;
    }

    modifier verifySenderAndBalance() {
        require(msg.sender == roamingOperator);
        require(msg.value < msg.sender.balance);
        _;
    }
}
