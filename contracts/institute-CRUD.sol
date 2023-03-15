// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract AcademicBank {
    // Define a struct for Institution
    struct Institution {
        uint256 id;
        string name;
        string location;
        uint256 totalCredits;
        bool isRegistered;
    }

    // Define mapping to store institutions
    mapping(address => Institution) institutions;

    // Define mapping to store institution IDs
    mapping(uint256 => bool) institutionIds;

    // Define counter to generate unique institution IDs
    uint256 private idCounter = 1;

    // Function to create a new institution
    function createInstitution(string memory _name, string memory _location, uint256 _totalCredits) public {
        require(!institutions[msg.sender].isRegistered, "Institution already exists");

        uint256 newId = getNextId();
        Institution memory newInstitution = Institution(newId, _name, _location, _totalCredits, true);
        institutions[msg.sender] = newInstitution;
        institutionIds[newId] = true;
    }

    // Function to read an institution
    function getInstitution(address _institutionAddress) public view returns (uint256, string memory, string memory, uint256) {
        require(institutions[_institutionAddress].isRegistered, "Institution does not exist");

        Institution memory institution = institutions[_institutionAddress];
        return (institution.id, institution.name, institution.location, institution.totalCredits);
    }

    // Function to update an institution
    function updateInstitution(string memory _name, string memory _location, uint256 _totalCredits) public {
        require(institutions[msg.sender].isRegistered, "Institution does not exist");

        Institution storage institution = institutions[msg.sender];
        institution.name = _name;
        institution.location = _location;
        institution.totalCredits = _totalCredits;
    }

    // Function to delete an institution
    function deleteInstitution() public {
        require(institutions[msg.sender].isRegistered, "Institution does not exist");

        uint256 institutionId = institutions[msg.sender].id;
        delete institutions[msg.sender];
        delete institutionIds[institutionId];
    }

    // Function to get the next unique ID for a new institution
    function getNextId() private returns (uint256) {
        uint256 newId = idCounter;
        idCounter++;
        while (institutionIds[newId]) {
            newId = idCounter;
            idCounter++;
        }
        return newId;
    }
}
