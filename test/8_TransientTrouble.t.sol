// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import { ExclusiveClub } from "../src/8_TransientTrouble.sol";
import { TransientTroubleHelper } from "../test_helper/8_TransientTroubleSetup.sol";
import "forge-std/Test.sol";
import "../mocks/NFT.sol";


contract TransientTrouble is Test {

    NFT public ticket;
    ExclusiveClub daClub;


    function setUp() public {
        TransientTroubleHelper dontpeak = new TransientTroubleHelper();
        daClub = dontpeak.deployed();
        ticket = dontpeak.ticket();
    }


    function test_GetThisPassing_8() public {

        address hacker = address(0xBAD);
        uint256 amount = 0.1 ether; 
vm.deal(hacker , amount);
        vm.startPrank(hacker);
        daClub.externalJoinClub{value : amount}();
        vm.stopPrank();

        assertGt(ticket.balanceOf(hacker), 2);
    }


}
