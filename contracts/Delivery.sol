// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


/**
 * @dev Contract for managing student presence.
 * @custom:dev-run-script deploy_with_ethers.ts
 */


contract Marketplace {
    enum ShippingStatus {Pending, Shipped, Delivered}
    ShippingStatus public status;

    event MissionComplete(uint orderId);

    address public owner;

    constructor() {
        owner = msg.sender;
        status = ShippingStatus.Pending;
    }

    modifier ownerOnly() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier customerOnly() {
        require(msg.sender != owner, "Only customers can call this function");
        _;
    }

    function Shipped() public ownerOnly {
        status = ShippingStatus.Shipped;
    }

    function Delivered() public ownerOnly {
        status = ShippingStatus.Delivered;
        emit MissionComplete(123); // replace 123 with orderId of the delivered item
    }

    function getStatus() public view ownerOnly returns (ShippingStatus) {
        return status;
    }

    function Status() public payable customerOnly returns (ShippingStatus) {
        require(msg.value >= 0.05 ether, "Insufficient ether to get the status");
        return status;
    }
}