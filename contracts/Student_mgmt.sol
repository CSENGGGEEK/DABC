// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Studentmgmt {
    
    // define a struct to store personal information of a student
    struct  Personalinfo {
        string name;
        uint256 dateofbirth;
        string email;
        string addressline1;
        string addressline2;
        string state;
        string city;
        uint256 zip;
        address addr;
        bool isRegistered;
    }
    
    // define a struct to store credit information of a student
    struct creditinfo { 
        string latest_qual;
        mapping (string => mapping(string => string)) credits;
    }
    
    // define a mapping to store personal information of all students
    mapping(address => Personalinfo) personalInfo;

    // define an event to signal when a student has been deleted
    event StudentDeleted(address addr);

    // function to save personal information of a student
    function savePersonalInfo(string memory _name, uint256 _dateofbirth, string memory _email, string memory _addressline1, string memory _addressline2, string memory _state, string memory _city, uint256 _zip, address _addr) public {
        Personalinfo memory info = Personalinfo(_name, _dateofbirth, _email, _addressline1, _addressline2, _state, _city, _zip, _addr, true);
        personalInfo[msg.sender] = info;
    }

    // function to check if a student is registered or not
    function isStudentRegistered(address studentAddr) public view returns (bool) {
        return (personalInfo[studentAddr].isRegistered);
    }

    // function to delete a student
    function deleteStudent(address studentAddr) public {
        // check if the student address is valid
        require(studentAddr != address(0), "Invalid address");

        // check if the student exists
        require(personalInfo[studentAddr].isRegistered, "Student not registered");

        // delete the student record
        delete personalInfo[studentAddr];

        // emit an event to indicate that the student has been deleted
        emit StudentDeleted(studentAddr);
    }

    // event to signal when a student's details have been updated
    event StudentDetailsUpdated(
        address indexed studentAddr,
        string name,
        uint256 dateofbirth,
        string email,
        string addressline1,
        string addressline2,
        string state,
        string city,
        uint256 zip
    );

    // function to update a student's details
    function updateStudentDetails(address studentAddr, string memory name, uint256 dateofbirth, string memory email, string memory addressline1, string memory addressline2, string memory state, string memory city, uint256 zip) public {
        // check if the student exists
        require(personalInfo[studentAddr].isRegistered, "Student not registered");

        // update the student's details
        personalInfo[studentAddr].name = name;
        personalInfo[studentAddr].dateofbirth = dateofbirth;
        personalInfo[studentAddr].email = email;
        personalInfo[studentAddr].addressline1 = addressline1;
        personalInfo[studentAddr].addressline2 = addressline2;
        personalInfo[studentAddr].state = state;
        personalInfo[studentAddr].city = city;
        personalInfo[studentAddr].zip = zip;

        // emit an event to indicate that the student's details have been updated
        emit StudentDetailsUpdated(
            studentAddr,
            name,
            dateofbirth,
            email,
            addressline1,
            addressline2,
            state,
            city,
            zip
        );
    }

}
