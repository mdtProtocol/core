// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract mdtProxy is TransparentUpgradeableProxy, Context {
    constructor(address _logic)
        TransparentUpgradeableProxy(_logic, _msgSender(), "")
    {}
}
