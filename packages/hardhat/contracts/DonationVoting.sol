// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DonationVoting {
    address public owner;
    uint256 public maintenanceVotes;
    uint256 public personnelVotes;
    uint256 public infrastructureVotes;
    uint256 public totalVotes;
    uint256 public constant MAX_VOTES = 23;
    uint256 public donationBalance;

    enum Category {Maintenance, Personnel, Infrastructure}

    struct Vote {
        address voter;
        Category category;
    }

    mapping(address => bool) public hasVoted;
    Vote[] public votes;

    event VoteCasted(address indexed voter, Category category);
    event FundsAllocated(Category category, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can execute this");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Función para realizar donaciones
    function donate() external payable {
        require(msg.value > 0, "Donation amount must be greater than 0");
        donationBalance += msg.value;
    }

    // Función para votar en una categoría
    function vote(Category _category) external {
        require(!hasVoted[msg.sender], "You have already voted");
        require(totalVotes < MAX_VOTES, "Maximum votes reached");

        hasVoted[msg.sender] = true;
        votes.push(Vote({voter: msg.sender, category: _category}));
        totalVotes++;

        if (_category == Category.Maintenance) {
            maintenanceVotes++;
        } else if (_category == Category.Personnel) {
            personnelVotes++;
        } else if (_category == Category.Infrastructure) {
            infrastructureVotes++;
        }

        emit VoteCasted(msg.sender, _category);

        // Verificar si se alcanzó el máximo de votos
        if (totalVotes == MAX_VOTES) {
            allocateFunds();
        }
    }

    // Función para asignar fondos según los resultados de la votación
    function allocateFunds() internal {
        Category winningCategory;

        if (maintenanceVotes > personnelVotes && maintenanceVotes > infrastructureVotes) {
            winningCategory = Category.Maintenance;
        } else if (personnelVotes > maintenanceVotes && personnelVotes > infrastructureVotes) {
            winningCategory = Category.Personnel;
        } else {
            winningCategory = Category.Infrastructure;
        }

        emit FundsAllocated(winningCategory, donationBalance);

        // Restablecer la votación para la próxima ronda
        resetVoting();
    }

    // Restablecer la votación
    function resetVoting() internal {
        totalVotes = 0;
        maintenanceVotes = 0;
        personnelVotes = 0;
        infrastructureVotes = 0;

        for (uint256 i = 0; i < votes.length; i++) {
            hasVoted[votes[i].voter] = false;
        }

        delete votes;
    }

    // Función para que el propietario retire los fondos
    function withdrawFunds() external onlyOwner {
        require(donationBalance > 0, "No funds to withdraw");
        payable(owner).transfer(donationBalance);
        donationBalance = 0;
    }
}