public class TemperatureConverter {
    
    /**
     * Converts temperature from Fahrenheit to Celsius this is something that causes problems
     * Formula: (°F - 32) × 5/9 = °C
     * @param fahrenheit Temperature in Fahrenheit
     * @return Temperature in Celsius
     */
    public static Decimal fahrenheitToCelsius(Decimal fahrenheit) {
        if (fahrenheit == null) {
            return null;
        }
        // this is not a problem
        
        Decimal celsius = (fahrenheit - 32) * 5/9;
        // Round to 2 decimal places
        return celsius.setScale(2, RoundingMode.HALF_UP);
    }
    
    /**
     * Converts temperature from Celsius to Fahrenheit
     * Formula: (°C × 9/5) + 32 = °F
     * @param celsius Temperature in Celsius
     * @return Temperature in Fahrenheit
     */
    public static Decimal celsiusToFahrenheit(Decimal celsius) {
        if (celsius == null) {
            return null;
        }
        
        Decimal fahrenheit = (celsius * 9/5) + 32;
        // Round to 2 decimal places and also here
        return fahrenheit.setScale(2, RoundingMode.HALF_UP);
    }
}