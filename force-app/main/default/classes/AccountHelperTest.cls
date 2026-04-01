/**
 * @description Test class for AccountHelper
 * @author Training Team
 * @date 2024
 */
@IsTest
private class AccountHelperTest {
    
    /**
     * @description Test data setup method
     */
    @TestSetup
    static void setupTestData() {
        List<Account> testAccounts = new List<Account>();
        
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(
                Name = 'Test Account ' + i,
                Industry = 'Technology',
                AnnualRevenue = 1000000
            ));
        }
        
        testAccounts.add(new Account(
            Name = 'Manufacturing Account',
            Industry = 'Manufacturing',
            AnnualRevenue = 500000
        ));
        
        insert testAccounts;
    }
    
    /**
     * @description Test successful update of annual revenue
     */
    @IsTest
    static void testUpdateAnnualRevenueSuccess() {
        // Arrange
        List<Account> accounts = [SELECT Id, Name, AnnualRevenue FROM Account WHERE Industry = 'Technology'];
        Decimal newRevenue = 2000000;
        
        // Act
        Test.startTest();
        List<Account> updatedAccounts = AccountHelper.updateAnnualRevenue(accounts, newRevenue);
        Test.stopTest();
        
        // Assert
        System.assertEquals(5, updatedAccounts.size(), 'Should return 5 updated accounts');
        
        List<Account> verifyAccounts = [SELECT Id, AnnualRevenue FROM Account WHERE Id IN :updatedAccounts];
        for (Account acc : verifyAccounts) {
            System.assertEquals(newRevenue, acc.AnnualRevenue, 'Annual revenue should be updated');
        }
    }
    
    /**
     * @description Test update with null accounts list
     */
    @IsTest
    static void testUpdateAnnualRevenueNullAccounts() {
        // Act
        Test.startTest();
        List<Account> result = AccountHelper.updateAnnualRevenue(null, 1000000);
        Test.stopTest();
        
        // Assert
        System.assertEquals(0, result.size(), 'Should return empty list for null input');
    }
    
    /**
     * @description Test update with empty accounts list
     */
    @IsTest
    static void testUpdateAnnualRevenueEmptyAccounts() {
        // Act
        Test.startTest();
        List<Account> result = AccountHelper.updateAnnualRevenue(new List<Account>(), 1000000);
        Test.stopTest();
        
        // Assert
        System.assertEquals(0, result.size(), 'Should return empty list for empty input');
    }
    
    /**
     * @description Test update with negative revenue
     */
    @IsTest
    static void testUpdateAnnualRevenueNegativeValue() {
        // Arrange
        List<Account> accounts = [SELECT Id FROM Account LIMIT 1];
        
        // Act & Assert
        Test.startTest();
        try {
            AccountHelper.updateAnnualRevenue(accounts, -1000);
            System.assert(false, 'Should throw exception for negative revenue');
        } catch (IllegalArgumentException e) {
            System.assert(e.getMessage().contains('positive value'), 'Should throw appropriate exception');
        }
        Test.stopTest();
    }
    
    /**
     * @description Test update with null revenue
     */
    @IsTest
    static void testUpdateAnnualRevenueNullValue() {
        // Arrange
        List<Account> accounts = [SELECT Id FROM Account LIMIT 1];
        
        // Act & Assert
        Test.startTest();
        try {
            AccountHelper.updateAnnualRevenue(accounts, null);
            System.assert(false, 'Should throw exception for null revenue');
        } catch (IllegalArgumentException e) {
            System.assert(e.getMessage().contains('positive value'), 'Should throw appropriate exception');
        }
        Test.stopTest();
    }
    
    /**
     * @description Test retrieving accounts by industry
     */
    @IsTest
    static void testGetAccountsByIndustrySuccess() {
        // Act
        Test.startTest();
        List<Account> techAccounts = AccountHelper.getAccountsByIndustry('Technology');
        List<Account> mfgAccounts = AccountHelper.getAccountsByIndustry('Manufacturing');
        Test.stopTest();
        
        // Assert
        System.assertEquals(5, techAccounts.size(), 'Should return 5 technology accounts');
        System.assertEquals(1, mfgAccounts.size(), 'Should return 1 manufacturing account');
        
        for (Account acc : techAccounts) {
            System.assertEquals('Technology', acc.Industry, 'All accounts should be in Technology industry');
        }
    }
    
    /**
     * @description Test retrieving accounts with blank industry
     */
    @IsTest
    static void testGetAccountsByIndustryBlankInput() {
        // Act
        Test.startTest();
        List<Account> result1 = AccountHelper.getAccountsByIndustry('');
        List<Account> result2 = AccountHelper.getAccountsByIndustry(null);
        Test.stopTest();
        
        // Assert
        System.assertEquals(0, result1.size(), 'Should return empty list for blank industry');
        System.assertEquals(0, result2.size(), 'Should return empty list for null industry');
    }
    
    /**
     * @description Test retrieving accounts with non-existent industry
     */
    @IsTest
    static void testGetAccountsByIndustryNotFound() {
        // Act
        Test.startTest();
        List<Account> result = AccountHelper.getAccountsByIndustry('Non-existent Industry');
        Test.stopTest();
        
        // Assert
        System.assertEquals(0, result.size(), 'Should return empty list for non-existent industry');
    }
}