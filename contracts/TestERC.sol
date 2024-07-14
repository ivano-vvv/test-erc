// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./ERCProto.sol";
import "./Exchangeable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TestERC is ERCProto, Exchangeable, Ownable {
    constructor() Ownable(msg.sender) {
        _name = "TestERC";
        _symbol = "TERC";
    }

    function mint(uint256 value) external onlyOwner returns (bool) {
        return super._mint(owner(), value);
    }

    function burn(address from, uint256 value) external onlyOwner returns (bool) {
        return super._burn(from, value);
    }

    function registerExchange(address exchange) external onlyOwner returns (bool) {
        return super._registerExchange(exchange);
    }

    function removeExchange(address exchange) external onlyOwner returns (bool) {
        return super._removeExchange(exchange);
    }
}