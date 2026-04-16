@isTest
private class CaseSubjectTriggerHandlerTest {
    private static final String EXPECTED_SUBJECT = 'Demo of copilot';

    @isTest
    static void setsSubjectToDemoValueOnInsert() {
        Case c = new Case(
            Origin = 'Phone',
            Status = 'New',
            Subject = 'Original Subject'
        );

        Test.startTest();
        insert c;
        Test.stopTest();

        Case insertedCase = [SELECT Subject FROM Case WHERE Id = :c.Id];
        System.assertEquals(EXPECTED_SUBJECT, insertedCase.Subject);
    }

    @isTest
    static void beforeInsertSetsSubjectDirectly() {
        List<Case> cases = new List<Case>{
            new Case(Origin = 'Phone', Status = 'New', Subject = 'Custom')
        };

        Test.startTest();
        CaseSubjectTriggerHandler.beforeInsert(cases);
        Test.stopTest();

        System.assertEquals(
            EXPECTED_SUBJECT,
            cases[0].Subject,
            'Handler should set Subject directly on the in-memory record'
        );
    }

    @isTest
    static void beforeInsertHandlesBulkRecords() {
        List<Case> cases = new List<Case>();
        for (Integer i = 0; i < 200; i++) {
            cases.add(new Case(
                Origin = 'Web',
                Status = 'New',
                Subject = 'Subject ' + i
            ));
        }

        Test.startTest();
        CaseSubjectTriggerHandler.beforeInsert(cases);
        Test.stopTest();

        for (Integer i = 0; i < cases.size(); i++) {
            System.assertEquals(
                EXPECTED_SUBJECT,
                cases[i].Subject,
                'Handler should set Subject for record at index ' + i
            );
        }
    }

    @isTest
    static void beforeInsertSetsSubjectWhenNull() {
        List<Case> cases = new List<Case>{
            new Case(Origin = 'Email', Status = 'New')
        };

        Test.startTest();
        CaseSubjectTriggerHandler.beforeInsert(cases);
        Test.stopTest();

        System.assertEquals(
            EXPECTED_SUBJECT,
            cases[0].Subject,
            'Handler should set Subject even when original value is null'
        );
    }
}
