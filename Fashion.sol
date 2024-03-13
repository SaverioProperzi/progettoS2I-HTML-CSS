// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

//@title Clothing fundraiser
// @author Saverio Properzi

contract ClothingFundraiser {
address public creator;
address payable public fundRecipient;

uint public minimumToRaise;

enum State {
Fundraising,
ExpiredRefund,
Successful
}

struct Contribution {
uint amount;
address payable contributor;
}

State public state = State.Fundraising;
uint public totalRaised;
uint public raiseBy;
uint public completeAt;
Contribution[] public contributions;

event LogFundingReceived(address addr, uint amount, uint currentTotal);
event LogWinnerPaid(address winnerAddress);

modifier inState(State _state) {
require(state == _state);
_;
}

modifier isCreator() {
require(msg.sender == creator);
_;
}

modifier atEndOfClothingFundraiser() {
require(state == State.Successful);
_;
}

constructor(
address payable _fundRecipient,
uint _minimumToRaise
) {
creator = msg.sender;
fundRecipient = _fundRecipient;
minimumToRaise = _minimumToRaise;
raiseBy = block.timestamp;
}

function etherContribute() public payable inState(State.Fundraising) returns(uint256 id) {
contributions.push(
Contribution({
amount: msg.value,
contributor: payable(msg.sender)
})
);

totalRaised += msg.value;
emit LogFundingReceived(msg.sender, msg.value, totalRaised);

checkIfFundingCompleteOrExpired();
return contributions.length - 1;
}

function checkIfFundingCompleteOrExpired() public {
if (totalRaised >= minimumToRaise) {
state = State.Successful;
payOut();
}
}

function payOut() private {
// function body
}

function removeContract() public isCreator() atEndOfClothingFundraiser() {
selfdestruct(payable (msg.sender));
}

function withdrawalEther() public isCreator() atEndOfClothingFundraiser() {
// function body
}
}

