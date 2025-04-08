# 🧩 Onchain Puzzle

**Onchain Puzzle** is a fully onchain tile-based puzzle game built in Solidity.  
Players must slide the numbered tiles into the correct order, using an empty space to rearrange them. All game logic and state are stored entirely on the blockchain — no backend, no database, just pure smart contract fun.

![preview](https://github.com/yourusername/onchain-puzzle/assets/preview.gif) <!-- (добавишь свой гиф/скриншот сюда) -->

---

## 🎮 Gameplay

- A 3x3 puzzle with 8 numbered tiles and 1 empty space (classic sliding puzzle).
- The goal is to arrange the tiles in the order `1 → 8`, with the empty space at the end.
- All moves are validated and executed onchain.
- Each player has their own puzzle state stored in the contract.

---

## 📦 Features

- 🧠 Pure logic in Solidity
- 🧩 Individual puzzle for each player
- 🏁 Win detection and move counter
- 🔒 No external dependencies or off-chain storage
- ✨ Gas-optimized structure

---

## 🛠 How It Works

- Call `startGame()` to begin. (Currently starts with a solved board — shuffle off-chain for now.)
- Use `moveTile(tileIndex)` to move a tile (only adjacent to the empty space).
- Use `getBoard(address)` to view any player’s puzzle.
- When the puzzle is solved, `isSolved` becomes `true`.

---

## 🔧 Development

### Prerequisites

- [Foundry](https://book.getfoundry.sh/) or [Hardhat](https://hardhat.org/)
- Node.js (for frontend integration, optional)

### Compile & Test

```bash
forge build
forge test
