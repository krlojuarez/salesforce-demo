public with sharing class AccountHelper {

    /**
     * Returns a list of Account records.
     * @param recordLimit Number of records to return
     * @return List of Account records
     */
    public static List<Account> getAccounts(Integer recordLimit) {
        return [
            SELECT Id, Name, Industry, Phone, Website
            FROM Account
            ORDER BY Name ASC
            LIMIT :recordLimit
        ];
    }

    /**
     * Creates a new Account with the given name and returns it.
     * @param accountName Name of the new Account
     * @return Newly created Account
     */
    public static Account createAccount(String accountName) {
        Account acc = new Account(Name = accountName);
        insert acc;
        return acc;
    }
}
