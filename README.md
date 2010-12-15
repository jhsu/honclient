# HoNClient

wrapper for Heroes of Newerth XML API [http://xml.heroesofnewerth.com](http://xml.heroesofnewerth.com "XML Requester API")

## Player stats

Sample attributes [http://xml.heroesofnewerth.com/xml_requester.php?f=player_stats&opt=aid&aid[]=28&aid[]=25]

    player = HoN::PlayerStats.new('jhsu')
	player.psr
	=> "1694"

## Credits

Originally by [Chris Gillis](http://github.com/chrisgillis 'chrisgillis') and
reworked by [Joseph Hsu](http://github.com/jhsu 'jhsu')
