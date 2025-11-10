# Spring Boot Unit Test Setup

---

## 1. Database Setup
- **Unit tests:** H2 in-memory database
  - Geen echte MySQL nodig
  - Spring JPA configuratie:
    - `spring.jpa.hibernate.ddl-auto=create` → maakt tabellen automatisch aan in H2
    - `spring.jpa.show-sql=true` → logt SQL statements

---

## 2. Data Loader
- **Class:** `BookJsonDataLoader`
- **Functie:**
  - Laadt JSON-data van `/data/books.json` in de database
  - Controleert of database leeg is voordat data wordt toegevoegd
- **Profiles:**
  - `@Profile("!test")` → wordt **niet** uitgevoerd tijdens unit tests

---

## 3. Maven POM aanpassingen
- **H2 dependecy toegevoegd voor test:**
```xml
<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
    <scope>test</scope>
</dependency>
```

## 4. Bestand application-test.properties aangepast


## 5. Voer Dockerfile.test uit:
- **Draait de integratie- en unit-tests binnen Docker zonder de applicatie te starten.**
```bash
docker build -f Dockerfile.test -t backend-tests .
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock backend-tests
```

## 6. Voer individuele test uit:
```bash
mvn test -Dtest=BookControllerTest
```