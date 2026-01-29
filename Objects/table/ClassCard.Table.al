table 71006 "Class Card"
{
    //  No   Date      Sign     Trigger                       Description
    // -----------------------------------------------------------------------------------------------
    //   01  19/10/09  VANDHANA OnInsert             Code to assign User ID.
    //   02  17/10/09  VIGNESH                       new filed Cut Off Age and Consolidated Consolidated Grades added
    //   03  23/11/09  VIGNESH  LookUpClass()        Function Created to get the Class & Curiculum value
    //   04  23/11/09  VIGNESH  LookUpCurriculum()   Function Created to get the Class & Curiculum value
    //   05  23/11/09  VIGNESH  ValidateClass()      Function Created to get the Class & Curiculum value
    //   06  23/11/09  VIGNESH  ValidateCurriculum() Function Created to get the Class & Curiculum value

    Caption = 'Class Card';
    DrillDownPageID = 71011;
    LookupPageID = 71011;

    fields
    {
        field(1; Class; Code[10])
        {
            Caption = 'Class Code';
            SQLDataType = Integer;
            TableRelation = Class;
        }
        field(3; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum;
        }
        field(4; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            Editable = true;
            TableRelation = "Academic Year";
        }
        field(5; "Application Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Application Cost';
        }
        field(6; "Registration Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Registration Cost';
        }
        field(15; "Miniimum Age Limit"; Integer)
        {
            BlankZero = true;
            Caption = 'Miniimum Age Limit';
        }
        field(16; "Maximum Age Limit"; Integer)
        {
            BlankZero = true;
            Caption = 'Maximum Age Limit';
        }
        field(18; "Application Sale From"; Date)
        {
            Caption = 'Application Sale From';
        }
        field(19; "Application Sale Till"; Date)
        {
            Caption = 'Application Sale Till';
        }
        field(20; "Application Receive From"; Date)
        {
            Caption = 'Application Receive From';
        }
        field(21; "Application Receive Till"; Date)
        {
            Caption = 'Application Receive Till';
        }
        field(22; Capacity; Decimal)
        {
            CalcFormula = Sum ("Class Section".Capacity WHERE (Class = FIELD (Class),
                                                              Curriculum = FIELD (Curriculum),
                                                              "Academic Year" = FIELD (FILTER ("Academic Year"))));
            Caption = 'Capacity';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Present Strength"; Integer)
        {
            CalcFormula = Count (Student WHERE (Class = FIELD (Class),
                                               Curriculum = FIELD (Curriculum),
                                               "Academic Year" = FIELD (FILTER ("Academic Year"))));
            Caption = 'Present Strength';
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Marks System"; Option)
        {
            Caption = 'Marks System';
            OptionCaption = 'Marks,Grade';
            OptionMembers = Marks,Grade;
        }
        field(25; "Promotion Percentage"; Decimal)
        {
            Caption = 'Promotion Percentage';
        }
        field(26; Promoted; Boolean)
        {
            Caption = 'Promoted';
        }
        field(27; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(28; "Cut Off Age as on"; Date)
        {
            Caption = 'Cut Off Age as on';
        }
        field(29; "Consolidated Grades"; Option)
        {
            Caption = 'Consolidated Grades';
            OptionCaption = ' ,Points,Marks';
            OptionMembers = " ",Points,Marks;
        }
        field(30; Sequence; Integer)
        {
            Caption = 'Sequence';
        }
        field(31; Withdrawal; Integer)
        {
            CalcFormula = Count (Withdrawal WHERE (Class = FIELD (Class),
                                                  Curriculum = FIELD (Curriculum),
                                                  "Academic Year" = FIELD (FILTER ("Academic Year"))));
            Caption = 'Withdrawal';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Edu. Calendar Code"; Code[20])
        {
            TableRelation = Table71921;
        }
        field(70120; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
        }
    }

    keys
    {
        key(Key1; Class, Curriculum, "Academic Year")
        {
            Clustered = true;
        }
        key(Key2; Curriculum, Class)
        {
        }
        key(Key3; Sequence)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01. VANDHANA
        "User ID" := UserId;
        // Stop 01. VANDHANA
    end;

    var
        ClassCard: Record "Class Card";
        EducationSetup: Record "Education Setup";

    [Scope('Internal')]
    procedure LookUpClass(var getClass: Code[10]; var getCurriculum: Code[20]; var getAcademic: Code[20])
    var
        ClassCardRec: Record "Class Card";
    begin
        // Start 03.VIGNESH
        if not GuiAllowed then
            exit;
        ClassCardRec.Class := getClass;
        ClassCardRec.Curriculum := getCurriculum;
        ClassCardRec."Academic Year" := getAcademic;
        ClassCardRec.SetRange(ClassCardRec."Academic Year", getAcademic);
        ClassCardRec.Closed := false;
        if PAGE.RunModal(71011, ClassCardRec, ClassCardRec.Class) = ACTION::LookupOK then begin
            getClass := ClassCardRec.Class;
            getCurriculum := ClassCardRec.Curriculum;
            getAcademic := ClassCardRec."Academic Year";
        end;
        // Stop 04.VIGNESH
    end;

    [Scope('Internal')]
    procedure LookUpCurriculum(var getClass: Code[10]; var getCurriculum: Code[20]; var getAcademic: Code[20])
    var
        ClassCardRec: Record "Class Card";
    begin
        // Start 04.VIGNESH
        if not GuiAllowed then
            exit;
        ClassCardRec.SetCurrentKey(Curriculum, Class, "Academic Year");
        ClassCardRec.Class := getClass;
        ClassCardRec.Curriculum := getCurriculum;
        ClassCardRec."Academic Year" := getAcademic;
        ClassCardRec.Closed := false;
        ClassCardRec.SetRange(ClassCardRec."Academic Year", getAcademic);
        if PAGE.RunModal(71011, ClassCardRec, ClassCardRec.Curriculum) = ACTION::LookupOK then begin
            getClass := ClassCardRec.Class;
            getCurriculum := ClassCardRec.Curriculum;
            getAcademic := ClassCardRec."Academic Year";
        end;
        // Stop 04.VIGNESH
    end;

    [Scope('Internal')]
    procedure ValidateClass(var getClass: Code[10]; var getCurriculum: Code[20]; var getAcademic: Code[20])
    var
        ClassCardRec: Record "Class Card";
        ClassCardRec1: Record "Class Card";
    begin
        // Start 05.VIGNESH
        if not GuiAllowed then
            exit;
        if getClass <> '' then begin
            if StrPos(getClass, '*') = StrLen(getClass) then
                ClassCardRec.SetFilter(Class, getClass)
            else
                ClassCardRec.SetRange(Class, getClass);

            if ClassCardRec.IsEmpty then
                exit;
            ClassCardRec1.Copy(ClassCardRec);
            if (ClassCardRec1.Next = 1) and GuiAllowed then
                if PAGE.RunModal(71011, ClassCardRec, ClassCardRec.Class) <> ACTION::LookupOK then
                    exit;
            getClass := ClassCardRec.Class;
            getCurriculum := ClassCardRec.Curriculum;
            getAcademic := ClassCardRec."Academic Year";
        end;
        // Stop 05.VIGNESH
    end;

    [Scope('Internal')]
    procedure ValidateCurriculum(var getClass: Code[10]; var getCurriculum: Code[20]; var getAcademic: Code[20])
    var
        ClassCardRec: Record "Class Card";
        ClassCardRec1: Record "Class Card";
    begin
        // Start 06.VIGNESH
        if not GuiAllowed then
            exit;
        if getCurriculum <> '' then begin
            if StrPos(getCurriculum, '*') = StrLen(getCurriculum) then
                ClassCardRec.SetFilter(Curriculum, getCurriculum)
            else
                ClassCardRec.SetRange(Curriculum, getCurriculum);

            if ClassCardRec.IsEmpty then
                exit;

            ClassCardRec1.Copy(ClassCardRec);
            if (ClassCardRec1.Next = 1) and GuiAllowed then
                if PAGE.RunModal(71011, ClassCardRec, ClassCardRec.Class) <> ACTION::LookupOK then
                    exit;
            getClass := ClassCardRec.Class;
            getCurriculum := ClassCardRec.Curriculum;
            getAcademic := ClassCardRec."Academic Year";

        end;
        // Stop 06.VIGNESH
    end;
}

