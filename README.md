#Kodsnack
En iOS app för att lyssna på livesänding av podcasten Kodsnack.


##Krav
- Kodsnack kräver iOS 8.0 eller senare, bl.a då Testflight används för beta-testning plus custom UI Transitions.
- Kodsnack är skriven helt i Swift.
- Den fungerar utmärkt att ha i bakgrunden då sändning pågår. Men för att kunna köra den i bakgrunden i "väntan" på att sänding skall börja, och samtidigt tillfredsställa Apple's krav, spelas pausmusik under väntetiden. Det är dock möjligt att pausa denna pausmusik :)


##Funktioner
###Chat
Före, under och efter sändning är det möjligt att samtidigt medverka i chat-rummet.

Oberservera att det INTE är möjligt att återgå till huvudskärmen samtidigt som man är inne i chat-rummet, då loggas man ut. Finns dock ingen anledning till att göra detta.

###Bakgrunden
Appen känner automatiskt av OM det är Kodsnack eller systerpodcasten Appsnack som sänds och väljer kanal i chatten ut efter detta.

Om appen är i bakgrunden i väntan på livesänding så erhålls en notifiering när sändingen börjar och den börjar även sända automatiskt.

###Övrigt
Det är möjligt att använda iOS Control Center för att hatera uppspelningen, inklusive AirPlay.
