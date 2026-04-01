/**
 * @description Utility class for Account-related operations
 * @author Training Team
 * @date 2024
 */
public with sharing class AccountHelper {
    
    /**
     * @description Updates the annual revenue for a list of accounts
     * @param accounts List of accounts to update
     * @param newRevenue The new annual revenue value
     * @return List of updated accounts
     */
    public static List<Account> updateAnnualRevenue(List<Account> accounts, Decimal newRevenue) {
        if (accounts == null || accounts.isEmpty()) {
            return new List<Account>();
        }
        // this is a conflict
        
        if (newRevenue == null || newRevenue < 0) {
            throw new IllegalArgumentException('Annual revenue must be a positive value');
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        
        for (Account acc : accounts) {
            if (acc.Id != null) {
                acc.AnnualRevenue = newRevenue;
                accountsToUpdate.add(acc);
            }
        }
        
        if (!accountsToUpdate.isEmpty()) {
            try {
                update accountsToUpdate;
            } catch (DmlException e) {
                throw new DmlException('Failed to update accounts: ' + e.getMessage());
            }
        }
        
        return accountsToUpdate;
    }
    
    /**
     * @description Retrieves accounts by industry
     * @param industry The industry to filter by
     * @return List of accounts in the specified industry
     */
    public static List<Account> getAccountsByIndustry(String industry) {
        if (String.isBlank(industry)) {
            return new List<Account>();
        }
        
        return [
            SELECT Id, Name, Industry, AnnualRevenue 
            FROM Account 
            WHERE Industry = :industry 
            WITH SECURITY_ENFORCED
            LIMIT 100
        ];
        // and i want something here as well
    }
    
    /**
     * @description Custom exception class for AccountHelper
     */
    public class AccountHelperException extends Exception {}
}