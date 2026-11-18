# EMAD Task 2 – To-Do List App (Flutter)

Progetto individuale per l'insegnamento di **Enterprise Mobile Application Development** (EMAD).  
L'applicazione è una semplice to-do list realizzata in Flutter, progettata per prendere familiarità con la composizione di widget, la gestione dello stato, l'input dell'utente e la navigazione tra schermate.

---

## 📱 Funzionalità e Scenari Implementati

### 1. Dominio dell'applicazione
L'applicazione gestisce l'entità **Attività (`Task`)**, caratterizzata da:
* **Titolo**: testo obbligatorio (`String`).
* **Stato**: "da fare" o "completata" (default: "da fare").
* **Importanza**: importante o non importante (default: non importante).

### 2. Requisiti e Scenari
* **S1 – Aggiungere un'attività (R1)**:
  * Accesso tramite pulsante `FloatingActionButton` ("Nuova Attività").
  * Inserimento del titolo con validazione e switch per contrassegnarla come importante.
  * Alla conferma, salvataggio dell'attività, ritorno all'elenco e notifica temporanea tramite `SnackBar`.
  * **Variante titolo mancante**: segnalazione di errore immediata sotto il campo ("Il titolo è obbligatorio") e blocco della creazione; l'errore scompare non appena l'utente digita un titolo valido.
  * **Variante rinuncia**: annullamento tramite pulsante dedicato o pulsante "Indietro" di sistema; nessuna modifica all'elenco e nessun messaggio.
* **S2 – Consultare le attività (R2)**:
  * Elenco delle attività con titolo, stato (badge e checkbox) e importanza (evidenziazione e icona stella) ben distinguibili.
  * Scheda di avanzamento con contatore visibile: **"X su Y completate"** e percentuale.
  * **Variante nessuna attività**: stato vuoto illustrato con indicazioni su come inserire la prima attività.
* **S3 – Aggiornare lo stato di un'attività (R3)**:
  * Tap sulla casella o sull'elemento per alternare tra "completata" e "da fare".
  * Aggiornamento immediato dell'interfaccia e del conteggio delle completate.
* **S4 – Eliminare un'attività (R4)**:
  * Tap sull'icona del cestino.
  * Dialogo di conferma (`AlertDialog`) con opzioni *Annulla* ed *Elimina*.
  * Conferma: rimozione immediata dell'elemento e ricalcolo del contatore.
  * **Variante rinuncia**: alla pressione di "Annulla" o tap all'esterno, il dialogo si chiude lasciando l'elenco inalterato.

---

## 🏛️ Architettura del Progetto

La struttura segue i principi di modularità e pulizia del codice Flutter:

```text
lib/
├── models/
│   └── task.dart            # Modello dati dell'entità Task
├── screens/
│   ├── home_screen.dart     # Schermata elenco (S2, S3, S4) + contatore
│   └── add_task_screen.dart # Schermata form di inserimento e validazione (S1)
├── widgets/
│   └── task_tile.dart       # Widget riutilizzabile per il singolo elemento della lista
└── main.dart                # Entry point dell'app e configurazione del tema Material 3
```

---

## 🚀 Come eseguire l'applicazione

### Prerequisiti
* Flutter SDK (3.x o superiore) installato e configurato.
* Emulatore Android/iOS avviato oppure smartphone fisico collegato con debug USB abilitato.

### Esecuzione
1. Clonare il repository:
   ```bash
   git clone https://github.com/alphi0m/EMAD_task2.git
   cd EMAD_task2
   ```
2. Scaricare le dipendenze:
   ```bash
   flutter pub get
   ```
3. Avviare l'app:
   ```bash
   flutter run
   ```

Per eseguire i test automatici:
```bash
flutter test
```

---

## 📸 Materiale per la Consegna (Screenshot)

Secondo la traccia, per la consegna sono previsti:
1. **Screenshot 1 – Elenco Attività (Scenario S2)**:
   * Almeno 3 attività inserite.
   * Almeno una contrassegnata come "completata".
   * Almeno una contrassegnata come "importante".
   * Conteggio visibile in alto (es. "1 su 3 completate").
2. **Screenshot 2 – Errore Titolo Mancante (Scenario S1 - Variante)**:
   * Schermata di creazione con il campo titolo lasciato vuoto e il messaggio di validazione visibile dopo aver premuto "Crea Attività".
