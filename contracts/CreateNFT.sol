// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

contract CreateNFT {
    uint private _tokenid = 0;
    mapping (uint => string) private _tokenURIs;

    function createTokenURI(string memory _tokenURI) public
    returns (uint, string memory) {
    _tokenURIs[_tokenid]=_tokenURI;
    _tokenid++;
    return (_tokenid, _tokenURI);
    }

    function getTokenURI(uint _tid) public view returns (string memory){
        string memory _currentURI = _tokenURIs[_tid];
        return _currentURI;
    }

    function getAllTokenURIs() public view returns (string[] memory){
        string[] memory uris = new string[](_tokenid);
        for(uint i=0;i<_tokenid;i++){
            uris[i]=_tokenURIs[i];
        }

        return uris;
    }
}
