contract TreasureHunt {
    function TreasureHunt() {
    }

    function IsTreasureHere(int latitude, int longitude){
        if(latitude == 100 && longitude == 100) {
            msg.sender.send(100);
        }
    }
}
