// This file is an automatically generated Go binding. Do not modify as any
// change will likely be lost upon the next re-generation!

package main

import (
	"math/big"
	"strings"

	"github.com/ethereum/go-ethereum/accounts/abi"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
)

// TreasureHuntABI is the input ABI used to generate the binding from.
const TreasureHuntABI = `[{"constant":false,"inputs":[{"name":"latitude","type":"int256"},{"name":"longitude","type":"int256"}],"name":"IsTreasureHere","outputs":[],"type":"function"},{"inputs":[],"type":"constructor"}]`

// TreasureHuntBin is the compiled bytecode used for deploying new contracts.
const TreasureHuntBin = `0x606060405260688060106000396000f3606060405260e060020a6000350463719e67cd8114601a575b005b601860043560243581606414801560315750806064145b1560645760405173ffffffffffffffffffffffffffffffffffffffff33169060009060649082818181858883f150505050505b505056`

// DeployTreasureHunt deploys a new Ethereum contract, binding an instance of TreasureHunt to it.
func DeployTreasureHunt(auth *bind.TransactOpts, backend bind.ContractBackend) (common.Address, *types.Transaction, *TreasureHunt, error) {
	parsed, err := abi.JSON(strings.NewReader(TreasureHuntABI))
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	address, tx, contract, err := bind.DeployContract(auth, parsed, common.FromHex(TreasureHuntBin), backend)
	if err != nil {
		return common.Address{}, nil, nil, err
	}
	return address, tx, &TreasureHunt{TreasureHuntCaller: TreasureHuntCaller{contract: contract}, TreasureHuntTransactor: TreasureHuntTransactor{contract: contract}}, nil
}

// TreasureHunt is an auto generated Go binding around an Ethereum contract.
type TreasureHunt struct {
	TreasureHuntCaller     // Read-only binding to the contract
	TreasureHuntTransactor // Write-only binding to the contract
}

// TreasureHuntCaller is an auto generated read-only Go binding around an Ethereum contract.
type TreasureHuntCaller struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// TreasureHuntTransactor is an auto generated write-only Go binding around an Ethereum contract.
type TreasureHuntTransactor struct {
	contract *bind.BoundContract // Generic contract wrapper for the low level calls
}

// TreasureHuntSession is an auto generated Go binding around an Ethereum contract,
// with pre-set call and transact options.
type TreasureHuntSession struct {
	Contract     *TreasureHunt     // Generic contract binding to set the session for
	CallOpts     bind.CallOpts     // Call options to use throughout this session
	TransactOpts bind.TransactOpts // Transaction auth options to use throughout this session
}

// TreasureHuntCallerSession is an auto generated read-only Go binding around an Ethereum contract,
// with pre-set call options.
type TreasureHuntCallerSession struct {
	Contract *TreasureHuntCaller // Generic contract caller binding to set the session for
	CallOpts bind.CallOpts       // Call options to use throughout this session
}

// TreasureHuntTransactorSession is an auto generated write-only Go binding around an Ethereum contract,
// with pre-set transact options.
type TreasureHuntTransactorSession struct {
	Contract     *TreasureHuntTransactor // Generic contract transactor binding to set the session for
	TransactOpts bind.TransactOpts       // Transaction auth options to use throughout this session
}

// TreasureHuntRaw is an auto generated low-level Go binding around an Ethereum contract.
type TreasureHuntRaw struct {
	Contract *TreasureHunt // Generic contract binding to access the raw methods on
}

// TreasureHuntCallerRaw is an auto generated low-level read-only Go binding around an Ethereum contract.
type TreasureHuntCallerRaw struct {
	Contract *TreasureHuntCaller // Generic read-only contract binding to access the raw methods on
}

// TreasureHuntTransactorRaw is an auto generated low-level write-only Go binding around an Ethereum contract.
type TreasureHuntTransactorRaw struct {
	Contract *TreasureHuntTransactor // Generic write-only contract binding to access the raw methods on
}

// NewTreasureHunt creates a new instance of TreasureHunt, bound to a specific deployed contract.
func NewTreasureHunt(address common.Address, backend bind.ContractBackend) (*TreasureHunt, error) {
	contract, err := bindTreasureHunt(address, backend, backend)
	if err != nil {
		return nil, err
	}
	return &TreasureHunt{TreasureHuntCaller: TreasureHuntCaller{contract: contract}, TreasureHuntTransactor: TreasureHuntTransactor{contract: contract}}, nil
}

// NewTreasureHuntCaller creates a new read-only instance of TreasureHunt, bound to a specific deployed contract.
func NewTreasureHuntCaller(address common.Address, caller bind.ContractCaller) (*TreasureHuntCaller, error) {
	contract, err := bindTreasureHunt(address, caller, nil)
	if err != nil {
		return nil, err
	}
	return &TreasureHuntCaller{contract: contract}, nil
}

// NewTreasureHuntTransactor creates a new write-only instance of TreasureHunt, bound to a specific deployed contract.
func NewTreasureHuntTransactor(address common.Address, transactor bind.ContractTransactor) (*TreasureHuntTransactor, error) {
	contract, err := bindTreasureHunt(address, nil, transactor)
	if err != nil {
		return nil, err
	}
	return &TreasureHuntTransactor{contract: contract}, nil
}

// bindTreasureHunt binds a generic wrapper to an already deployed contract.
func bindTreasureHunt(address common.Address, caller bind.ContractCaller, transactor bind.ContractTransactor) (*bind.BoundContract, error) {
	parsed, err := abi.JSON(strings.NewReader(TreasureHuntABI))
	if err != nil {
		return nil, err
	}
	return bind.NewBoundContract(address, parsed, caller, transactor), nil
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_TreasureHunt *TreasureHuntRaw) Call(opts *bind.CallOpts, result interface{}, method string, params ...interface{}) error {
	return _TreasureHunt.Contract.TreasureHuntCaller.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_TreasureHunt *TreasureHuntRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _TreasureHunt.Contract.TreasureHuntTransactor.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_TreasureHunt *TreasureHuntRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _TreasureHunt.Contract.TreasureHuntTransactor.contract.Transact(opts, method, params...)
}

// Call invokes the (constant) contract method with params as input values and
// sets the output to result. The result type might be a single field for simple
// returns, a slice of interfaces for anonymous returns and a struct for named
// returns.
func (_TreasureHunt *TreasureHuntCallerRaw) Call(opts *bind.CallOpts, result interface{}, method string, params ...interface{}) error {
	return _TreasureHunt.Contract.contract.Call(opts, result, method, params...)
}

// Transfer initiates a plain transaction to move funds to the contract, calling
// its default method if one is available.
func (_TreasureHunt *TreasureHuntTransactorRaw) Transfer(opts *bind.TransactOpts) (*types.Transaction, error) {
	return _TreasureHunt.Contract.contract.Transfer(opts)
}

// Transact invokes the (paid) contract method with params as input values.
func (_TreasureHunt *TreasureHuntTransactorRaw) Transact(opts *bind.TransactOpts, method string, params ...interface{}) (*types.Transaction, error) {
	return _TreasureHunt.Contract.contract.Transact(opts, method, params...)
}

// IsTreasureHere is a paid mutator transaction binding the contract method 0x719e67cd.
//
// Solidity: function IsTreasureHere(latitude int256, longitude int256) returns()
func (_TreasureHunt *TreasureHuntTransactor) IsTreasureHere(opts *bind.TransactOpts, latitude *big.Int, longitude *big.Int) (*types.Transaction, error) {
	return _TreasureHunt.contract.Transact(opts, "IsTreasureHere", latitude, longitude)
}

// IsTreasureHere is a paid mutator transaction binding the contract method 0x719e67cd.
//
// Solidity: function IsTreasureHere(latitude int256, longitude int256) returns()
func (_TreasureHunt *TreasureHuntSession) IsTreasureHere(latitude *big.Int, longitude *big.Int) (*types.Transaction, error) {
	return _TreasureHunt.Contract.IsTreasureHere(&_TreasureHunt.TransactOpts, latitude, longitude)
}

// IsTreasureHere is a paid mutator transaction binding the contract method 0x719e67cd.
//
// Solidity: function IsTreasureHere(latitude int256, longitude int256) returns()
func (_TreasureHunt *TreasureHuntTransactorSession) IsTreasureHere(latitude *big.Int, longitude *big.Int) (*types.Transaction, error) {
	return _TreasureHunt.Contract.IsTreasureHere(&_TreasureHunt.TransactOpts, latitude, longitude)
}
