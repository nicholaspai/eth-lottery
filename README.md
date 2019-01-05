# Lottery by Carbon

A typical lottery is a single round game, where N participants buy tickets with equal probabilities of winning a prize P. After the tickets have been distributed and before the winning ticket is announced, each ticket has a 1/N chance of winning P, giving each ticket an expected value of P/N. After the winning ticket is announced, all tickets except for the winning ticket have an EV = 0 while the winning ticket has an EV = P. We label this lottery a "single round game" because there is a *single event* that changes the outstanding tickets' expected values, namely the announcement of the winning ticket makes the EV of (N-1) tickets go to 0 while the 1 winning ticket goes to P.

The twist with this lottery is that there will be multiple rounds for ticket EV's to change. 

# Set Up

For each Game G(N), there will be N tickets distributed with each assigned a bitstring (e.g. 1001). For example, let G(16) have 16 tickets. There will be a ticket mapped to each bitstring less than 16: 0000, 0001, 0010, ... 1101, 1110, 1111. There will also be a prize P that will be sent to the winning ticket.

# How the winning ticket is determiend

The winning ticket will have the same bitstring as the lottery number L. *For example, L could be 1010*.

# Game Rounds

Each ticket will be a mapping between an Ethereum address and a bitstring. Each Round R where (R: r => [0, log_2(N)-1]) the rth bit of the winning lottery number L will be revealed. In the example game G(16), the rounds will reveal:

    L = '1010'
    r=0: first bit = 1
    r=1: first bit = 0
    r=2: first bit = 1
    r=3: first bit = 0

# Trading rounds

In between each round r, there will be opporunities to trade tickets, which will be ERC721 non-fungible tokens. The incentive for a participant to trade tickets is because the ticket expected values will change after each round. 
    Before round 0, each ticket will have EV = P/16

    After round 0 where '1' is revealed to be the first bit of L, exactly 8/16 tickets will have been eliminated. This is because half of the tickets will be assigned a bitstring that begins with '1XXX'. In the previous example, these eight tickets will have EV = P/(16/2) = P/8, while the eliminated tickets will have EV = 0.

    After round 1 where '0' is revealed to be the second bit of L, 12/16 quarters of the outstanding tickets will have been eliminated. Only one quarter of outstanding tickets will have bit strings that begin with '10XX'. These four tickets will have EV = P/(16/2/2) = P/4.

    After round 2 where '1' is revealed to be the third bit of L, 14/16 of the outstanding tickets will have been eliminated. Only two outstanding tickets will have bit strings that begin with '101X'. These two tickets will have EV = P/(16/2/2/2) = P/2.

    After round 3 where '0' is revealed to be the fourth bit of L, there will only be one winning ticket. No trading will or should occur after this point since that ticket has won the prize P

# Startup

Start local ethereum node with `npm run ganache` 

Contracts are built with [ZeppelinOS](https://docs.zeppelinos.org/docs/deploying.html) which is a wrapper around Truffle for deploying upgradeable smart contracts

[Good overview of Truffle v5 & ZeppelinOS v2](https://paulrberg.com/post/2018/12/30/upgradeable-smart-contracts/)

1) Add CONTRACT.sol `/contracts/` to zos project with `zos add [CONTRACT]`. This will compile the contract with and add it to `zos.json`. These contracts will be deployed to the network via `zpm push`

2) `npm run zos-session`: Start a zos session to work with a desired network with `zos session --network local --from 0x1df62f291b2e969fb0849d99d9ce41e2f137006e --expires 3600` where the sender "from" is the ["admin" of the Upgradeable Proxy contract](https://docs.zeppelinos.org/docs/pattern.html#transparent-proxies-and-function-clashes). The session will expire in 60 minutes (3600 seconds).

3) `npm run zos-push`: Deploy contracts with `zos push`. The push command also creates a `zos.dev-<network_id>.json` file with all the information about your project in this specific network, including the addresses of the deployed contract implementations in contracts["MyContract"].address. You can read more about this file format in the [configuration files](https://docs.zeppelinos.org/docs/configuration.html#zos-network-json) section.

4) Create an upgradeable version of your contract with `zos create MyContract --init initialize --args 42,hitchhiker` where 42 and hitchiker are comma-delimited args to the `MyContract.initialize()` function.

5) To upgrade logic contracts, run `zos push` and `zos update`

6) For more information on writing zos-compatible upgradeable contracts read the [docs](https://docs.zeppelinos.org/docs/writing_contracts.html)

7) Guide for deploying to [mainnet](https://docs.zeppelinos.org/docs/mainnet)

# Contracts

## Lottery Game

`initialize`: takes a number N indicating the number of tickets to distribute
`generateWinner`: generates a winning bitstring

## Lottery Exchange AMM (Automated Market Maker)
Uniswap-style AMM that always provides liquidity for outstanding lottery tickets at fair value prices. This should be easily calculatable because of the game's rules.

