// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import { Test, console } from "forge-std/Test.sol";
import { Staking, Rewarder } from "../src/6_NotForTrusting.sol";
import "../mocks/marqToken.sol";
import "../mocks/NFT.sol";


contract NotForTrusting is Test {
      Staking public staking;
    Rewarder public rewarder;
    address public tokenAddress;
    address public nftAddress;
    MarqToken public token;
    NFT public nft;
    uint256 tokenId = 0;


    function setUp() public {
         token = new MarqToken();
        tokenAddress = address(token);
         nft = new NFT();
        nftAddress = address(nft);
        rewarder = new Rewarder(tokenAddress, 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
        staking = new Staking(nftAddress, address(rewarder));

        vm.prank(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38);
        rewarder.setStaker(address(staking));

        nft.mint(address(0xBAD));        

    }


 
    function test_GetThisPassing_6() public {
        address hacker = address(0xBAD);
        

        vm.startPrank(hacker);
        nft.approve(address(staking));
       staking.stake(tokenId, 1.2 ether );

        vm.stopPrank();

        assertGt(token.balanceOf(hacker), 1000 ether);
        assertEq(nft.ownerOf(tokenId), hacker);
    }

}


