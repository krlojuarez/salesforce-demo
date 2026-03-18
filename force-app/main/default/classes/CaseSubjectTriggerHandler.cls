public with sharing class CaseSubjectTriggerHandler {
    private static final String DEMO_SUBJECT = 'Demo of copilot';

    public static void beforeInsert(List<Case> newCases) {
        for (Case c : newCases) {
            c.Subject = DEMO_SUBJECT;
        }
    }
}
