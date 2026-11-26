package com.melodymart.util;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import java.util.Properties;

import org.junit.After;
import org.junit.Test;

public class DBConnectionTest {

    @After
    public void clear() {
        System.clearProperty("test.melodymart.key");
    }

    @Test
    public void fallsBackToPropertiesFile() {
        Properties file = new Properties();
        file.setProperty("test.melodymart.key", " from-file ");
        assertEquals("from-file", DBConnection.resolve("MELODYMART_UNSET_ENV", "test.melodymart.key", file));
    }

    @Test
    public void systemPropertyBeatsFile() {
        Properties file = new Properties();
        file.setProperty("test.melodymart.key", "from-file");
        System.setProperty("test.melodymart.key", "from-sysprop");
        assertEquals("from-sysprop", DBConnection.resolve("MELODYMART_UNSET_ENV", "test.melodymart.key", file));
    }

    @Test
    public void blankValuesAreTreatedAsMissing() {
        Properties file = new Properties();
        file.setProperty("test.melodymart.key", "   ");
        assertNull(DBConnection.resolve("MELODYMART_UNSET_ENV", "test.melodymart.key", file));
    }

    @Test
    public void environmentVariableWins() {
        String path = System.getenv("PATH");
        Properties file = new Properties();
        file.setProperty("test.melodymart.key", "from-file");
        assertEquals(path.trim(), DBConnection.resolve("PATH", "test.melodymart.key", file));
    }
}
