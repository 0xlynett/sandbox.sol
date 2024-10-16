// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Call Sandbox
/// @author lynett.eth
/// The Sandbox is a stateless contract. It should not store any funds that cannot be atomically retrieved.
/// Any funds stored in it or approved to it non-atomically can be sweeped away at any time.
/// Its purpose is to ensure any arbitrary calls do not run under a contract's identity, meaning it cannot
/// arbitrarily transferFrom or fuck with stuff as that contract.
///
/// This DOES NOT block returnbomb attacks. If you want that, write your own with excessivelySafeCall.
///
/// UNAUDITED CODE. BUT I HOPE IT'S SAFE. SPEND A FEW BUCKS ON AN AUDIT IF YOU'RE SECURING BILLIONS.
contract Sandbox {
    struct Call {
        address recv;
        bytes data;
        uint256 value;
    }

    function arbitraryCall(
        Call memory x
    ) public payable returns (bool success, bytes memory returnData) {
        (success, returnData) = x.recv.call{value: x.value}(x.data);
        require(success);
    }

    function arbitraryCallNoRevert(
        Call memory x
    ) public payable returns (bool success, bytes memory returnData) {
        (success, returnData) = x.recv.call{value: x.value}(x.data);
    }

    function arbitraryMulticall(
        Call[] memory y
    ) public payable returns (bool[] memory, bytes[] memory) {
        bool[] memory successes = new bool[](y.length);
        bytes[] memory returnData = new bytes[](y.length);

        for (uint256 i; i < y.length; i++) {
            (successes[i], returnData[i]) = arbitraryCall(y[i]);
        }

        return (successes, returnData);
    }

    function arbitraryMulticallNoRevert(
        Call[] memory y
    ) public payable returns (bool[] memory, bytes[] memory) {
        bool[] memory successes = new bool[](y.length);
        bytes[] memory returnData = new bytes[](y.length);

        for (uint256 i; i < y.length; i++) {
            (successes[i], returnData[i]) = arbitraryCall(y[i]);
        }

        return (successes, returnData);
    }
}
