// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

abstract contract ERCProto is IERC20, IERC20Metadata {
    string _name;
    string _symbol;

    uint256 _total;

    mapping (address => uint256) _balances;
    mapping (address => mapping (address => uint256)) _allowances;

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function decimals() external pure returns (uint8) {
        return 18;
    }

    function totalSupply() external view returns (uint256) {
        return _total;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) external returns (bool) {
        if (to == address(0)) {
            revert("Invalid address");
        }

        if (_balances[msg.sender] < value) {
            revert("Insufficient balance");
        }

        _balances[msg.sender] -= value;
        _balances[to] += value; 

        emit Transfer(msg.sender, to, value);

        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) external returns (bool) {
        if (spender == address(0)) {
            revert("Invalid address");
        }

        _allowances[msg.sender][spender] = 0;
        _allowances[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);

        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        if (from == address(0)) {
            revert("Invalid sender address");
        }

        if (from == address(0)) {
            revert("Invalid receiver address");
        }

        if (_allowances[from][msg.sender] < value) {
            revert("Not allowed"); 
        }

        if (_balances[from] < value) {
            revert("Insufficient balance");
        }

        _balances[to] += value;
        _balances[from] -= value;

        unchecked {
            _allowances[from][msg.sender] -= value;
        }

        emit Transfer(from, to, value);

        return true;
    }

    function _mint(address to, uint256 value) internal returns (bool) {
        if (to == address(0)) {
            revert("Invalid receiver address");
        }

        _total += value;
        _balances[to] += value;

        emit Transfer(address(0), to, value);

        return true;
    }

    function _burn(address from, uint256 value) internal returns (bool) {
        if (address(0) == from) {
            revert("Invalid address");
        }
        
        if (_balances[from] < value) {
            _total -= _balances[from];
            _balances[from] = 0;
        } else {
            _total -= value;
            _balances[from] -= value;
        }

        return true;
    }
}