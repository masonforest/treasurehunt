package main

//go:generate abigen --sol TreasureHunt.sol --pkg main --out TreasureHunt.go

import (
	"crypto/ecdsa"
	"flag"
	"log"
	"math/big"
	"os"
	"testing"

	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/accounts/abi/bind/backends"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/stretchr/testify/assert"
)

var (
	key0             *ecdsa.PrivateKey
	account0         common.Address
	auth             *bind.TransactOpts
	backend          *backends.SimulatedBackend
	GAS_LIMIT        = big.NewInt(500000)
	NONCE            = big.NewInt(2)
	STARTING_BALANCE = big.NewInt(1000000000000000)
)

func TestMain(m *testing.M) {
	key0, _ = crypto.GenerateKey()
	account0 = crypto.PubkeyToAddress(key0.PublicKey)
	auth = bind.NewKeyedTransactor(key0)
	backend = backends.NewSimulatedBackend(
		core.GenesisAccount{
			Address: account0,
			Balance: STARTING_BALANCE,
		},
	)

	flag.Parse()
	os.Exit(m.Run())
}

func Signer(key *ecdsa.PrivateKey) bind.SignerFn {
	return func(address common.Address, tx *types.Transaction) (*types.Transaction, error) {
		signature, err := crypto.Sign(tx.SigHash().Bytes(), key0)
		if err != nil {
			return nil, err
		}
		return tx.WithSignature(signature)
	}
}

func deploy() *TreasureHuntSession {
	_, _, token, err := DeployTreasureHunt(
		bind.NewKeyedTransactor(key0),
		backend,
	)

	if err != nil {
		log.Fatalf("Failed to deploy new token contract: %v", err)
	}

	backend.Commit()

	return &TreasureHuntSession{
		Contract:     token,
		TransactOpts: *bind.NewKeyedTransactor(key0),
	}

}

func TestInitializer(t *testing.T) {
	deploy()
}

func TestTreasureFound(t *testing.T) {
	treasureHunt := deploy()
	var COST_OF_TRANSACTION = big.NewInt(163482)
	var expectedAmount = big.NewInt(0)
	expectedAmount.Sub(STARTING_BALANCE, COST_OF_TRANSACTION)
	expectedAmount.Add(expectedAmount, big.NewInt(100))

	treasureHunt.IsTreasureHere(big.NewInt(100), big.NewInt(100))
	weiBalance, _ := backend.BalanceAt(nil, account0, nil)
	assert.Equal(t, expectedAmount, weiBalance)
}
