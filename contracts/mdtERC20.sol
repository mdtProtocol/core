// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8.12;

import "./ImdtLogic.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract mdtERC20 is Ownable, ERC20 {
    ImdtLogic internal mdtLogic;

    constructor() ERC20("mdtProtocol Credit", "mdtC") {
        mdtLogic = ImdtLogic(owner());
    }

    function mint(address _account, uint256 _amount) external onlyOwner {
        super._mint(_account, _amount);
    }

    function burn(address _account, uint256 _amount) external onlyOwner {
        super._burn(_account, _amount);
    }

    function _approve(
        address _owner,
        address _spender,
        uint256 _amount
    ) internal override {
        require(_spender == owner(), "Not mdtLogic");

        super._approve(_owner, _spender, _amount);
    }

    function _beforeTokenTransfer(
        address _from,
        address _to,
        uint256 _amount
    ) internal override {
        bool allowedFrom = _from == address(0) || _from == mdtLogic.gnosis();
        bool allowedTo = _to == address(0) || _to == mdtLogic.gnosis();
        require(allowedFrom || allowedTo, "Burnable/Mintable Only");

        super._beforeTokenTransfer(_from, _to, _amount);
    }
}
