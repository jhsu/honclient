# HoNClient

wrapper for Heroes of Newerth XML API [http://xml.heroesofnewerth.com](http://xml.heroesofnewerth.com "XML Requester API")

## Player stats

Get player statistics ([Sample attributes](http://xml.heroesofnewerth.com/xml_requester.php?f=player_stats&opt=aid&aid[]=28&aid[]=25))

    player = HoN::PlayerStats.new('jhsu')
    player.rnk_herokills #=> 390
    player.psr           #=> 1604
    player.mmr           #=> 1694
    player.tsr           #=> 5.07

## Credits

Originally by [Chris Gillis](http://github.com/chrisgillis 'chrisgillis') and
reworked by [Joseph Hsu](http://github.com/jhsu 'jhsu')
