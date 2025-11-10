package com.guideforge.backend.controller;

import com.guideforge.backend.book.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class BookControllerTest {

    private BookRepository repo;
    private BookController controller;

    private Language lang;
    private Author author;
    private Publisher publisher;

    @BeforeEach
    void setup() {
        repo = Mockito.mock(BookRepository.class);
        controller = new BookController(repo);

        Language lang = Language.ENGLISH;
        Author author = new Author("Alice Greenwood", "1975-03-12", "USA");
        Publisher publisher = new Publisher("Maple Press", "New York", "USA");
    }

    @Test
    void findAll_returnsList() {
        Book b = new Book(1, "Test Book", "Description", "123456", 100, lang, author, publisher);
        when(repo.findAll()).thenReturn(List.of(b));
        assertEquals(1, controller.findAll().size());
    }

    @Test
    void findById_found_returnsBook() {
        Book b = new Book(1, "Test Book", "Description", "123456", 100, lang, author, publisher);
        when(repo.findById(1)).thenReturn(Optional.of(b));
        assertSame(b, controller.findById(1));
    }

    @Test
    void findById_notFound_throws() {
        when(repo.findById(99)).thenReturn(Optional.empty());
        assertThrows(BookNotFoundException.class, () -> controller.findById(99));
    }

    @Test
    void create_callsRepository() {
        Book b = new Book(1, "Test Book", "Description", "123456", 100, lang, author, publisher);
        controller.create(b);
        verify(repo).create(b);
    }

    @Test
    void update_callsRepository() {
        Book b = new Book(1, "Test Book", "Description", "123456", 100, lang, author, publisher);
        controller.update(b, 1);
        verify(repo).update(b, 1);
    }

    @Test
    void delete_callsRepository() {
        controller.delete(1);
        verify(repo).delete(1);
    }
}
