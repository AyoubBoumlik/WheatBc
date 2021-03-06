// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


import "./Roles.sol";

// Define a contract 'TransporterRole' to manage this role - add, remove, check
contract TransporterRole {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event TransporterAdded(address indexed account);
  event TransporterRemoved(address indexed account);

  // Define a struct 'Transporters' by inheriting from 'Roles' library, struct Role
  Roles.Role private Transporters;

  // In the constructor make the address that deploys this contract the 1st Transporter
  constructor()  {
    _addTransporter(msg.sender);
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyTransporter() {
    require(isTransporter(msg.sender));
    _;
  }

  // Define a function 'isTransporter' to check this role
  function isTransporter(address account) public view returns (bool) {
    return Transporters.has(account);
  }

  // Define a function 'addTransporter' that adds this role
  function addTransporter(address account) public onlyTransporter {
    _addTransporter(account);
  }

  // Define a function 'renounceTransporter' to renounce this role
  function renounceTransporter() public {
    _removeTransporter(msg.sender);
  }

  // Define an internal function '_addTransporter' to add this role, called by 'addTransporter'
  function _addTransporter(address account) internal {
    Transporters.add(account);
    emit TransporterAdded(account);
  }

  // Define an internal function '_removeTransporter' to remove this role, called by 'removeTransporter'
  function _removeTransporter(address account) internal {
    Transporters.remove(account);
    emit TransporterRemoved(account);
  }
}