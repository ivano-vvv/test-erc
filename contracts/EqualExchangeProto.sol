// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./Exchangeable.sol";

abstract contract EqualExchangeProto {
    Exchangeable internal _first;
    Exchangeable internal _second;

    constructor(address first, address second) {
        _first = Exchangeable(first);
        _second = Exchangeable(second);
    }

    function _fromFirstToSecond(address from, address to, uint256 value) internal returns (bool) {
        _validateAdresses(from, to);

        _first.burnForExchange(from, value);
        _second.mintForExchange(to, value);

        return true;
    }

    function _fromSecondToFirst(address from, address to, uint256 value) internal returns (bool) {
        _validateAdresses(from, to);

        _second.burnForExchange(from, value);
        _first.mintForExchange(to, value);

        return true;
    }

    function _validateAdresses(address from, address to) private pure returns (bool) {
        if (address(0) == from) {
            revert("Invalid 'from' address");
        }

        if (address(0) == to) {
            revert("Invalid 'to' address");
        }

        return true;
    }
}
