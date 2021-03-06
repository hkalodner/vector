// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.1;
pragma experimental ABIEncoderV2;

import "./LibUtils.sol";
import "@openzeppelin/contracts/utils/Address.sol";


library LibERC20 {

    function wrapCall(address assetId, bytes memory callData)
        internal
        returns (bool)
    {
        return wrapCall(assetId, callData, gasleft());
    }

    function wrapCall(address assetId, bytes memory callData, uint256 gas)
        internal
        returns (bool)
    {
        require(Address.isContract(assetId), "LibERC20: NO_CODE");
        (bool success, bytes memory returnData) = assetId.call{gas: gas}(callData);
        LibUtils.revertIfCallFailed(success, returnData);
        return returnData.length == 0 || abi.decode(returnData, (bool));
    }

    function approve(address assetId, address spender, uint256 amount)
        internal
        returns (bool)
    {
        return wrapCall(
            assetId,
            abi.encodeWithSignature("approve(address,uint256)", spender, amount)
        );
    }

    function transferFrom(address assetId, address sender, address recipient, uint256 amount)
        internal
        returns (bool)
    {
        return wrapCall(
            assetId,
            abi.encodeWithSignature("transferFrom(address,address,uint256)", sender, recipient, amount)
        );
    }

    function transfer(address assetId, address recipient, uint256 amount)
        internal
        returns (bool)
    {
        return transfer(assetId, recipient, amount, gasleft());
    }

    function transfer(address assetId, address recipient, uint256 amount, uint256 gas)
        internal
        returns (bool)
    {
        return wrapCall(
            assetId,
            abi.encodeWithSignature("transfer(address,uint256)", recipient, amount),
            gas
        );
    }

}
