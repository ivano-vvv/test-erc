// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./ERCProto.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AnotherERC is ERCProto, Ownable {
    constructor() Ownable(msg.sender) {
        _name = "Another Token";
        _symbol = "ANT";
    }

    uint256 private GUARANTEED = 1000;

    function mint(uint value) external onlyOwner returns (bool) {
        return super._mint(owner(), value);
    }

    function burn(uint value) external onlyOwner returns (bool) {
        return super._burn(owner(), value);
    }

    function request() external returns (bool) {
        if (_balances[msg.sender] > GUARANTEED) {
            revert("The sender already has more than guaranteed minimum");
        }

        _burn(msg.sender, _balances[msg.sender]);
        _mint(msg.sender, GUARANTEED);

        return true;
    }
}
