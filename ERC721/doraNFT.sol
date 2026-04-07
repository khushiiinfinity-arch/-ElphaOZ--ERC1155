// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


interface IERC721 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) external view returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view returns (address owner) ;
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external payable ;
    function safeTransferFrom(address from, address to, uint256 tokenId) external payable ;
    function transferFrom(address from, address to, uint256 tokenId) external payable;
    function approve(address to, uint256 tokenId) external payable ;
    function setApprovalForAll(address operator, bool approved) external;
    function getApproved(uint256 tokenId) external view returns (address operator);
    function isApprovedForAll(address owner, address operator) external view returns (bool);
    
}

    abstract contract DoraNFT is IERC721 {
    
        string private name;
        string private sym;

        constructor(string memory NFTname,string memory NFTSymbol){
            name = NFTname;
            sym = NFTSymbol;
        }

        mapping(uint256 tokenId => address) private Owners;
        mapping(address owner => uint256) private NFTsOwned;
        mapping(uint256 tokenId => address) private Approvals;
        mapping(address owner => mapping(address Operator => bool )) private OperatorApprovals ;


//
    function balanceOf(address owner) public view override returns (uint256)  {
        require(owner != address(0), "Please give a valid address");
        return NFTsOwned[owner];
    }

//
    function approve(address approvedOwner ,uint256 tokenId) external override payable{
        require(Owners[tokenId]== msg.sender,"Only owner of the token can call this function" );
        Approvals[tokenId] = approvedOwner;
        emit Approval(msg.sender, approvedOwner, tokenId);
    }

    function safeTransferFrom(address from,address to, uint256 tokenId,bytes calldata /*data*/) external override payable{
        require(Approvals[tokenId] == address(from) );
        require(to != address(0));
        Owners[tokenId] = address(to);
    } 

    

    function safeTransferFrom(address from,address to, uint256 tokenId) external override payable {
        require(Approvals[tokenId] == address(from) );
        require(to != address(0));
        Owners[tokenId] = address(to);
    }

    function transferFrom(address from,address to, uint256 tokenId) external override payable {
                require(Approvals[tokenId] == address(from) );
        Owners[tokenId] = address(to);
        emit Transfer(from, to, tokenId);
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        require(Owners[tokenId] != address(0), "Token does not exist");
        return Owners[tokenId];
            }

    function setApprovalForAll(address operator,bool approved) external override {
        require(operator != address(0),"Please provide a valid Operator Addresss");
        OperatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
        
    }


    function getApproved(uint256 tokenId) public view override returns (address) {
        return Approvals[tokenId] ;
    }

    function isApprovedForAll(address owner,address operator) public view  override returns (bool){
       return  OperatorApprovals[owner][operator];
    }
}
