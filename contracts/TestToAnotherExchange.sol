// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./EqualExchangeProto.sol";

contract TestToAnotherExchange is EqualExchangeProto {
    constructor(address TERC, address ANT) EqualExchangeProto(TERC, ANT) {}

    function fromTestToOwnAnother(uint256 value) external returns (bool) {
        _fromFirstToSecond(msg.sender, msg.sender, value);

        return true;
    }

    function fromTestToAnother(address to, uint256 value) external returns (bool) {
        _fromFirstToSecond(msg.sender, to, value);

        return true;
    }

    function fromAnotherToOwnTest(uint256 value) external returns (bool) {
        _fromSecondToFirst(msg.sender, msg.sender, value);

        return true;
    }

    function fromAnotherToTest(address to, uint256 value) external returns (bool) {
        _fromSecondToFirst(msg.sender, to, value);

        return true;
    }
}