pragma solidity ^0.4.0;
contract TreasureHunt {
    struct Treasure {
        int latitude;
        int longitude;
        string hint;
        string video;
    }
    
    // Array of treasures.
    Treasure[] treasures;
    
    // Mapping of a player address to the index in the treasures array.
    // A state variable that maps each player to the treasure they're hunting at the moment.
    mapping(address => uint) playerState;
    
    // Reward for winning the game.
    uint reward;
    
    // Using withdrawal pattern.
    mapping (address => uint) pendingWithdrawals;
    
    function TreasureHunt() {
        // Set the reward
        reward = 100;
        
        // Add players
        ResetPlayer(0x06b50b1fee1a46d8803d017e6bf363a3f904d8fe);
        ResetPlayer(0xca35b7d915458ef540ade6068dfe2f44e8fa733c);
        
        // First treasure in the array is a dummy treasure to work around issues with checking if a player exists (see CheckAnswerForPlayer()).
        treasures.push(Treasure({latitude: 0, longitude: 0, hint: "Invalid player ID.", video: ""}));
        
        // Add tresures
        // Demo trasure
        treasures.push(Treasure({latitude: 53, longitude: -6, hint: "Find the Treasure Hunt poster.", video: "video1"}));
        // Test treasures
        //treasures.push(Treasure({latitude: 53, longitude: -6, hint: "Diamond", video: "video1"}));
        //treasures.push(Treasure({latitude: 53, longitude: -6, hint: "Floor Plan", video: "video2"}));
        //treasures.push(Treasure({latitude: 53, longitude: -6, hint: "Mic", video: "video3"}));
    }
    
    function () payable {}

    function SetReward(uint r)
    {
        reward = r;
    }
    
    function SubmitAnswer(int latitude, int longitude)
        returns (string nextHint, string nextVideo)
    {
        var player = msg.sender;
        
        if(!PlayerFinishedHunt(player) && IsCorrectAnswer(latitude, longitude, player)) {
            MovePlayerToNextTreasure(player);
            
            if(PlayerFinishedHunt(player))
            {
                // This was the last treasure, player gets the reward.
                RewardPlayer(player);
                
                // Transfer the funds to player's address.
                WithdrawForPlayer(player);
            }
        }
        
        nextHint = GetNextHintForPlayer(player);
        nextVideo = GetNextVideoForPlayer(player);
    }
    
    function RewardPlayer(address player) private
    {
        pendingWithdrawals[player] = reward;
    }
    
    function WithdrawForPlayer(address player)
        returns (bool)
    {
        if(PlayerFinishedHunt(player))
        {
            uint amount = pendingWithdrawals[player];
            pendingWithdrawals[player] = 0;
            
            if(!player.send(amount))
            {
                pendingWithdrawals[player] = amount;
                return false;
            }
            
            return true;
        }
		
		return false;
    }
    
    function CheckAnswerForPlayer(int latitude, int longitude, address player) constant
        returns (bool correct, string nextHint, string nextVideo)
    {
        correct = false;

        if(PlayerFinishedHunt(player))
        {
            nextHint = "SUCCESS";
        }
        else 
        {
            if(IsCorrectAnswer(latitude, longitude, player)) {
                correct = true;
                
                // Return the next hint for the user as if they actually advanced to the next treasure.
                MovePlayerToNextTreasure(player);
                nextHint = GetNextHintForPlayer(player);
                nextVideo = GetNextVideoForPlayer(player);
                MovePlayerToPreviousTreasure(player);
            }
            else
            {
                nextHint = GetNextHintForPlayer(player);
                nextVideo = GetNextVideoForPlayer(player);
            }
        }
    }
    
    function GetNextHintAndVideoForPlayer(address player) constant
        returns (string nextHint, string nextVideo)
    {
        nextHint = GetNextHintForPlayer(player);
        nextVideo = GetNextVideoForPlayer(player);
    }
    
    function GetNextHintForPlayer(address player) constant
        returns (string nextHint)
    {
        if(PlayerFinishedHunt(player))
        {
            nextHint = "SUCCESS";
        }
        else
        {
            var treasureId = playerState[player];
            nextHint = treasures[treasureId].hint;
        }
    }
    
    function GetNextVideoForPlayer(address player) constant
        returns (string nextVideo)
    {
        if(PlayerFinishedHunt(player))
        {
            nextVideo = "";
        }
        else
        {
            var treasureId = playerState[player];
            nextVideo = treasures[treasureId].video;
        }
    }
    
    function ResetPlayer(address player) constant
        returns (string nextHint, string nextVideo)
    {
        playerState[player] = 1;

        nextHint = GetNextHintForPlayer(player);
        nextVideo = GetNextVideoForPlayer(player);
    }
    
	// Helper functions
	
    function PlayerFinishedHunt(address player) constant private
        returns (bool success)
    {
        success = playerState[player] >= treasures.length; 
    }

    function MovePlayerToNextTreasure(address player) private {
        playerState[player]++;
    }

    function MovePlayerToPreviousTreasure(address player) private {
        playerState[player]--;
    }

    function IsCorrectAnswer(int latitude, int longitude, address player) private
        returns (bool correct)
    {
        var treasureId = playerState[player];
        correct = (latitude == treasures[treasureId].latitude && longitude == treasures[treasureId].longitude);
    }
}
