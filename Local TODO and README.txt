Förbättringsförslag efter Test-1
################################

* Bilden studsar när Live startar
* Tydligare notif om att nu har det börjat! Hur? Lämpligt!?



* web ej ok på sexa device


* Finputsa transitions

* Pausmusik för att vara Apple-OK, men möjl att pausa den. Sedan när live startar så går den igång!?!?!

* Visa antalet lyssnare online som Android. Vid start enkelt, men om den skall hålla uppdaterat lite mer komplicerat.


* Ta fram en testplan inför nästa livetillfälle

* En muteknapp??

* Gör play och paus till EN knapp som växlar ( Se först till att de funkar som avsedd i dagens läge)

* Kanske ta bort VC med podval. Finns väl inget behov då kod o app samma. Kanske ett annat
sätt att manuellt ange en JSON sträng/pod, för test?



Bugs efter T-1
##############


* Vid inkommande samtal börjar den spela pausmusik samtidigt som ringsignaler.
    - Om samtal nekas och återgång till App så måste man trycka restart för att spela, sen OK.
    - Om samtal tas emot och sedan återgång spelas paus och går inte att trycka några knappar. Kan vara case should not happen.
      Kanske should not happen borde börja spela om?


* OK! När live är slut så händer ingenting förutom att det blir tyst. Visar online. Om jag trycker reload
  el på bilden så går den in i det korrekta vänteläget med pausmusik



Testfall
########
* Hur länge kan man göra paus? Vad står det i spec? Vad händer? Äter den minne för lokal buffer?
* Kör länge i Xcode/device för att se om den stannar och fel dyker upp. Hände en gång under T-1
* Testa kontrollcenter mera





Ideer och TODO
**************


* Exp mera med player.volume. Kanske finns mer saker att sätta. T.ex tona in ljudets

* Måste tänka om och rätt enl Apple när det gäller background och pausmusik
* Kanske passar bättre med lite modernare och mer iOS typisk t utseende
* Lämplig hissmusik? En lista kanske behövs som fall back
* Går det att trigga via Twitter, we are now live?
* Skriv en README för GitHUB

* Med timer och ingen musik görs resign active när jag går till background och timer utlöses inte.
Kanske löses med att spela någon annan musik så länge?



* Det SKALL fungera att köra i bakgrunden. Bör dock prova lite saker så som inkommande samtal, notifieringar, byte av nät etc.



* Gör en snygg parse av JSON till Swift
* Visa en equlizer som Overcast har
* Slänga iväg bilden som i twitter



Done
####
* Ändra on och offline röd grön till något bättre. Grön färg syns dålig, passar dåligt och är fult.

* Alert ser den ok ut? Blå rubrik? Bra text?
Rubrik kanske vara utläggning?
* Prova MPVolumeView... för att sätta volym rel riktiga vol

* Ändra chaten till att anpassa kanal efter app el kod

* Visa tid till nästa live
* Push notif för nästa event
* Kan den ligga i bakgrunden trots att det INTE finns någon stream. Apples regler säger att den skall spela ljud för att
det skall vara ok.

* Enkelt kunna byta till annan Pod
* OM JSON query och parse funkar, hämta mer info, rate, channels etc.
* Fixa liggande
* Gör så att radio STH spelar OM det inte funkar med någonting annat.

* Visa snurrande logo som växlar i vänteläget. När väl kontakt välj rätt.

* Skall känna av om det är App eller Kod som streamas och ändra logo/titel efter detta. Finns i "server_name"

* Snurran skall stanna när live startar

* Hörs även om telefon är mutad med knappen
* Man kan inte gåtillbaka till Main VC från chat, då går man ur chatten.
- Samma sida?
- Varna? Tror detta är det bästa!
- Varför gå tillbaka?
- Inställning som sparar användare/lösen i chat?

* Snurra logga title lite då och då när det är pausmusik. Timer?
* kiwi till chatikon, folk el bubbla
* Lägga konstanter etc separat
* Error från webload
* Byta icon för avsluta Chat. Ett kryss?

* Klick på logo live så skrivs "already playing PAUSE MUSIC". Hamnare antagligen i fallet could not happen...

* Finns ingen title att läsa i JSON, ta bort detta (fixat!?)

* Control center visas men fungerar ej.
* På datorn hörs det bara i höger högtalare när simulator körs.
* repeat av bossanova

* Kanske ha en lokal fil med bakgrundsmusik, nåt passande?


* KVO remove observer på player någonstans, vart? Kanske lösningen är att deklarera
och init av player i klassen, inte i metoden?

* Skriv till AppSnack om när de är live, jag behöver testa och tekniken verkar samma...

* Varför sätts inte ngn lyssnare upp på notifStartListen?

* Lägg upp på Github
* Inför att den ligger och väntar på att kunna ansluta (poll?)

* Gör en separat startListen som faller tillbaka på P4 vid klick på bilden, t.ex

* Gör em build fär App Store
* Kan man ha den i bakgrunden och att den ligger där och sen vaknar till
när väl LIVE börjar, och då spelar? background, på nåt sätt. Undersök detta.
* Inför manuell möjl till reconnect
* Om INTE online/live, anslut och spela pausmusik, som förhoppningsvis finns på nätet....


###### Data from ICE


icestats =     {
admin = "icemaster@localhost";
host = "live.kodsnack.se";
location = Earth;
"server_id" = "Icecast 2.4.0";
"server_start" = "Tue, 02 Sep 2014 22:07:35 +0200";
"server_start_iso8601" = "2014-09-02T22:07:35+0200";
source =         {
bitrate = 96;
dummy = "<null>";
genre = Podcast;
"listener_peak" = 4;
listeners = 1;
listenurl = "http://live.kodsnack.se:8000/appsnack";
"server_description" = "Unspecified description";
"server_name" = Appsnack;
"server_type" = "audio/mpeg";
"server_url" = "http://live.kodsnack.se:8000/appsnack";
"stream_start" = "Tue, 25 Nov 2014 18:12:21 +0100";
"stream_start_iso8601" = "2014-11-25T18:12:21+0100";
};
};
})




<?xml version="1.0"?>
<icestats>
<admin>icemaster@example.org</admin>
<client_connections>13</client_connections>
<clients>2</clients>
<connections>14</connections>
<file_connections>1</file_connections>
<host>stream.example.org</host>
<listener_connections>7</listener_connections>
<listeners>1</listeners>
<location>Earth</location>
<server_id>Icecast 2.4.0</server_id>
<server_start>Tue, 01 Apr 2014 23:42:05 +0000</server_start>
<server_start_iso8601>2014-04-01T23:42:05+0000</server_start>
<source_client_connections>1</source_client_connections>
<source_relay_connections>0</source_relay_connections>
<source_total_connections>1</source_total_connections>
<sources>1</sources>
<stats>0</stats>
<stats_connections>0</stats_connections>
<source mount="/test.ogg">
<artist>Test artist</artist>
<audio_bitrate>32000</audio_bitrate>
<audio_channels>2</audio_channels>
<audio_info>samplerate=32000;channels=2;quality=-1;ice-channels=1</audio_info>
<ice-bitrate>32</ice-bitrate>
<listener_peak>2</listener_peak>
<listeners>0</listeners>
<listenurl>http://stream.example.org:8000/test.ogg</listenurl>
<max_listeners>unlimited</max_listeners>
<public>0</public>
<quality>-1.00</quality>
<samplerate>32000</samplerate>
<server_description>A stream for testing ogg/vorbis.</server_description>
<server_name>TestStream</server_name>
<server_type>application/ogg</server_type>
<slow_listeners>1</slow_listeners>
<source_ip>203.0.113.42</source_ip>
<stream_start>Wed, 02 Apr 2014 13:37:42 +0000</stream_start>
<stream_start_iso8601>2014-04-02T13:37:42+0000</stream_start>
<subtype>Vorbis</subtype>
<title>Test title</title>
<total_bytes_read>448632</total_bytes_read>
<total_bytes_sent>207463</total_bytes_sent>
<user_agent>IceS 2.0.1</user_agent>
</source>
</icestats>