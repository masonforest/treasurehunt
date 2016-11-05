var express = require('express')
var bodyParser = require('body-parser')
var Web3 = require('web3');
var web3 = new Web3();
var app = express()
web3.setProvider(new web3.providers.HttpProvider('http://localhost:8546'));

// Live
const CONTRACT_ADDRESS = "0x982b912ab6f309061b52d4c1fd927caef7d2486d";
const ACCOUNT_ADDRESS = "0xc795bac3bcba900350bcb6d6dfec89c274b7382f";
const PASSWORD = "AaWGyzGk8qe2T4nzW5dJ4w5y";



app.use(bodyParser.json());       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
}));

web3.eth.defaultAccount = web3.eth.accounts[0];
treasureHuntAbi = [
{
	"constant": false,
	"inputs": [{
		"name": "latitude",
		"type": "int256"
	},
	{
		"name": "longitude",
		"type": "int256"
	}],
	"name": "IsTreasureHere",
	"outputs": [],
	"type": "function"
},
{
	"inputs": [],
	"type": "constructor"
}];

var TreasureHunt = web3.eth.contract(treasureHuntAbi);

treasureHunt = TreasureHunt.at(CONTRACT_ADDRESS);

app.get('/nextHint', function (req, res) {
  console.log(treasureHunt)
  console.log({
    userId: req.query.userId
  });
  res.send();
})

app.post('/', function (req, res) {
  web3.personal.unlockAccount(ACCOUNT_ADDRESS, PASSWORD, 1000);
  treasureHunt.IsTreasureHere(
    req.body.latitude,
    req.body.longitude
  , function(err, result) {console.log(result)});

  console.log({
    latitiude: req.body.latitude,
    longitude: req.body.longitude,
  });
  res.send();
})

app.listen(process.env.PORT || 3000, function () {
  console.log(`Example app listening on port 3000!`)
})
