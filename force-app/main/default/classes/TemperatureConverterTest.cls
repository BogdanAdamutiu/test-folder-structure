@IsTest
public class TemperatureConverterTest {
    
    @IsTest
    static void testFahrenheitToCelsius() {
        // Test case 1: Water freezing point
        Decimal celsius1 = TemperatureConverter.fahrenheitToCelsius(32);
        System.assertEquals(0, celsius1, 'Incorrect conversion for freezing point');
        
        // Test case 2: Water boiling point
        Decimal celsius2 = TemperatureConverter.fahrenheitToCelsius(212);
        System.assertEquals(100, celsius2, 'Incorrect conversion for boiling point');
        
        // Test case 3: Room temperature
        Decimal celsius3 = TemperatureConverter.fahrenheitToCelsius(68);
        System.assertEquals(20, celsius3, 'Incorrect conversion for room temperature');
        
        // Test case 4: Negative temperature
        Decimal celsius4 = TemperatureConverter.fahrenheitToCelsius(-40);
        System.assertEquals(-40, celsius4, 'Incorrect conversion for -40 degrees');
        
        // Test case 5: Null input
        Decimal celsius5 = TemperatureConverter.fahrenheitToCelsius(null);
        System.assertEquals(null, celsius5, 'Should return null for null input');
    }
    
    @IsTest
    static void testCelsiusToFahrenheit() {
        // Test case 1: Water freezing point
        Decimal fahrenheit1 = TemperatureConverter.celsiusToFahrenheit(0);
        System.assertEquals(32, fahrenheit1, 'Incorrect conversion for freezing point');
        
        // Test case 2: Water boiling point
        Decimal fahrenheit2 = TemperatureConverter.celsiusToFahrenheit(100);
        System.assertEquals(212, fahrenheit2, 'Incorrect conversion for boiling point');
        
        // Test case 3: Room temperature
        Decimal fahrenheit3 = TemperatureConverter.celsiusToFahrenheit(20);
        System.assertEquals(68, fahrenheit3, 'Incorrect conversion for room temperature');
        
        // Test case 4: Negative temperature
        Decimal fahrenheit4 = TemperatureConverter.celsiusToFahrenheit(-40);
        System.assertEquals(-40, fahrenheit4, 'Incorrect conversion for -40 degrees');
        
        // Test case 5: Null input
        Decimal fahrenheit5 = TemperatureConverter.celsiusToFahrenheit(null);
        System.assertEquals(null, fahrenheit5, 'Should return null for null input');
    }
}