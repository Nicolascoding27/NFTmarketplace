//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
// contract NFT {
contract NFT is ERC721, ERC721Enumerable {
  using Counters for Counters.Counter;
  Counters.Counter private _idCounter;
  uint256 public  _maxSupply;
  constructor(uint256 _maxSupply) ERC721("NICOBABY", "NBB") {

  }
    function mint () public {
        uint256 current = _idCounter.current();
        _safeMint(msg.sender, current);
        _idCounter.increment();
    }

  // Necessary to support enumn
  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 tokenId
  ) internal override(ERC721, ERC721Enumerable) {
    super._beforeTokenTransfer(from, to, tokenId);
  }

  function supportsInterface(bytes4 interfaceId)
    public
    view
    override(ERC721, ERC721Enumerable)
    returns (bool)
  {
    return super.supportsInterface(interfaceId);
  }

  // function greet() public view returns (string memory) {
  //     return greeting;
  // }

  // function setGreeting(string memory _greeting) public {
  //     console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
  //     greeting = _greeting;
  // }
}
