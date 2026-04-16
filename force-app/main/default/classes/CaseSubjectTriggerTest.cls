@isTest
private class CaseSubjectTriggerTest {
    private static final String EXPECTED_SUBJECT = 'Demo of copilot';

    @isTest
    static void singleInsertSetsSubjectViaTrigger() {
        Case c = new Case(
            Origin = 'Phone',
            Status = 'New',
            Subject = 'Will be overwritten'
        );

        Test.startTest();
        insert c;
        Test.stopTest();

        Case result = [SELECT Subject FROM Case WHERE Id = :c.Id];
        System.assertEquals(
            EXPECTED_SUBJECT,
            result.Subject,
            'Trigger should set Subject on single insert'
        );
    }

    @isTest
    static void bulkInsertSetsSubjectForAllRecords() {
        List<Case> cases = new List<Case>();
        for (Integer i = 0; i < 200; i++) {
            cases.add(new Case(
                Origin = 'Web',
                Status = 'New',
                Subject = 'Bulk Subject ' + i
            ));
        }

        Test.startTest();
        insert cases;
        Test.stopTest();

        List<Case> results = [
            SELECT Subject FROM Case WHERE Id IN :cases
        ];
        System.assertEquals(200, results.size(), 'All 200 cases should be inserted');
        for (Case c : results) {
            System.assertEquals(
                EXPECTED_SUBJECT,
                c.Subject,
                'Trigger should set Subject for every record in bulk insert'
            );
        }
    }

    @isTest
    static void insertWithNullSubjectSetsExpectedValue() {
        Case c = new Case(
            Origin = 'Email',
            Status = 'New'
        );

        Test.startTest();
        insert c;
        Test.stopTest();

        Case result = [SELECT Subject FROM Case WHERE Id = :c.Id];
        System.assertEquals(
            EXPECTED_SUBJECT,
            result.Subject,
            'Trigger should set Subject even when original Subject is null'
        );
    }
}
