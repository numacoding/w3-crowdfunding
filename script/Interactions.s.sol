//SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.1 ether;

    function fundFundMe(address mostRecientlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecientlyDeployed)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecientlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );

        vm.startBroadcast();
        fundFundMe(mostRecientlyDeployed);
        vm.stopBroadcast();
    }

}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecientlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecientlyDeployed)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecientlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );

        vm.startBroadcast();
        withdrawFundMe(mostRecientlyDeployed);
        vm.stopBroadcast();
    }
}