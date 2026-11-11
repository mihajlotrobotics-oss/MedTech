# Lokalni prototip i sledeca faza

Ova aplikacija je lokalna demonstracija sa izmisljenim klinikama. Nema stvarnih zdravstvenih usluga, naplate, poslatih poruka ili veze sa klinickim informacionim sistemima.

## Prikljucivanje klinickog softvera

Za Heliant, Medis ili drugi sistem potrebni su dokumentovani API, ugovor sa klinikom, testno okruzenje i pristupni podaci dobavljaca. Status „nije povezano“ znaci da podaci nisu sinhronizovani. Nije napravljena nezvanicna integracija niti se podaci iz tih sistema preuzimaju.

Produkcijska integracija mora da definise identifikatore lekara, klinike, usluge i termina, trajanje pregleda, vremensku zonu, promene i otkazivanja, ponovljene zahteve i resavanje istovremenih rezervacija. Potrebna je potvrda rezervacije od sistema koji je vlasnik kalendara.

## SMS i Viber

Lokalni izlazni sanducic prikazuje nacrt podsetnika i planirano vreme. Poruke se ne salju. Za stvarno slanje potrebni su provajder, odobren posiljalac, pristupni podaci i prijem statusa isporuke. Izlazni sanducic nije dokaz da je pacijent dobio poruku. Otkazivanje iz poruke mora koristiti nepredvidiv token i potvrdu; otvaranje linka samo po sebi ne sme da menja rezervaciju.

## Kontakti i nalozi

Lokalna prijava i registracija postoje, sa odvojenim klijentskim i ordinacijskim nalozima i kontrolom pristupa po vlasniku/ordinaciji. Nema provere vlasnistva emaila/telefona niti slanja poruka za reset lozinke. Pre stvarne upotrebe potrebna je bezbednosna provera, definisano upravljanje nalozima i prava zaposlenih.

Sifrovanje kontakata u bazi ne predstavlja potvrdu uskladjenosti sa GDPR/ZZPL. Kljuc se nalazi odvojeno u lokalnom data folderu; osoba koja moze procitati i bazu i kljuc moze desifrovati kontakte. Produkcija zahteva odvojeno upravljanje kljucevima, HTTPS, politiku zadrzavanja i brisanja, kontrolu pristupa, revizione tragove, backup i strucnu pravnu i bezbednosnu proveru pre unosa stvarnih podataka.

## Premium opcije

Upload nalaza, video konsultacije, placanje i porodicni nalozi ostaju naredna faza. Upload mora imati kontrolu tipa/velicine, privatno skladiste, skeniranje, ogranicena prava i brisanje. Video i placanje traze stvarne provajdere. Porodicni nalog trazi dokaz ovlascenja i odvojene dozvole po osobi. Onemoguceno dugme nije implementirana integracija.

## Monetizacija

Pretplata i procenat po realizovanom pregledu predstavljaju predlog poslovnog modela. Lokalna statistika ne izdaje racune niti naplacuje klinikama. Prihod realizovanih pregleda treba razlikovati od vrednosti buducih rezervacija i otkazanih termina.
