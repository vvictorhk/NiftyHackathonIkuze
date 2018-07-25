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
        uint totalTask;
        uint256 resources;
    }
    
    
    //TODO: Make Referral Line
    //get % creation fee
    //extra money
    
    //Battle Mechanism
    //TODO: Random Encounter
    
    
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
        Citizen storage myCitizen = citizens[_citizenId];
        Citizen storage targetCitizen = citizens[_targetId];
        
    }
    
    function Logistics(uint _citizenId) onlyOwnerOf(_citizenId) public {
        uint stamina_base_cost = 1;
        
        require(_citizenId < citizens.length);
        
        Citizen storage myCitizen = citizens[_citizenId];
        require(((myCitizen.lastExecutionTime - now) > STAMINA_REGENRATION) || myCitizen.stamina > 0);
        myCitizen.stamina = myCitizen.stamina + (myCitizen.lastExecutionTime - now) / STAMINA_REGENRATION;
        require(myCitizen.stamina >= stamina_base_cost);
        
        // - stamina
        myCitizen.stamina = myCitizen.stamina - stamina_base_cost;
        myCitizen.lastExecutionTime = uint64(now);
        
        // Add resources
        myCitizen.resources = myCitizen.resources + 1000;
        
        // Random add stat
        
    }
	//battle
    function battle(uint _citizenId, uint _targetId, uint _mode) onlyOwnerOf(_citizenId) public {
        require(_citizenId < citizens.length);
        require(_targetId < citizens.length);
        Citizen storage myCitizen = citizens[_citizenId];
        Citizen storage targetCitizen = citizens[_targetId];
        uint myBattlePower = myCitizen.strength + myCitizen.perception + myCitizen.endurance + myCitizen.charisma + myCitizen.intelligence + myCitizen.agility + myCitizen.luck;
        uint targetBattlePower = targetCitizen.strength + targetCitizen.perception + targetCitizen.endurance + targetCitizen.charisma + targetCitizen.intelligence + targetCitizen.agility + targetCitizen.luck;
        
        
        myCitizen.lastExecutionTime = uint64(now);
    }
    function _BattleScoreCal(uint _s, uint _p, uint _e, uint _c, uint _i, uint _a, uint _l, uint _mode)public 

        returns (uint answer){
        if (_mode == 1){
            answer = luckmodifier(_s * 4 +_p * 0 +_e * 4 + _c * 0 + _i * 0 +_a * 2,_l);
        }else if(_mode == 2){
            answer = luckmodifier(_s * 0 +_p * 4 +_e * 0 + _c * 0 + _i * 2 +_a * 4,_l);
        }else{
            answer = luckmodifier(_s * 1 +_p * 0 +_e * 0 + _c * 6 + _i * 3 +_a * 0,_l);
        }
        return answer;
    }
    
    
    function luckmodifier(uint rawScore , uint _l )public  
        returns(uint answer){
            uint random_number = uint(block.blockhash(block.number-1))%10 + 1;
             answer = rawScore;
            if (_l < random_number){
                answer = rawScore * 125;
            }else if(_l > random_number){
                answer = rawScore * 75;
            }else{
                answer = rawScore;
            }
        }
    
}
