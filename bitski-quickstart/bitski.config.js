module.exports = {
  app: {
    id: '0dc7cf3a-b827-4c21-98dc-bc6e21ae6bc0' //change this to your app's client id
  },
  appWallet: {
    client: {
      //if you have an app wallet, add your client id and secret here
      id: 'YOUR-APP-WALLET-ClIENT-ID',
      secret: 'YOUR-APP-WALLET-SECRET'
    },
    auth: {
      tokenHost: 'https://account.bitski.com',
      tokenPath: '/oauth2/token'
    }
  },
  environments: {
    development: {
      network: 'development', //ethereum network to use for local dev
      redirectURL: 'http://localhost:3000/callback.html' //url the popup will redirect to when logged in
    },
    production: {
      network: 'kovan', //ethereum network to use for production
      redirectURL: 'https://mydomain.com/callback.html' //url the popup will redirect to when logged in
    }
  },
  networkIds: {
    kovan: 'kovan',
    rinkeby: 'rinkeby',
    live: 'mainnet',
    development: 'http://localhost:9545' //Update this if you use Ganache or another local blockchain
  }
};
