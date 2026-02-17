codeunit 71170 "Scheme Of Work"
{

    trigger OnRun()
    begin
    end;

    var
        FacultyClassPlanHeader: Record "Faculty Class Plan Header";
        Text001: Label 'Already the Plan Has been Applied';
        Text002: Label 'Already the Plan Has been Appoved';
        Text003: Label 'Already the Plan Has been Rejected';
        Text004: Label 'Do you want to send this for approval ?';
        Text005: Label 'The Plan Has not been Applied';
        Text006: Label 'Already the Plan Has been Appoved';
        Text007: Label 'Do you want approve this plan ?';
        Text008: Label 'The Plan Has not been Applied';
        Text009: Label 'Already the Plan Has been Appoved';
        Text010: Label 'Already the Plan Has been Rejected';
        Text011: Label 'Do you want reject this plan ?';
        Text012: Label 'Please give the comments for the rejection';


    procedure ApplyFacultyPlan(cdeDocument: Code[20])
    begin
        if FacultyClassPlanHeader.Get(cdeDocument) then begin
            if FacultyClassPlanHeader."Plan Status" = FacultyClassPlanHeader."Plan Status"::Applied then
                Error(Text001);

            if FacultyClassPlanHeader."Plan Status" = FacultyClassPlanHeader."Plan Status"::Approved then
                Error(Text002);

            if FacultyClassPlanHeader."Plan Status" = FacultyClassPlanHeader."Plan Status"::Rejected then
                Error(Text003);

            if Confirm(Text004, true) then begin
                FacultyClassPlanHeader."Plan Status" := FacultyClassPlanHeader."Plan Status"::Applied;
                FacultyClassPlanHeader.Modify();
            end;
        end;
    end;


    procedure ApproveFacultyPlan(cdeDocument: Code[20])
    begin
        if FacultyClassPlanHeader.Get(cdeDocument) then begin
            if FacultyClassPlanHeader."Plan Status" = FacultyClassPlanHeader."Plan Status"::" " then
                Error(Text005);

            if FacultyClassPlanHeader."Plan Status" = FacultyClassPlanHeader."Plan Status"::Approved then
                Error(Text006);

            if FacultyClassPlanHeader."Plan Status" = FacultyClassPlanHeader."Plan Status"::Applied then
                if Confirm(Text007, true) then begin
                    FacultyClassPlanHeader."Plan Status" := FacultyClassPlanHeader."Plan Status"::Approved;
                    FacultyClassPlanHeader.Modify();
                end;
        end;
    end;


    procedure RejectFacultyPlan(cdeDocument: Code[20])
    begin
        if FacultyClassPlanHeader.Get(cdeDocument) then begin
            if FacultyClassPlanHeader."Plan Status" = FacultyClassPlanHeader."Plan Status"::" " then
                Error(Text008);

            if FacultyClassPlanHeader."Plan Status" = FacultyClassPlanHeader."Plan Status"::Approved then
                Error(Text009);

            if FacultyClassPlanHeader."Plan Status" = FacultyClassPlanHeader."Plan Status"::Rejected then
                Error(Text010);

            if FacultyClassPlanHeader."Plan Status" = FacultyClassPlanHeader."Plan Status"::Applied then
                if Confirm(Text011, true) then begin
                    if FacultyClassPlanHeader.Comments = '' then
                        Error(Text011);
                    FacultyClassPlanHeader."Plan Status" := FacultyClassPlanHeader."Plan Status"::Rejected;
                    FacultyClassPlanHeader.Modify();
                end;
        end;
    end;
}

