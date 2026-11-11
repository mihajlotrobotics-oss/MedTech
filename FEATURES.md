# Lokalni MedTech prototip

Novi interfejs koristi lokalno isporučene Lucide ikone i fontove, animirani radar, bento kartice, responzivnu pretragu i podršku za smanjene animacije.

SOS prikazuje ordinacije koje su uključile prijem hitnih upita i trenutno rade prema lokalnom rasporedu. Upiti ističu za 30 minuta; ponuda ordinacije ne zauzima termin dok je klijent ne odabere. Nije servis hitne pomoći niti medicinska trijaža.

Demo prijava ima klijenta, menadžera i recepciju. Recepcija vidi svoju ordinaciju i dnevne operacije, bez finansija. Menadžer uređuje cenovnik, profil lekara, osiguranja, odmore, popuste i lokalnu analitiku. Telefonske i walk-in rezervacije ne ulaze u proviziju platforme. Kašnjenje šalje lokalno obaveštenje o očekivanom dolasku; ne pomera automatski stvarni raspored.

Ordinacija može da sačuva PDF nalaz do 1 MiB, šifrovan u lokalnoj bazi i dostupan odgovarajućem pacijentu. Automatsko slanje emailom i upload prethodnih nalaza od strane pacijenta još nisu implementirani.

Ograničenja: kalendar trenutno modeluje jedan lekarski resurs po ordinaciji. Trajanje usluga prati zajednički interval kalendara; nezavisni rasporedi više lekara i aparata i fotografije lekara ostaju za sledeću fazu. No-show status se evidentira, bez automatskog blokiranja naloga. Heliant/Medis, SMS/Viber, email, plaćanje i video konsultacije nisu povezani.

Provera: `node --test backend.test.cjs calendar.test.cjs frontend.test.cjs phone.test.cjs b2b.test.cjs urgent.test.cjs`.
