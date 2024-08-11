// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NFTDonation {
    address public owner;

    // Estructura para guardar la información de las donaciones
    struct Donation {
        address donor;
        uint256 amount;
    }

    // Mapeo para almacenar donaciones realizadas a un NFT específico
    mapping(uint256 => Donation[]) public nftDonations;

    // Eventos para seguimiento de donaciones
    event DonationReceived(uint256 indexed nftId, address indexed donor, uint256 amount);
    event FundsWithdrawn(address indexed to, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    // Función para realizar donaciones a un NFT específico
    function donateToNFT(uint256 nftId) external payable {
        require(msg.value > 0, "Donation amount must be greater than 0");

        Donation memory newDonation = Donation({
            donor: msg.sender,
            amount: msg.value
        });

        nftDonations[nftId].push(newDonation);

        emit DonationReceived(nftId, msg.sender, msg.value);
    }

    // Función para que el propietario retire los fondos
    function withdrawFunds() external {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        payable(owner).transfer(balance);

        emit FundsWithdrawn(owner, balance);
    }

    // Obtener el balance total de un NFT específico
    function getNFTBalance(uint256 nftId) public view returns (uint256) {
        uint256 totalBalance = 0;
        for (uint256 i = 0; i < nftDonations[nftId].length; i++) {
            totalBalance += nftDonations[nftId][i].amount;
        }
        return totalBalance;
    }

    // Obtener el número total de donaciones para un NFT específico
    function getNFTDonationCount(uint256 nftId) public view returns (uint256) {
        return nftDonations[nftId].length;
    }
}