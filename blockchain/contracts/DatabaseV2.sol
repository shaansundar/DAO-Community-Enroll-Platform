pragma solidity ^0.8.4;

contract myContract {
    struct memberProfile {
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

    memberProfile[] allMembers;

    mapping(address => bool) private isEnrolled;
    mapping(address => bool) private isAdmin;

    modifier hasEnrolled(address _add) {
        require(!isEnrolled[_add], "This wallet has already been added");
        _;
    }

    constructor() {
        counter = 0;
        isAdmin[msg.sender] = true;
    }

    // calldata is a temporary storage keyword
    function enrollMember(
        string calldata _name,
        string calldata _uid,
        string calldata _officialEmail,
        string calldata _phoneNumber,
        string calldata _whatsappNumber
    ) public hasEnrolled(msg.sender) {
        isEnrolled[msg.sender] = true;
        allMembers.push(
            memberProfile(
                counter,
                block.timestamp,
                msg.sender,
                _name,
                _uid,
                _officialEmail,
                _phoneNumber,
                _whatsappNumber
            )
            counter++;
        );
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
            memberProfile(
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

    function getAllMembers() public view returns (memberProfile[] memory) {
        return allMembers;
    }

    function deleteMember(uint256 _id) public {
        require(isAdmin[msg.sender], "Only admins can invoke");
        remove(_id);
    }

    function remove(uint256 _index) internal {
        require(_index < allMembers.length, "index out of bound");
        require(isAdmin[msg.sender], "Only admins can invoke");

        for (uint256 i = index; i < allMembers.length - 1; i++) {
            allMembers[i] = allMembers[i + i];
        }

        allMembers.pop();
    }

    function callMember(uint256 _id) public view returns(memberProfile memory){
        require(isAdmin[msg.sender], "Only admins can invoke");
        return allMembers[_id];
    }
}
