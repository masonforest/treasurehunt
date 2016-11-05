pragma solidity ^0.4.0;
contract TreasureHunt {
	struct Treasure {
		int latitude;
		int longitude;
		string hint;
	}
	
	// Array of players.
	address[] players;
	
	// Array of treasures.
	Treasure[] treasures;
	
	// A state variable that stores the index of the treasure for each player. It's the treasure the player is hunting at the moment.
	mapping(address => uint) playerState;
	
    function TreasureHunt() {
        players.push(0x06b50b1fee1a46d8803d017e6bf363a3f904d8fe);
        players.push(0xca35b7d915458ef540ade6068dfe2f44e8fa733c);
        
        // First treasure in the array is a dummy treasure to work around issues with checking if a player exists (see CheckAnswer()).
        treasures.push(Treasure({latitude: 0, longitude: 0, hint: "Invalid player ID."}));
        
        // Test location has latitiude: 53.37650716687302, longitude: -6.271040895288929. Trimmed to 3 decimal places and multiplied by 1000 to get an integer value.
        treasures.push(Treasure({latitude: 53376, longitude: -6271, hint: "The place to be."}));
        //treasures.push(Treasure({latitude: 1, longitude: 2, hint: "The place to be."}));
        
        // Initialize first player's state.
        playerState[players[0]] = 1;
        playerState[players[1]] = 1;
    }

    function SubmitAnswer(int latitude, int longitude) {
		var player = msg.sender;
		
		if(!PlayerFinishedHunt(player) && IsCorrectAnswer(latitude, longitude, player)) {
			AdvancePlayerToNextTreasure(player);
			
			if(PlayerFinishedHunt(player))
			{
				// This is the last treasure, player gets the reward.
				msg.sender.send(1 ether);
			}
        }
    }
    
    function CheckAnswer(int latitude, int longitude, address player) constant
        returns (bool correct, string nextHint)
    {
        correct = false;
		var treasureId = playerState[player];
		
        if(PlayerFinishedHunt(player))
        {
            nextHint = "SUCCESS";
        }
		else if(IsCorrectAnswer(latitude, longitude, player)) {
		    correct = true;
            nextHint = treasures[treasureId].hint;
        }
    }
    
    function GetNextHint() constant
        returns (string nextHint)
    {
        var player = msg.sender;
		var treasureId = playerState[player];
		
        if(PlayerFinishedHunt(player))
        {
            nextHint = "SUCCESS";
        }
		else
		{
            nextHint = treasures[treasureId].hint;
        }
    }
    
    function GetNextHintForPlayer(address player) constant
        returns (address returnPlayer, string nextHint)
    {
        returnPlayer = player;
		var treasureId = playerState[player];
		
        if(PlayerFinishedHunt(player))
        {
            nextHint = "SUCCESS";
        }
		else
		{
            nextHint = treasures[treasureId].hint;
        }
    }
    
    function Echo() constant
        returns (address echo)
    {
        echo = msg.sender;
        return echo;
    }
    
    function EchoAddress(address add) constant
        returns (address echo)
    {
        echo = add;
        return echo;
    }
    
    function EchoString(string str) constant
        returns (string echo)
    {
        echo = str;
        return echo;
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
