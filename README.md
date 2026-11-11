# Balkan MedTech

Lokalni prototip pretrage medicinskih pregleda i upravljanja rezervacijama. Sadrži 32 medicinske grupe, profile klijenta i ordinacije, kalendar, radno vreme, potvrđivanje zahteva, istoriju i obaveštenja u aplikaciji.

## Pokretanje

Potreban je **Node.js 24 ili noviji**. Nema npm zavisnosti niti potrebe za internetom tokom rada.

```powershell
node server.cjs
```

Otvorite **http://localhost:4175/** u Chromeu, Edgeu, Firefoxu ili drugom modernom pregledaču. Na Windowsu možete koristiti `POKRENI.cmd` ili `POKRENI-CHROME.cmd`. `ZAUSTAVI.cmd` zaustavlja server pokrenut tim pokretačem.

Ako lokalna kopija već sadrži `runtime/node.exe`, pokretač koristi taj runtime; binarni runtime se ne čuva na GitHubu.

## Demo nalozi

Na vrhu stranice su **Demo klijent** i **Demo ordinacija** za ulazak jednim klikom. Na prvom pokretanju generišu se dva lokalna probna naloga i privatni podaci za običnu prijavu u folderu `data/`. Koristite samo izmišljene podatke.

`DEMO-ISKLJUCI.cmd` isključuje brzi pristup i na backendu; posle toga osvežite stranicu. `DEMO-UKLJUCI.cmd` ga ponovo uključuje. Obična registracija/prijava ostaje dostupna. Lokalni reset lozinke i kreiranje osoblja opisani su u `NALOZI.txt`.

## Kalendar i rezervacije

- Ordinacija podešava radno vreme po danima, pauzu i trajanje pregleda.
- Uključivanje/isključivanje termina utiče na pretragu u istoj lokalnoj bazi.
- Novi zahtev zauzima termin dok ordinacija ne prihvati ili odbije zahtev.
- Klijent vidi predstojeće rezervacije i istoriju; obe strane dobijaju lokalna obaveštenja.
- Istorija ranijih zakazivanja i ranije obavljenih pregleda prikazuju se odvojeno.

Detaljnija uputstva: `KALENDAR.txt`, `BRZI-DEMO.txt`, `PROCITAJ.txt` i `INTEGRACIJE.md`.

## Testovi

```powershell
node --test backend.test.cjs calendar.test.cjs frontend.test.cjs
```

Backend testovi koriste privremene baze. Frontend test proverava inicijalizaciju i glavne prikaze kroz simulirani DOM; nije zamena za vizuelnu proveru u stvarnom pregledaču.

## Lokalni podaci

SQLite baza, ključevi, lozinke i sesije nastaju lokalno u `data/` i **ne šalju se na GitHub**. Bazu i njen `contacts.key` treba zajedno čuvati u privatnoj rezervnoj kopiji. Repo sadrži kod i uputstva, ne postojeće rezervacije ili naloge sa određenog računara.

Klinike, lekari i termini su demonstracioni. Nema stvarnog slanja SMS/Viber poruka, spoljne kliničke sinhronizacije, naplate, medicinskih uploadova ili video poziva. Ovo nije produkcijski zdravstveni sistem niti potvrda pravne usklađenosti.

## Razvoj i sinhronizacija

Pre svake izmene proveriti `origin/main`, a završene promene poslati na GitHub. Pravila su sačuvana u `AGENTS.md`. Lokalna aplikacija i dalje radi bez GitHuba ili interneta.
