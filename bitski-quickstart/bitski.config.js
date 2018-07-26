module.exports = {
  app: {
    id: '7c580c00-cd9a-480e-955d-69d499665071' //change this to your app's client id
  },
  appWallet: {
    client: {
      //if you have an app wallet, add your client id and secret here
      id: '1e220be9-c934-487c-9e5d-8bea47a339a6',
      secret: '181wNWi{F5GAOIiWtRt5g4kRbKZRrRvK2Nn65dcnJKU[gH[8[L29a9ylTwh+eykoDi'
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
