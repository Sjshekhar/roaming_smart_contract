pragma solidity >=0.4.22 <0.6.0;

contract BillCalculation {

    uint16 phoneCallPrice = 1; //1 cent every sec
    uint16 bill;
    address homeOperator;

    constructor() public {
        homeOperator = msg.sender;
    }

    function calculateBill(uint16 duration) public payable verifySenderAndBalance {
        bill = duration * phoneCallPrice;
    }

     function getBill( ) public view returns (uint16) {
        return bill;
    }

    function changePhoneCallPrice(uint16 price) public payable verifySenderAndBalance {
        phoneCallPrice = price;
    }

    modifier verifySenderAndBalance() {
        require(msg.sender == homeOperator);
        require(msg.value < msg.sender.balance);
        _;
    }
}
