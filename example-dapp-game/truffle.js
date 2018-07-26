// // Configuration suitable for local development

// module.exports = {
//   networks: {
//     development: {
//       host: "localhost",
//       port: 9545,
//       network_id: "*",
//     }
//   }
// };


// Example Truffle Config using a Bitski app wallet

const BitskiTruffleProvider = require('bitski-truffle-provider');

const bitskiCredentials = {
  client: {
    id: '1e220be9-c934-487c-9e5d-8bea47a339a6',
    secret: '72GEDWtO-vL3MX4jQ[bLFuMqf7i+JrTSLJw0{ry5Tf0f-urpkgMNmSm[2EnLlp5pC'
  },
  auth: {
    tokenHost: "https://account.bitski.com/",
    tokenPath: "/oauth2/token"
  }
};

module.exports = {
  networks: {
    live: {
      network_id: '1',
      provider: BitskiTruffleProvider("mainnet", bitskiCredentials),
    },
    kovan: {
      network_id: '42',
      provider: BitskiTruffleProvider("kovan", bitskiCredentials),
    },
    rinkeby: {
      network_id: '4',
      provider: BitskiTruffleProvider("rinkeby", bitskiCredentials),
    },
    development: {
      host: "localhost",
      port: 9545,
      network_id: "*",
    }
  }
};
