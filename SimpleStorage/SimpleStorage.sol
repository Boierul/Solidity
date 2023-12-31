// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract SimpleStorage {
    // Global variable to store a number
    uint256 myFavoriteNumber;

    // Struct to store a custom type
    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    // Array of Person structs
    Person[] public listOfPeople;
    // Mapping of string to uint256 (name to favorite number)
    mapping(string => uint256) public nameToFavoriteNumber;

    // Function to store a number on the blockchain
    function store(uint256 _favoriteNumber) public {
        myFavoriteNumber = _favoriteNumber;
    }

    // Function to retrieve the stored numberfrom the blockchain
    function retrieve() public view returns (uint256) {
        return myFavoriteNumber;
    }

    // Function to add a Person to the array and map their name to their favorite number on the blockchain
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
