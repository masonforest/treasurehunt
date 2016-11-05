var express = require('express')
var bodyParser = require('body-parser')
var Tx = require('ethereumjs-tx');
var Web3 = require('web3');
var _ = require('lodash');
var SolidityFunction = require('web3/lib/web3/function');
var web3 = new Web3();
var app = express()
web3.setProvider(new web3.providers.HttpProvider('http://localhost:8545'));

// Live
const ACCOUNT_ADDRESS = "0x06b50b1fee1a46d8803d017e6bf363a3f904d8fe";
const ACCOUNT_KEY = "f90f1c84ffdd40d660ce56392e6b9427bd7922004747980c6841b419b0384641";

const CONTRACT_ADDRESS = "0x6026b764795e29f18304bbe82c7d5ed305dbc41e";
treasureHuntAbi =
[{"constant":true,"inputs":[{"name":"player","type":"address"}],"name":"GetNextHintForPlayer","outputs":[{"name":"nextHint","type":"string"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"latitude","type":"int256"},{"name":"longitude","type":"int256"},{"name":"player","type":"address"}],"name":"CheckAnswerForPlayer","outputs":[{"name":"correct","type":"bool"},{"name":"nextHint","type":"string"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"latitude","type":"int256"},{"name":"longitude","type":"int256"}],"name":"SubmitAnswer","outputs":[],"payable":false,"type":"function"},{"inputs":[],"type":"constructor"}]

app.use(bodyParser.json());       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
}));

web3.eth.defaultAccount = web3.eth.accounts[0];
var TreasureHunt = web3.eth.contract(treasureHuntAbi);

treasureHunt = TreasureHunt.at(CONTRACT_ADDRESS);

app.get('/nextHint', function (req, res) {
  res.send(JSON.stringify({
    hint: treasureHunt.GetNextHintForPlayer(ACCOUNT_ADDRESS)
    video: "video1",
  }));
})

app.get('/balance', function (req, res) {
  web3.eth.getBalance(ACCOUNT_ADDRESS, (err, result) => {
    res.send(result);
  })
})

app.post('/', function (req, res) {
  callEtherumFunction('SubmitAnswer',
    parseInt(req.body.latitude),
    parseInt(req.body.longitude));

  console.log({
    latitiude: req.body.latitude,
    longitude: req.body.longitude,
    success: true
  });
  res.send(JSON.stringify({
    hint: "Got to the first floor",
    video: "video1",
    success: true
  }));
})

function callEtherumFunction(functionName, ...functionArgs) {
  console.log(functionArgs);
  var solidityFunction = new SolidityFunction('', _.find(treasureHuntAbi, { name: functionName }), '');
  var payloadData = solidityFunction.toPayload(functionArgs).data;
  gasPrice = web3.eth.gasPrice;
  console.log(gasPrice)
  gasPriceHex = web3.toHex(gasPrice.times(3));
  gasLimitHex = web3.toHex(300000);
  nonce =  web3.eth.getTransactionCount(ACCOUNT_ADDRESS) ;
  nonceHex = web3.toHex(nonce);
  var rawTx = {
      nonce: nonceHex,
      gasPrice: gasPriceHex,
      gasLimit: gasLimitHex,
      to: CONTRACT_ADDRESS,
      from: ACCOUNT_ADDRESS,
      value: '0x00',
      data: payloadData
  };
  var tx = new Tx(rawTx);
  tx.sign(new Buffer(ACCOUNT_KEY, 'hex'));
  var serializedTx = tx.serialize();
  web3.eth.sendRawTransaction(serializedTx.toString('hex'), function (err, hash) {
      if (err) {
          console.log('Error:');
          console.log(err);
      }
      else {
          console.log('Transaction receipt hash pending');
          console.log(hash);
      }
  });
}
app.listen(process.env.PORT || 3000, function () {
  console.log(`Example app listening on port 3000!`)
})
