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
	
    function TreasureHunt() {
        // Add players
        ResetPlayer(0x06b50b1fee1a46d8803d017e6bf363a3f904d8fe);
        ResetPlayer(0xca35b7d915458ef540ade6068dfe2f44e8fa733c);
        
        // First treasure in the array is a dummy treasure to work around issues with checking if a player exists (see CheckAnswerForPlayer()).
        treasures.push(Treasure({latitude: 0, longitude: 0, hint: "Invalid player ID.", video: ""}));
        
        //treasures.push(Treasure({latitude: 1, longitude: 2, hint: "The place to be."}));
        //treasures.push(Treasure({latitude: 53, longitude: -6, hint: "Demo location", video: "video1"}));
        treasures.push(Treasure({latitude: 53, longitude: -6, hint: "Diamond", video: "video1"}));
        treasures.push(Treasure({latitude: 53, longitude: -6, hint: "Floor Plan", video: "video2"}));
        treasures.push(Treasure({latitude: 53, longitude: -6, hint: "Mic", video: "video3"}));
    }

    function SubmitAnswer(int latitude, int longitude)
        returns (string nextHint, string nextVideo)
    {
		var player = msg.sender;
		
		if(!PlayerFinishedHunt(player) && IsCorrectAnswer(latitude, longitude, player)) {
			AdvancePlayerToNextTreasure(player);
			
			if(PlayerFinishedHunt(player))
			{
				// This is the last treasure, player gets the reward.
				msg.sender.send(100);
			}
        }
        
		nextHint = GetNextHintForPlayer(player);
		nextVideo = GetNextVideoForPlayer(player);
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
            nextHint = GetNextHintForPlayer(player);
            nextVideo = GetNextVideoForPlayer(player);

			if(IsCorrectAnswer(latitude, longitude, player)) {
				correct = true;
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
    
    function PlayerFinishedHunt(address player) constant private
        returns (bool success)
    {
        success = playerState[player] >= treasures.length; 
    }

    function AdvancePlayerToNextTreasure(address player) private {
        playerState[player]++;
    }

    function IsCorrectAnswer(int latitude, int longitude, address player) private
        returns (bool correct)
    {
        var treasureId = playerState[player];
        correct = (latitude == treasures[treasureId].latitude && longitude == treasures[treasureId].longitude);
    }
}
