// Simple example app that demonstrates sign in, sign out, using web3,
// and initializing contracts from truffle.

import { Bitski } from 'bitski';
import Contract from './contract';
//import TokenService from './services/TokenService.js';

// Import any contracts you want to use from the build folder.
// Here we've imported the sample contract.
import artifacts from '../build/contracts/CitizenSim.json';

export default class App {
  /**
   * Creates the app.
   */
  constructor() {
    // Initialize bitski and web3
    this.bitski = new Bitski(BITSKI_CLIENT_ID, BITSKI_REDIRECT_URL);
    this.web3 = this.bitski.getWeb3(BITSKI_PROVIDER_ID);
    // Initialize the sample contract
    this.contract = new Contract(this.web3, artifacts);
  }

  /**
   * Starts the application.
   */
  start() {
    // Check if this is the callback page - if so, notify Bitski SDK
    if (window.location.href === BITSKI_REDIRECT_URL) {
      this.bitski.signInCallback();
      return;
    }
    // Setup the interface
    this.configureView();
    this.checkLoggedInStatus();
  }

  /**
   * One-time setup of the interface.
   */
  configureView() {
    // Store various UI elements
    this.loadingContainer = document.getElementById('loading');
    this.signedInContainer = document.getElementById('signed-in');
    this.signedOutContainer = document.getElementById('signed-out');
     this.createCharacterArea = document.getElementById('create-character-area');
    this.characterDetailContainer = document.getElementById('character-detail-field');
     this.characterDetailArea = document.getElementById('character-detail-area');
     this.characterActionsArea = document.getElementById('character-actions-area');
     this.characterActionsEnemyArea = document.getElementById('character-actions-enemy-area');
     this.queryCitizenArea = document.getElementById('query-citizen-area');
     this.walletAddressContainer = document.getElementById('wallet-address');
     this.queryCitizenContainer = document.getElementById('query-citizen');
     this.citizenIdContainer = document.getElementById('citizen-id');
     this.currentCitizenContainer = document.getElementById('current-citizen-id');
    this.errorContainer = document.getElementById('error');
    // Set up connect button
    const connectElement = document.getElementById('connect-button');
    this.connectButton = this.bitski.getConnectButton(connectElement);
    this.connectButton.callback = (error, user) => {
      if (error) {
        this.setError(error);
      }
      this.validateUser(user);
    }
    // Set up log out button
    this.logOutButton = document.getElementById('log-out');
    this.logOutButton.addEventListener('click', (event) => {
      event.preventDefault();
      this.signOut();
    });
    // Query Citizen ID button
    this.queryCitizenButton = document.getElementById('query-citizen-button');
    // Set up createCitizen button
    this.createCitizenButton = document.getElementById('create-citizen');
    // Set up logistics button
    this.logisticsButton = document.getElementById('logistics');
    // Set up businessDevelopment
    this.businessDevelopmentButton = document.getElementById('businessDevelopment');
    // Set up accounting
    this.accountingButton = document.getElementById('accounting');
    // Set up marketing
    this.marketingButton = document.getElementById('marketing');
    // Set up it
    this.itButton = document.getElementById('it');
    // Set up security
    this.securityButton = document.getElementById('security');
    // Set up hr
    this.hr = document.getElementById('hr');
    // Set up battle
    this.battle = document.getElementById('battle');
  }

  /**
   * Checks whether or not the user is current logged in to Bitski.
   */
  checkLoggedInStatus() {
    console.log(this.bitski);
    console.log(this.bitski.getUser());
    this.bitski.getUser().then(user => {
      this.toggleLoading(false);
      this.validateUser(user);
    }).catch(error => {
      this.toggleLoading(false);
      this.setError(error);
      showLoginButton();
    });
  }

  /**
   * Toggles the loading state
   * @param {boolean} show whether or not to show the loading state
   */
  toggleLoading(show) {
    this.loadingContainer.style.display = show === true ? 'block' : 'none';
  }

  /**
   * Checks whether or not the user we received is valid, and configures the UI.
   * @param {Object} user the user returned from Bitski.getUser() or Bitski.signIn()
   */
  validateUser(user) {
    console.log("val");
    console.log(user);
    if (user && !user.expired) {
      //Set up the contract
      this.contract.deployed().then(instance => {
        this.contractInstance = instance;
        // Show the app UI
        this.showApp();
      }).catch(error => {
        this.setError(error);
      });
    } else {
      this.showLoginButton();
    }
  }

  /**
   * Configure the UI to show or hide an error
   * @param {error | null} error error to show in the UI, or null to clear.
   */
  setError(error) {
    if (error) {
      this.errorContainer.innerHTML = error;
      console.error(error);
    } else {
      this.errorContainer.innerHTML = '';
    }
  }

  /**
   * Show the main app (logged in) UI
   */
  showApp() {
    console.log('a')
    this.signedOutContainer.style.display = 'none';
    console.log('b')
    this.signedInContainer.style.display = 'block';
    console.log('logging')
        this.web3.eth.getAccounts().then(accounts => {
      this.currentAccount = accounts[0];
      if (accounts[0]) {
        console.log('logged in')
        this.walletAddressContainer.innerHTML = accounts[0];
      } else {
        console.log('no address found')
      }
    }).catch(error => {
      this.setError(error);
    });
    // From this point, you should be able to interact with web3 and contractInstance
    console.log('from this point')
    /*this.web3.eth.getAccounts().then(accounts => {
      this.currentAccount = accounts[0];
      if (accounts[0]) {
        this.walletAddressContainer.innerHTML = accounts[0];
        var balance = TokenService.currentNetwork().then(function(tokenService ){
                return tokenService.balance().then(function(tokens) {
                    if (balance == 0)
                    {
                      this.createCharacterArea.style.display = 'block';
                      this.queryCitizenArea.style.display = 'none';
                      this.characterDetailArea.style.dispay = 'none';
                    }
                    else
                    {
                      this.createCharacterArea.style.display = 'none';
                      this.queryCitizenArea.style.display = 'block';
                      this.characterDetailArea.style.dispay = 'block';
                    }
                  });
        
      } else {
        console.log('no address found')
      }
    }).catch(error => {
      this.setError(error);
    });*/
  }

  /**
   * Show the logged out UI
   */
  showLoginButton() {
    this.signedOutContainer.style.display = 'block';
    this.signedInContainer.style.display = 'none';
  }

  /**
   * Signs the current user out of Bitski and updates the UI.
   */
  signOut() {
    this.bitski.userManager.removeUser();
    this.contractInstance = null;
    this.showLoginButton();
  }

  configureMetamaskButton() {
  var metamaskButton = document.getElementById('metamask-button');
    if (metamaskButton) {
      metamaskButton.style.fontFamily = '-apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, Oxygen, \'Helvetica Neue\', sans-serif';
      metamaskButton.style.fontWeight = 'bold';
      metamaskButton.style.backgroundColor = '#F79220';
      metamaskButton.style.backgroundRepeat = 'no-repeat';
      metamaskButton.style.backgroundPositionY = '50%';
      metamaskButton.style.color = '#fff';
      metamaskButton.style.border = 'none';
      metamaskButton.style.margin = '0';
      metamaskButton.style.padding = '0';
      metamaskButton.style.cursor = 'pointer';
      metamaskButton.style.borderRadius = '6px';
      metamaskButton.style.fontSize = '12px';
      metamaskButton.style.height = '28px';
      metamaskButton.style.lineHeight = '28px';
      metamaskButton.style.paddingLeft = '14px';
      metamaskButton.style.paddingRight = '14px';

      metamaskButton.onclick = function() {
        web3 = new Web3(web3.currentProvider)
        showApp(web3);
      };

      if (typeof(web3) !== 'undefined') {
        metamaskButton.style.display = 'block';
      } else {
        metamaskButton.style.display = 'none';
      }
    }
  }
}
