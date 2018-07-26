pragma solidity ^0.4.24;

import './ERC721Token.sol';

contract CitizenSim is ERC721Token {
    string public constant name = "OfficePolitics";
    string public constant symbol = "OP";

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
    
    constructor() public
        ERC721Token(name, symbol)
    {
        owner = msg.sender;
    }
    
    function createCitizen(string _name) public {
        //TODO: Charge 0.01 ETH per creation , by pulic
        //require(msg.sender == owner);
        uint id = citizens.length;
        //uint[7] memory special;
        //uint rand = 0;
        //Check sum of all stat <=30
        //for (uint i=0; i<30; i++) {
        //    rand = random()%6;
        //    special[rand] = special[rand] + 1 ;
        //}
        //require (special[0] + special[1] + special[2] + special[3] + special[4] + special[5] + special[6] <= 30);
        citizens.push(Citizen(_name, uint64(now), 4, 4, 4, 4, 4, 4, 4, 6, uint64(now), 0,0));
        _mint(msg.sender,id);
    }
    function logistics(uint _citizenId) onlyOwnerOf(_citizenId) public {
        uint stamina_base_cost = 1;
        
        require(_citizenId < citizens.length);
        
        Citizen storage myCitizen = citizens[_citizenId];
        require(((now - myCitizen.lastExecutionTime) > STAMINA_REGENRATION) || myCitizen.stamina > 0);
        myCitizen.stamina = myCitizen.stamina + ((now - myCitizen.lastExecutionTime) / STAMINA_REGENRATION);
        require(myCitizen.stamina >= stamina_base_cost);
        
        // - stamina
        myCitizen.stamina = myCitizen.stamina - stamina_base_cost;
        myCitizen.lastExecutionTime = uint64(now);
        
        // Add resources
        myCitizen.resources = myCitizen.resources + 1000;
        
        // 5% of chance to increase stat in working
        if (myCitizen.strength < 10 && random() <= 4 )
        {
            //true
            myCitizen.strength = myCitizen.strength + 1;
            if (totalStat(myCitizen) >= 40)
            {
                if (myCitizen.intelligence > 0) { myCitizen.intelligence = myCitizen.intelligence - 1; }
                else if (myCitizen.perception > 0) { myCitizen.perception = myCitizen.perception - 1; }
                else if (myCitizen.endurance > 0) { myCitizen.endurance = myCitizen.endurance - 1; }
                else if (myCitizen.charisma > 0) { myCitizen.charisma = myCitizen.charisma - 1; }
                else if (myCitizen.agility > 0) { myCitizen.agility = myCitizen.agility - 1; }
                else if (myCitizen.luck > 0) { myCitizen.luck = myCitizen.luck - 1; }
            }
        }
    }
    
    function businessDevelopment(uint _citizenId) onlyOwnerOf(_citizenId) public {
        uint stamina_base_cost = 1;
        
        require(_citizenId < citizens.length);
        
        Citizen storage myCitizen = citizens[_citizenId];
        require(((now - myCitizen.lastExecutionTime) > STAMINA_REGENRATION) || myCitizen.stamina > 0);
        myCitizen.stamina = myCitizen.stamina + ((now - myCitizen.lastExecutionTime) / STAMINA_REGENRATION);
        require(myCitizen.stamina >= stamina_base_cost);
        
        // - stamina
        myCitizen.stamina = myCitizen.stamina - stamina_base_cost;
        myCitizen.lastExecutionTime = uint64(now);
        
        // Add resources
        myCitizen.resources = myCitizen.resources + 1000;
        
        // 5% of chance to increase stat in working
        if (myCitizen.perception < 10 && random() <= 4 )
        {
            //true
            myCitizen.perception = myCitizen.perception + 1;
            if (totalStat(myCitizen) >= 40)
            {
                if (myCitizen.luck > 0) { myCitizen.luck = myCitizen.luck - 1; }
                else if (myCitizen.strength > 0) { myCitizen.strength = myCitizen.strength - 1; }
                else if (myCitizen.endurance > 0) { myCitizen.endurance = myCitizen.endurance - 1; }
                else if (myCitizen.charisma > 0) { myCitizen.charisma = myCitizen.charisma - 1; }
                else if (myCitizen.intelligence > 0) { myCitizen.intelligence = myCitizen.intelligence - 1; }
                else if (myCitizen.agility > 0) { myCitizen.agility = myCitizen.agility - 1; }
            }
        }
    }
    
    function accounting(uint _citizenId) onlyOwnerOf(_citizenId) public {
        uint stamina_base_cost = 1;
        
        require(_citizenId < citizens.length);
        
        Citizen storage myCitizen = citizens[_citizenId];
        require(((now - myCitizen.lastExecutionTime) > STAMINA_REGENRATION) || myCitizen.stamina > 0);
        myCitizen.stamina = myCitizen.stamina + ((now - myCitizen.lastExecutionTime) / STAMINA_REGENRATION);
        require(myCitizen.stamina >= stamina_base_cost);
        
        // - stamina
        myCitizen.stamina = myCitizen.stamina - stamina_base_cost;
        myCitizen.lastExecutionTime = uint64(now);
        
        // Add resources
        myCitizen.resources = myCitizen.resources + 1000;
        
        // 5% of chance to increase stat in working
        if (myCitizen.endurance < 10 && random() <= 4 )
        {
            //true
            myCitizen.endurance = myCitizen.endurance + 1;
            if (totalStat(myCitizen) >= 40)
            {
                if (myCitizen.charisma > 0) { myCitizen.charisma = myCitizen.charisma - 1; }
                else if (myCitizen.strength > 0) { myCitizen.strength = myCitizen.strength - 1; }
                else if (myCitizen.perception > 0) { myCitizen.perception = myCitizen.perception - 1; }
                else if (myCitizen.intelligence > 0) { myCitizen.intelligence = myCitizen.intelligence - 1; }
                else if (myCitizen.agility > 0) { myCitizen.agility = myCitizen.agility - 1; }
                else if (myCitizen.luck > 0) { myCitizen.luck = myCitizen.luck - 1; }
            }
        }
    }
    
    function marketing(uint _citizenId) onlyOwnerOf(_citizenId) public {
        uint stamina_base_cost = 1;
        
        require(_citizenId < citizens.length);
        
        Citizen storage myCitizen = citizens[_citizenId];
        require(((now - myCitizen.lastExecutionTime) > STAMINA_REGENRATION) || myCitizen.stamina > 0);
        myCitizen.stamina = myCitizen.stamina + ((now - myCitizen.lastExecutionTime) / STAMINA_REGENRATION);
        require(myCitizen.stamina >= stamina_base_cost);
        
        // - stamina
        myCitizen.stamina = myCitizen.stamina - stamina_base_cost;
        myCitizen.lastExecutionTime = uint64(now);
        
        // Add resources
        myCitizen.resources = myCitizen.resources + 1000;
        
        // 5% of chance to increase stat in working
        if (myCitizen.charisma < 10 && random() <= 4 )
        {
            //true
            myCitizen.charisma = myCitizen.charisma + 1;
            if (totalStat(myCitizen) >= 40)
            {
                if (myCitizen.endurance > 0) { myCitizen.endurance = myCitizen.endurance - 1; }
                else if (myCitizen.strength > 0) { myCitizen.strength = myCitizen.strength - 1; }
                else if (myCitizen.perception > 0) { myCitizen.perception = myCitizen.perception - 1; }
                else if (myCitizen.intelligence > 0) { myCitizen.intelligence = myCitizen.intelligence - 1; }
                else if (myCitizen.agility > 0) { myCitizen.agility = myCitizen.agility - 1; }
                else if (myCitizen.luck > 0) { myCitizen.luck = myCitizen.luck - 1; }
            }
        }
    }
    
    function it(uint _citizenId) onlyOwnerOf(_citizenId) public {
        uint stamina_base_cost = 1;
        
        require(_citizenId < citizens.length);
        
        Citizen storage myCitizen = citizens[_citizenId];
        require(((now - myCitizen.lastExecutionTime) > STAMINA_REGENRATION) || myCitizen.stamina > 0);
        myCitizen.stamina = myCitizen.stamina + ((now - myCitizen.lastExecutionTime) / STAMINA_REGENRATION);
        require(myCitizen.stamina >= stamina_base_cost);
        
        // - stamina
        myCitizen.stamina = myCitizen.stamina - stamina_base_cost;
        myCitizen.lastExecutionTime = uint64(now);
        
        // Add resources
        myCitizen.resources = myCitizen.resources + 1000;
        
        // 5% of chance to increase stat in working
        if (myCitizen.intelligence < 10 && random() <= 4 )
        {
            //true
            myCitizen.intelligence = myCitizen.intelligence + 1;
            if (totalStat(myCitizen) >= 40)
            {
                if (myCitizen.strength > 0) { myCitizen.strength = myCitizen.strength - 1; }
                else if (myCitizen.perception > 0) { myCitizen.perception = myCitizen.perception - 1; }
                else if (myCitizen.endurance > 0) { myCitizen.endurance = myCitizen.endurance - 1; }
                else if (myCitizen.charisma > 0) { myCitizen.charisma = myCitizen.charisma - 1; }
                else if (myCitizen.agility > 0) { myCitizen.agility = myCitizen.agility - 1; }
                else if (myCitizen.luck > 0) { myCitizen.luck = myCitizen.luck - 1; }
            }
        }
    }
    
    function security(uint _citizenId) onlyOwnerOf(_citizenId) public {
        uint stamina_base_cost = 1;
        
        require(_citizenId < citizens.length);
        
        Citizen storage myCitizen = citizens[_citizenId];
        require(((now - myCitizen.lastExecutionTime) > STAMINA_REGENRATION) || myCitizen.stamina > 0);
        myCitizen.stamina = myCitizen.stamina + ((now - myCitizen.lastExecutionTime) / STAMINA_REGENRATION);
        require(myCitizen.stamina >= stamina_base_cost);
        
        // - stamina
        myCitizen.stamina = myCitizen.stamina - stamina_base_cost;
        myCitizen.lastExecutionTime = uint64(now);
        
        // Add resources
        myCitizen.resources = myCitizen.resources + 1000;
        
        // 5% of chance to increase stat in working
        if (myCitizen.agility < 10 && random() <= 4 )
        {
            //true
            myCitizen.agility = myCitizen.agility + 1;
            if (totalStat(myCitizen) >= 40)
            {
                if (myCitizen.perception > 0) { myCitizen.perception = myCitizen.perception - 1; }
                else if (myCitizen.strength > 0) { myCitizen.strength = myCitizen.strength - 1; }
                else if (myCitizen.endurance > 0) { myCitizen.endurance = myCitizen.endurance - 1; }
                else if (myCitizen.charisma > 0) { myCitizen.charisma = myCitizen.charisma - 1; }
                else if (myCitizen.intelligence > 0) { myCitizen.intelligence = myCitizen.intelligence - 1; }
                else if (myCitizen.luck > 0) { myCitizen.luck = myCitizen.luck - 1; }
            }
        }
    }
    
    function hr(uint _citizenId) onlyOwnerOf(_citizenId) public {
        uint stamina_base_cost = 1;
        
        require(_citizenId < citizens.length);
        
        Citizen storage myCitizen = citizens[_citizenId];
        require(((now - myCitizen.lastExecutionTime) > STAMINA_REGENRATION) || myCitizen.stamina > 0);
        myCitizen.stamina = myCitizen.stamina + ((now - myCitizen.lastExecutionTime) / STAMINA_REGENRATION);
        require(myCitizen.stamina >= stamina_base_cost);
        
        // - stamina
        myCitizen.stamina = myCitizen.stamina - stamina_base_cost;
        myCitizen.lastExecutionTime = uint64(now);
        
        // Add resources
        myCitizen.resources = myCitizen.resources + 1000;
        
        // 5% of chance to increase stat in working
        if (myCitizen.agility < 10 && random() <= 4 )
        {
            //true
            myCitizen.agility = myCitizen.agility + 1;
            if (totalStat(myCitizen) >= 40)
            {
                if (myCitizen.perception > 0) { myCitizen.perception = myCitizen.perception - 1; }
                else if (myCitizen.strength > 0) { myCitizen.strength = myCitizen.strength - 1; }
                else if (myCitizen.endurance > 0) { myCitizen.endurance = myCitizen.endurance - 1; }
                else if (myCitizen.charisma > 0) { myCitizen.charisma = myCitizen.charisma - 1; }
                else if (myCitizen.intelligence > 0) { myCitizen.intelligence = myCitizen.intelligence - 1; }
                else if (myCitizen.luck > 0) { myCitizen.luck = myCitizen.luck - 1; }
            }
        }
    }
    
    function totalStat(Citizen myCitizen)private view returns(uint)
    {
        return myCitizen.strength + myCitizen.perception + myCitizen.endurance + myCitizen.charisma + myCitizen.intelligence + myCitizen.agility + myCitizen.luck;
    }
    
    /**
     * @dev generates a random number between 0-99 
     * @return the random number in uint256
     */
    function random() private view returns (uint256) {
        uint256 seed = uint256(keccak256(abi.encodePacked(
            
            (block.timestamp).add
            (block.difficulty).add
            ((uint256(keccak256(abi.encodePacked(block.coinbase)))) / (now)).add
            (block.gaslimit).add
            ((uint256(keccak256(abi.encodePacked(msg.sender)))) / (now)).add
            (block.number)
            
        )));
        return (seed - ((seed / 1000) * 1000));
    }

        //battle
    function battle(uint _citizenId, uint _targetId) onlyOwnerOf(_citizenId) public {
        require(_citizenId < citizens.length);
        require(_targetId < citizens.length);
        require(_citizenId != _targetId);
        Citizen storage myCitizen = citizens[_citizenId];
        Citizen storage targetCitizen = citizens[_targetId];
        require(myCitizen.resources >= 500);
        require(targetCitizen.resources >= 500);
        uint myBattlePower = _BattleScoreCal(myCitizen.strength , myCitizen.perception , myCitizen.endurance , myCitizen.charisma , myCitizen.intelligence , myCitizen.agility , myCitizen.luck,uint(blockhash(block.number-1))%3 + 1);
        uint targetBattlePower = _BattleScoreCal(targetCitizen.strength, targetCitizen.perception , targetCitizen.endurance , targetCitizen.charisma , targetCitizen.intelligence , targetCitizen.agility , targetCitizen.luck,uint(blockhash(block.number-1))%3 + 1);
        
        if(myBattlePower>=targetBattlePower){
            myCitizen.resources = myCitizen.resources + 500; 
            targetCitizen.resources = targetCitizen.resources -500;
        }else{
            targetCitizen.resources = targetCitizen.resources +500 ;
            myCitizen.resources = myCitizen.resources-500;
        }
        myCitizen.lastExecutionTime = uint64(now);
    }
    function _BattleScoreCal(uint _s, uint _p, uint _e, uint _c, uint _i, uint _a, uint _l, uint _mode)private

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
    
    
    function luckmodifier(uint rawScore , uint _l )private returns(uint answer)
    {
        uint random_number = uint(blockhash(block.number-1))%10 + 1;
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
