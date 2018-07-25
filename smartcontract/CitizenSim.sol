pragma solidity ^0.4.24;

import './ERC721Token.sol';

contract CitizenSim is ERC721Token {
    struct Citizen {
        string name;
        uint64 birthTime;
        uint stamina;
        uint strength;
        uint perception;
        uint endurance;
        uint charisma;
        uint intelligence;
        uint agility;
        uint luck;
        uint64 lastExecutionTime;
        uint64 experience;
        uint totalTask;
        uint256 money;
    }
    
    
    //Make Referral Line need to pay
    //get % creation fee
    //extra money
    
    //Battle Mechanism
    //SPECIAL improve
    //New Actions
    //Random Encounter
    
    
    Citizen[] public citizens;
    address public owner;
    uint public constant STAMINA_REGENRATION = 1 days;
    
    constructor() public{
        owner = msg.sender;
        
        
    }
    
    function createCitizen(string _name, address _to, uint _strength, uint _perception, uint _endurance, uint _charisma, uint _intelligence, uint _agility, uint _luck) public {
        //TODO: Charge 0.01 ETH per creation , by pulic
        //require(msg.sender == owner);
        uint id = citizens.length;
        //Check sum of all stat <=30
        require (_strength + _perception + _endurance + _charisma + _intelligence + _agility + _luck <= 30);
        citizens.push(Citizen(_name, uint64(now), _endurance, _strength, _perception, _endurance, _charisma, _intelligence, _agility, _luck, uint64(now), 0,0));
        _mint(_to,id);
    }
    
    function battle(uint _citizenId, uint _targetId) onlyOwnerOf(_citizenId) public {
        require(_citizenId < citizens.length);
        require(_targetId < citizens.length);
        Citizen storage myCitizen = citizen[_citizenId];
        Citizen storage targetCitizen = citizen[_targetId];
        
    }
    
    function Hackathon(uint _citizenId) onlyOwnerOf(_citizenId) public {
        uint stamina_base_cost = 1;
        uint exp_prerequisite = 0;
        uint base_exp = 1;
        
        require(_citizenId < citizens.length);
        
        Citizen storage myCitizen = citizen[_citizenId];
        require(((myCitizen.lastExecutionTime - now) > STAMINA_REGENRATION) || myCitizen.stamina > 0);
        myCitizen.stamina = myCitizen.stamina + (myCitizen.lastExecutionTime - now) / STAMINA_REGENRATION;
        
        require(myCitizen.stamina >= stamina_base_cost);
        require(myCitizen.experience >= exp_prerequisite);
        
        myCitizen.experience = myCitizen.experience + base_exp;
        myCitizen.stamina = myCitizen.stamina - stamina_base_cost;
        myCitizen.lastExecutionTime = uint64(now);
        myCitizen.totalTask ++;
    }
    
    function action
    
}
