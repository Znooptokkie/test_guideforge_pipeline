package com.guideforge.backend;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@SpringBootTest
@ActiveProfiles("test") // Sets this class as the Test profile.
class BackendApplicationTests {

	@Test
	void contextLoads() {
		// If ContainerTestConfig is in the test classpath and started statically,
		// the Spring context will use the container-provided JDBC properties.
	}
}