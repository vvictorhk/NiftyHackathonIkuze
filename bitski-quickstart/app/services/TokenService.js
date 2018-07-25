/**
 * This JSON file was created by Truffle and contains the ABI of our contract
 * as well as the address for any networks we have deployed it to.
 */
const lmnftArtifacts = require('../../build/contracts/CitizenSim.json');

export default class TokenService {
    /**
     * Since our contract will have different addresses depending on which network
     * it is deployed on we need to load the network ID before we can initialize the
     * contract. This will happen async.
     */
    static currentNetwork() {
        return web3.eth.net.getId().then(function(networkID){
            return web3.eth.getAccounts().then(function(accounts){
                return new TokenService(networkID, accounts[0]);
            });
        });
    }

    /**
     * Loads our contract from its ABI.
     *
     * @param {string} networkID The network ID of the network we are deployed on.
     * @param {string} defaultAccount The account we will be sending from.
     */
    constructor(networkID, defaultAccount) {
        if (lmnftArtifacts && lmnftArtifacts.abi) {
            const abi = lmnftArtifacts.abi;
            if (lmnftArtifacts.networks && lmnftArtifacts.networks[networkID] && lmnftArtifacts.networks[networkID].address) {
                const address = lmnftArtifacts.networks[networkID].address;
                this.contract = new web3.eth.Contract(abi, address);
                this.contract.setProvider(window.web3.currentProvider);
                let account = defaultAccount || window.web3.eth.defaultAccount;
                if (account) {
                    this.contract.defaultAccount = account;
                    this.contract.options.from = account;
                }
            } else {
                throw Error(`Contract not deployed on current network (${networkID}). Run truffle migrate first and try again.`);
            }
        } else {
            throw Error('Contract not compiled or not found');
        }

    }

    /**
     * Creates a new token, as long as we are not over our limit.
     */
     //createCitizen(string _name, address _to, uint _strength, uint _perception, uint _endurance, uint _charisma, uint _intelligence, uint _agility, uint _luck)
    createCitizen() {
        let randomTokenID = web3.utils.randomHex(32);
        return this.contract.methods.mint(randomTokenID);
    }

    logistics(token)
    {
        return this.contract.methods.logistics(this.contract._address, token);
    }
    businessDevelopment(token)
    {
        return this.contract.methods.businessDevelopment(this.contract._address, token);
    }
    accounting(token)
    {
        return this.contract.methods.accounting(this.contract._address, token);
    }
    marketing(token)
    {
        return this.contract.methods.marketing(this.contract._address, token);
    }
    it(token)
    {
        return this.contract.methods.it(this.contract._address, token);
    }
    security(token)
    {
        return this.contract.methods.security(this.contract._address, token);
    }
    hr(token)
    {
        return this.contract.methods.hr(this.contract._address, token);
    }
    //battle(uint _citizenId, uint _targetId) onlyOwnerOf(_citizenId)
    battle(token, targetId)
    {
        return this.contract.methods.battle(this.contract._address, token, targetId);
    }

    /**
     * Deletes a token by transfering it to the contract address.
     *
     * @param {string} token the ID of the token we want to delete.
     */
    delete(token) {
        return this.contract.methods.transfer(this.contract._address, token);
    }

    /**
     * Gets a list of all tokens owned by us.
     */
    list() {
        return this.contract.methods.getOwnerTokens(this.contract.defaultAccount).call();
    }

    /**
     * Gets a count of our tokens.
     */
    balance() {
        return this.contract.methods.balanceOf(this.contract.defaultAccount).call();
    }
}
