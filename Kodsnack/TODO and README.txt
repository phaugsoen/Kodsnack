


Ideer och TODO
**************
* Måste tänka om och rätt enl Apple när det gäller background och pausmusik
* Kanske passar bättre med lite modernare och mer iOS typisk t utseende
* Lämplig hissmusik? En lista kanske behövs som fall back
* Går det att trigga via Twitter, we are now live?
* Skriv en README för GitHUB

* Med timer och ingen musik görs resign active när jag går till background och timer utlöses inte.
Kanske löses med att spela någon annan musik så länge?

* Bilden studsar när Live startar
* Fixa liggande
* Gör så att radio STH spelar OM det inte funkar med någonting annat.

* Det SKALL fungera att köra i bakgrunden. Bör dock prova lite saker så som inkommande samtal, notifieringar, byte av nät etc.
* Kan den ligga i bakgrunden trots att det INTE finns någon stream. Apples regler säger att den skall spela ljud för att
det skall vara ok.



* OM JSON query och parse funkar, hämta mer info, rate, channels etc.
* Gör en snygg parse av JSON till Swift

* Visa en equlizer
* Slänga iväg bilden som i twitter
* Enkelt kunna byta till annan Pod
* Visa tid till nästa live
* Push notif för nästa event


Done
####
* Lägg upp på Github
* Inför att den ligger och väntar på att kunna ansluta (poll?)

* Gör en separat startListen som faller tillbaka på P4 vid klick på bilden, t.ex

* Gör em build fär App Store
* Kan man ha den i bakgrunden och att den ligger där och sen vaknar till
när väl LIVE börjar, och då spelar? background, på nåt sätt. Undersök detta.
* Inför manuell möjl till reconnect
* Om INTE online/live, anslut och spela pausmusik, som förhoppningsvis finns på nätet....


###### Data from ICE


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