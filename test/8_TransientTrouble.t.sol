// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;

import { ExclusiveClub } from "../src/8_TransientTrouble.sol";
import "forge-std/Test.sol";
import "../mocks/NFT.sol";


contract TransientTrouble is Test {

    NFT public ticket;
    ExclusiveClub daClub;
       address nftAddress;


    function setUp() public {
         ticket = new NFT();
        nftAddress = address(ticket);

        daClub = new ExclusiveClub(0.1 ether, nftAddress);

        vm.deal(address(0xBAD), 0.1 ether);
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
