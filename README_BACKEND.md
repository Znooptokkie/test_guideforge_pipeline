
# GuideForge

Er is gebruik gemaakt van de mappenstructuur **Package by Feature**, niet de standaard MVC structuur!

## Handleiding

1. Clone het project in je eigen folder
```bash
git clone https://github.com/Matthijs-de-Graaf/GuideForge.git .
```

### Omgevingsvariabelen

1. Er zijn 2 *.env.example* bestanden. Hernoem beide naar *.env* en wijzig niks.
    - De eerste staat in de *root*.
    - De tweede staat in *frontend/.env*.


---


### Docker

- **Linux**: Docker is meestal standaard beschikbaar.  
- **Windows**: Download en installeer *Docker Desktop*.

* **NOTE!:** Gebruik het volgende comanda altijd zodra de containers eenmaal zijn aangemaakt!
```bash
sudo docker-compose restart #linux
```
```bash
docker compose restart # Windows
```

* **NOTE!:** Gebruik vervolgens dit commando om de containers te stoppen!
```bash
sudo docker-compose down # Linux
```
```bash
docker compose down # Windows
```

---

1. Build en start alle containers:

```bash
sudo docker-compose up --build # Linux
```
```bash
docker compose up --build # Windows
```


2. Controleer of de backend draait:

```bash
curl http://localhost:8080/api/books/all # Linux
```
```bash
curl.exe http://localhost:8080/api/books/all # Windows
```

- Bezoek de website op [http://localhost:3000](http://localhost:3000).


---


### Notities

- Alle *root environment variables* worden automatisch door Docker ingelezen en zijn beschikbaar voor de *backend container*.

- Voor *productieomgeving* is een andere setup nodig (build frontend en serve met Nginx), maar deze handleiding richt zich op development.

- Er is een *docker-compose.yml* bestand dat alles regelt voor de *development* omgeving.  

- In het SQL-bestand *docker-entrypoint-initdb.d/init.sql* staan de  tabellen.

- Als het goed is horen de backend en frontend automatisch te refreshen bij changes.

---


### Troubleshooting

1. **Permission Denied**
    - Kijk of de *MYSQL_ROOT_PASSWORD* correct is in de *root .env*. De rest mag niet aangepast worden!


2. **Geen data op `localhost:8080/api/books/all`**
    - Controleer of de database is aangemaakt:
    ```bash
    sudo docker exec -it guideforge_db mysql -u guideforge -p guideforge_db # Linux
    ```
    ```bash
    docker exec -it guideforge_db mysql -u guideforge -p guideforge_db
    ```
    ```sql
    SELECT * FROM book;
    ```


3. **NOTE!:** In de file *docker-compose.yml* is de port *3307:3306* veranderd. Default is *3306:3306* (Default MySQL PORT). 


4. Check of alle 3 de containers draaien:
    - Zorg dat de backend container draait en verbonden is met de database.
    ```bash
    sudo docker ps # Linux
    ```
    ```bash
    docker ps # Windows
    ```


## Docker Commands

1. **Eerste keer start:**

    - Voer dit command eenmalig uit! Tenzij *docker-compose.yml* wordt aangepast.
    ```bash
    sudo docker-compose up --build # Linux
    ```
    ```bash
    docker compose up --build #Windows
    ```

2. **Docker Containers verwijderen:**

    - Mochten er problemen zijn kan je het volgende commando proberen en daarna weer het bovenstaande commando.
    ```bash
    sudo docker-compose down -v # Linux
    ```
    ```bash
    docker compose down -v # Windows
    ```

3. **Start alle services weer opnieuw:**

    - Zorgt dat de containers weer actief worden.
    ```bash
    sudo docker-compose up # Linux
    ```
    ```bash
    docker compose up # Windows
    ```

4. **Start de containers in *detach mode* (achtergrond):**

    - Start Docker zonder de logs te tonen in de terminal
    ```bash
    sudo docker-compose up -d # Linux
    ```
    ```bash
    docker compose up -d # Windows
    ```

5. **Herstart containers:**

    - Als de containers al zijn aangemaakt.
    ```bash
    sudo docker-compose restart # Linux
    ```
    ```bash
    docker compose restart # Windows
    ```

6. **Kijk welke containers draaien:**

    - Er zouden voor dit project 3 containers moeten draaien: (*guideforge_db*, *guideforge_backend*, *guidefoge_frontend*)
    ```bash
    sudo docker ps # Linux
    ```
    ```bash
    docker ps # windows
    ```

7. **Bekijk de logs:**

    - Eventueel voor foutopsporing:
    ```bash
    sudo docker-compose logs -f # Linux
    ```
    ```bash
    docker compose loge -f # Windows
    ```

## Woordenlijst

- **JDBC Verbinding**

- **Package by Layer**
- **Package by Feature**

- **Java Record File**

- **Dependecy Injection**

- **Optional Type**

- **Functional Interface**

- **Annotaties:**

    ---*Spring Boot Kern*---
    * @SpringBootApplication
    * @Configuration
    * @Bean

    ----*Dependecy Injection / Lifecycle*---
    * @Autowired
    * @Component
    * @Repository
    * @PostConstruct

    ----*Controller / REST API*---
    * @RestController
    * @RequestMapping
    * @GetMapping
    * @PostMapping
    * @PutMapping
    * @DeleteMapping
    * @ResponseStatus

    ----*Request Handling / Parameters*---
    * @PathVariable
    * @RequestBody

    ----*Validatie*---
    * @Valid
    * @NotEmpty

    ----*JSON / Serialisatie*---
    * @JsonValue

    ----*Java (Core)*---
    * @Override# GuideForgeTest