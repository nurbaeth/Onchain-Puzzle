// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OnchainPuzzle {
    struct Puzzle {
        uint8[9] board; // 3x3 board flattened
        address player;
        bool isSolved;
        uint moves;
    }

    mapping(address => Puzzle) public puzzles;

    function startGame() external {
        require(puzzles[msg.sender].player == address(0), "Game already started");

        uint8[9] memory board = [1,2,3,4,5,6,7,8,0]; // Already solved for simplicity (can be shuffled off-chain)
        puzzles[msg.sender] = Puzzle(board, msg.sender, false, 0);
    }

    function getBoard(address player) external view returns (uint8[9] memory) {
        return puzzles[player].board;
    }

    function moveTile(uint8 tileIndex) external {
        Puzzle storage game = puzzles[msg.sender];
        require(!game.isSolved, "Already solved");

        uint8 emptyIndex = findEmpty(game.board);
        require(isAdjacent(tileIndex, emptyIndex), "Invalid move");

        // Swap the tile with empty
        (game.board[tileIndex], game.board[emptyIndex]) = (game.board[emptyIndex], game.board[tileIndex]);
        game.moves++;

        if (isWinning(game.board)) {
            game.isSolved = true;
        }
    }

    function findEmpty(uint8[9] memory board) internal pure returns (uint8) {
        for (uint8 i = 0; i < 9; i++) {
            if (board[i] == 0) return i;
        }
        revert("No empty tile");
    }

    function isAdjacent(uint8 i, uint8 j) internal pure returns (bool) {
        if (i == j) return false;
        uint8 rowI = i / 3;
        uint8 colI = i % 3;
        uint8 rowJ = j / 3;
        uint8 colJ = j % 3;
        return (rowI == rowJ && (colI + 1 == colJ || colI == colJ + 1)) ||
               (colI == colJ && (rowI + 1 == rowJ || rowI == rowJ + 1));
    }

    function isWinning(uint8[9] memory board) internal pure returns (bool) {
        for (uint8 i = 0; i < 8; i++) {
            if (board[i] != i + 1) return false;
        }
        return board[8] == 0;
    }
}
