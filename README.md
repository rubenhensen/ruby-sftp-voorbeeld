# Stappen
1. `gem install uri net-sftp`
2. Maak een environment variable aan met de key `SFTPTOGO_URL` en als value `sftp://foys:'<wachtwoord hier>'@phocasnijmegen.nl` (apostrof niet weglaten rondom het wachtwoord.). In linux kan dat door het commando `export SFTPTOGO_URL=sftp://foys:'wachtwoordhier'@phocasnijmegen.nl
3. `ruby main.rb`

# Belangrijk
- Gebruikersnaam is foys met kleine letters
- Wachtwoord heeft apostrofs nodig omdat de uri lib het anders fout parsed.
- Het foys account heeft alleen rechten tot de `/foys` folder, niet `/`
