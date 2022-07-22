# Filtraggio di immagini (Equazione del calore e metodo Perona-Malik)
Tesi di Lurea (Laurea di primo livello in Matematica per l'ingegneria al Politecnico di Torino) sul filtraggio di immagini.

Il repository è diviso in due sezioni:
- Latex contenente per l'appunto il codice Latex e il pdf risultante che costituisce l'effettiva tesi
- MATLAB contenente i codici matlab tramite i quali si sono implementati i metodi o si sono testati alcuni aspetti preliminari (come il rilevamento dei bodi)

**Per leggere il testo integrale vedere il file toptesi_template.pdf nella cartella Latex**

## Sommario
Le immagini sono da sempre state fondamentali per l’uomo, che sin dai primi tempi le ha utilizzate per ricordare, illustrare, comunicare, etc. Per questo motivo, cercare di sfruttarle nel migliore
dei modi è oggigiorno un problema di grande interesse. Molteplici sono i metodi di elaborazione digitali detti "di filtraggio", il cui scopo è modificare l’immagine, estraendone elementi,
nascondendoli o facendoli risaltare, così da migliorarla per renderla quanto più utile possibile
agli scopi richiesti.
Durante questa trattazione, dopo una breve introduzione volta a fornire una visione d’insieme
del campo in esame (nel quale ci si sta introducendo), verrà illustrato il concetto di immagine
digitale, di filtro e di equazioni alle derivate parziali, con particolare riguardo al ruolo fondamentale che queste ultime giocano nella scrittura dei filtri e la relativa implementazione all’interno
del calcolatore.
Nello specifico, nella parte introduttiva si parlerà della storia delle immagini digitali e del filtraggio analogico e digitale, dei principali problemi consequenziali e di alcune delle più semplici
elaborazioni digitali. Verranno poi fornite alcune nozioni preliminari tra cui: il concetto di immagine come funzione matematica e quindi di immagine digitale, della relativa codifica, di pixel,
del concetto di risoluzione ed altresì di quanto essa influisca sullo spazio di archiviazione. Successivamente saranno analizzati i filtri intesi come convoluzioni tra la funzione immagine e la
funzione filtro.
Infine la trattazione diventerà più specifica, presentando il fulcro di questo studio, ossia l’implementazione del metodo Perona-Malik; a sostegno di ciò verrà illustrato il metodo delle differenze
finite per l’approssimazione delle derivate parziali con relativa analisi dell’errore di troncamento. Questo risultato sarà dunque sfruttato per la realizzazione di uno script MATLAB che operi
l’equazione del calore e che verrà poi opportunamente modificato per implementare il metodo
Perona-Malik.

####Esempio di utilizzo
![disegno_risultati](https://user-images.githubusercontent.com/86683344/180495278-9b721e9b-a676-43db-ba63-c69fdcbc0958.png)
