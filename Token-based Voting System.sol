// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract TokenVoting {
    address public admin;
    IERC20 public token;
    mapping(address => uint256) public votes;

    event Voted(address indexed voter, uint256 votes);

    constructor(address _token) {
        admin = msg.sender;
        token = IERC20(_token);
    }

    function vote(uint256 amount) external {
        require(amount > 0, "Cannot vote with zero tokens");
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        votes[msg.sender] += amount;
        emit Voted(msg.sender, amount);
    }

    function getVotes(address user) external view returns (uint256) {
        return votes[user];
    }

    function totalVotes() external view returns (uint256) {
        uint256 total = 0;
        for (address voter : getAllVoters()) {
            total += votes[voter];
        }
        return total;
    }

    function getAllVoters() internal view returns (address[] memory) {
        // Custom logic to return list of all voters (implementation depends on your use case)
    }
}