trigger CaseSubjectTrigger on Case (before insert) {
    CaseSubjectTriggerHandler.beforeInsert(Trigger.new);
}
