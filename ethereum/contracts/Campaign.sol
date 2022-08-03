// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9;

contract CampaignFactory {
    address[] public deployedContracts;

    function createCampaign(uint256 minimum) public {
        address newCampaign = address(new Campaign(minimum, msg.sender));
        deployedContracts.push(newCampaign);
    }

    function getDeployedCampaigns() public view returns (address[] memory) {
        return deployedContracts;
    }
}

contract Campaign {
    struct Request {
        string description;
        uint256 value;
        address payable recipient;
        bool complete;
        uint256 approvalCount;
        mapping(address => bool) approvals;
    }

    address public manager;
    mapping(address => bool) public approvers;
    Request[] public requests;
    uint256 public minimumAmount;
    uint256 public approverCount;
    uint256 public balance;

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }

    constructor(uint256 minimum, address creator) {
        manager = creator;
        minimumAmount = minimum;
    }

    function contribute() public payable {
        require(msg.value > minimumAmount);
        if (!approvers[msg.sender]) approverCount++;
        approvers[msg.sender] = true;
        balance += msg.value;
    }

    function createRequest(
        string memory description,
        uint256 value,
        address payable recipient
    ) public restricted {
        Request storage newRequest = requests.push();
        newRequest.description = description;
        newRequest.value = value;
        newRequest.recipient = recipient;
        newRequest.complete = false;
        newRequest.approvalCount = 0;
    }

    function approveRequest(uint256 index) public {
        Request storage request = requests[index];

        require(approvers[msg.sender]);
        require(!request.approvals[msg.sender]);

        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }

    function finalizeRequest(uint256 index) public restricted {
        Request storage request = requests[index];

        require(request.approvalCount > (approverCount / 2));
        require(balance >= request.value);
        require(!request.complete);

        request.recipient.transfer(request.value);
        balance -= request.value;
        request.complete = true;
    }

    function getSummary()
        public
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256,
            address
        )
    {
        return (
            minimumAmount,
            balance,
            requests.length,
            approverCount,
            manager
        );
    }

    function getRequestsCount() public view returns (uint256) {
        return requests.length;
    }
}
