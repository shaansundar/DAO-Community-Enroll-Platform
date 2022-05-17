// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Database {
    struct MemberProfile {
        uint256 index;
        uint256 timeEnrolled;
        address walletAddress;
        string name;
        string uid;
        string officialEmail;
        string phoneNumber;
        string whatsappNumber;
    }

    uint256 counter;
    MemberProfile[] allMembers;
    mapping(address => bool) private isEnrolled;
    mapping(address => bool) private isAdmin;

    modifier hasEnrolled(address _add) {
        require(!isEnrolled[_add], "This wallet has already been added");
        _;
    }

    constructor() {
        counter = 0;
        isAdmin[msg.sender]=true;
    }

    function enrollMember(
        string calldata _name,
        string calldata _uid,
        string calldata _officialEmail,
        string calldata _phoneNumber,
        string calldata _whatsappNumber
    ) public hasEnrolled(msg.sender) {
        isEnrolled[msg.sender] = true;
        allMembers.push(
            MemberProfile(
                counter,
                block.timestamp,
                msg.sender,
                _name,
                _uid,
                _officialEmail,
                _phoneNumber,
                _whatsappNumber
            )
        );
        counter++;
    }
    function delegateEnrollMember(
        address _address,
        string calldata _name,
        string calldata _uid,
        string calldata _officialEmail,
        string calldata _phoneNumber,
        string calldata _whatsappNumber
    ) public hasEnrolled(_address) {
        require(isAdmin[msg.sender], "Only admins can invoke");
        isEnrolled[_address] = true;
        allMembers.push(
            MemberProfile(
                counter,
                block.timestamp,
                _address,
                _name,
                _uid,
                _officialEmail,
                _phoneNumber,
                _whatsappNumber
            )
        );
        counter++;
    }

    function getAllMembers() public view returns(MemberProfile[] memory){
        return allMembers;
    }

    function deleteMember(uint256 _id) public{
        require(isAdmin[msg.sender], "Only admins can invoke");
        remove(_id);
    }

    function remove(uint _index) internal {
        require(_index < allMembers.length, "index out of bound");
        require(isAdmin[msg.sender], "Only admins can invoke");

        for (uint i = _index; i < allMembers.length - 1; i++) {
            allMembers[i] = allMembers[i + 1];
        }
        allMembers.pop();
    }
}
