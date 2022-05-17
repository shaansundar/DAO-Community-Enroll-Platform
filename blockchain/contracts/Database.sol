// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Database {
    struct MemberProfile {
        uint256 index;
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
        counter = 1;
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
}
