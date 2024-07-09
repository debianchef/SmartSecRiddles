// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import { Test, console } from "forge-std/Test.sol";
import { FuzzThis } from "../src/1_FuzzThis.sol";


contract FuzzTest is  Test {
    FuzzThis public target;

    function setUp() public {
     target = new FuzzThis(2552);
    }


    function check_GetThisFailing_1(uint256 _guess) public {
      
      // :)
      // vm.assume(_guess != 2552);
        vm.assume(_guess < 5000);
      
        bytes memory solution = "loss";

       bytes32  guess = keccak256( abi.encode( 15 + _guess ));
        bytes memory answer = target.dontHackMePlease(guess);

        assertEq(solution, answer);
    }


}


