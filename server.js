var express = require('express')
var bodyParser = require('body-parser')
var Web3 = require('web3');
var web3 = new Web3();
var app = express()
web3.setProvider(new web3.providers.HttpProvider('http://localhost:8545'));
app.use(bodyParser.json());       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
}));

web3.eth.defaultAccount = web3.eth.accounts[0];
treasureHuntAbi = [{"constant":false,"inputs":[{"name":"latitude","type":"int256"},{"name":"longitude","type":"int256"}],"name":"IsTreasureHere","outputs":[],"type":"function"},{"inputs":[],"type":"constructor"}];
var TreasureHunt = web3.eth.contract(treasureHuntAbi);

treasureHunt = TreasureHunt.at("0xc0ea08a2d404d3172d2add29a45be56da40e2949");

app.post('/', function (req, res) {
  console.log(treasureHunt)
  treasureHunt.IsTreasureHere(
    req.body.latitude,
    req.body.longitude
  );
  console.log({
    latitiude: req.body.latitude,
    longitude: req.body.longitude,
  });
  res.send();
})

app.listen(process.env.PORT || 3000, function () {
  console.log(`Example app listening on port 3000!`)
})
