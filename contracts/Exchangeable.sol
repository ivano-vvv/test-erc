// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "./ERCProto.sol";

abstract contract Exchangeable is ERCProto {
    mapping (address => bool) private _registered;

    modifier onlyRegisterExchanges() {
        if (_isExchangeRegistered(msg.sender) != true) {
            revert("Exchange is not registered");
        }

        _;
    }

    function isExchangeRegistered(address exchange) external view returns (bool) {
        if (exchange == address(0)) {
            revert("Invalid address");
        }
        
        return _registered[exchange];
    }

    function mintForExchange(address to, uint256 value) external onlyRegisterExchanges returns (bool) {
        _mint(to, value);

        return true;
    }

    function burnForExchange(address from, uint256 value) external onlyRegisterExchanges returns (bool) {
        if (_balances[from] < value) {
            revert("The target's balance is not enough");
        }

        _burn(from, value);

        return true;
    }

    function _registerExchange(address exchange) internal returns (bool) {
        if (exchange == address(0)) {
            revert("Invalid address");
        }
        
        if (_registered[exchange]) {
            revert("The exchange is already registered");
        }

        _registered[exchange] = true;

        return true;
    }

    function _removeExchange(address exchange) internal returns (bool) {
        if (exchange == address(0)) {
            revert("Invalid address");
        }
        
        if (_registered[exchange] != true) {
            revert("The exchange is not registered");
        }

        _registered[exchange] = false;

        return true;
    }

    function _isExchangeRegistered(address exchange) private view returns (bool) {
        if (exchange == address(0)) {
            revert("Invalid address");
        }
        
        return _registered[exchange];
    }
}
