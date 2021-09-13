// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


import "./Roles.sol";

// Silo

// Define a contract 'SiloRole' to manage this role - add, remove, check
contract SiloRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event SiloAdded(address indexed account);
  event SiloRemoved(address indexed account);

  // Define a struct 'Silos' by inheriting from 'Roles' library, struct Role
  Roles.Role private Silos;

  // In the constructor make the address that deploys this contract the 1st Silo
  constructor()  {
    _addSilo(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlySilo() {
    require(isSilo(msg.sender));
    _;
  }

  // Define a function 'isSilo' to check this role
  function isSilo(address account) public view returns (bool) {
    return Silos.has(account);
  }

  // Define a function 'addSilo' that adds this role
  function addSilo(address account) public onlySilo {
    _addSilo(account);
  }

  // Define a function 'renounceSilo' to renounce this role
  function renounceSilo() public {
    _removeSilo(msg.sender);
  }

  // Define an internal function '_addSilo' to add this role, called by 'addSilo'
  function _addSilo(address account) internal {
    Silos.add(account);
    emit SiloAdded(account);
  }

  // Define an internal function '_removeSilo' to remove this role, called by 'removeSilo'
  function _removeSilo(address account) internal {
    Silos.remove(account);
    emit SiloRemoved(account);
  }
}