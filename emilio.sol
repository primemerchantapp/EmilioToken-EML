// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the OpenZeppelin preset that includes ERC20, minting, pausing, and burning functionalities.
import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

contract Emilio is ERC20PresetMinterPauser {
    // Conversion: 100,000 EML (with 18 decimals) equals 1 internal credit unit (ERC).
    uint256 public constant TOKENS_PER_ERC = 100_000 * 10**18;
    // Fixed total supply: 100,000,000,000 tokens (with 18 decimals).
    uint256 public constant INITIAL_SUPPLY = 100_000_000_000 * 10**18;

    constructor() ERC20PresetMinterPauser("Emilio", "EML") {
        // Mint the fixed initial supply to the deployer's address.
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    /// @notice Converts a given EML token amount to its equivalent internal credit (ERC) unit.
    /// @param tokenAmount The token amount in wei (EML with 18 decimals).
    /// @return ercValue The number of internal credit units (fractional units are truncated).
    function convertToERC(uint256 tokenAmount) public pure returns (uint256 ercValue) {
        return tokenAmount / TOKENS_PER_ERC;
    }

    /// @notice Converts a given internal credit (ERC) unit amount to its equivalent EML token amount.
    /// @param ercValue The amount in internal credit units.
    /// @return tokenAmount The corresponding token amount in wei (with 18 decimals).
    function convertToEMLFromERC(uint256 ercValue) public pure returns (uint256 tokenAmount) {
        return ercValue * TOKENS_PER_ERC;
    }

    // The following functions are already provided by ERC20PresetMinterPauser:
    // - mint(address to, uint256 amount): allows accounts with MINTER_ROLE to mint new tokens.
    // - burn(uint256 amount) and burnFrom(address account, uint256 amount): to burn tokens.
    // - pause() and unpause(): to pause/unpause token transfers.
    // - transfer(), transferFrom(), approve(), etc.: standard ERC-20 token functions.
}
