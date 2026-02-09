table 71006 "Class Card"
{
    Caption = 'Class Card';
    // DrillDownPageID = 71011;
    // LookupPageID = 71011;

    fields
    {
        field(1; Class; Code[10])
        {
            Caption = 'Class Code';
            TableRelation = Class.Code;
            DataClassification = CustomerContent;
        }
        field(3; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            TableRelation = Curriculum.Code;
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year".Code;
            DataClassification = CustomerContent;
        }
        field(5; "Application Cost"; Decimal)
        {
            Caption = 'Application Cost';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(6; "Registration Cost"; Decimal)
        {
            Caption = 'Registration Cost';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(15; "Miniimum Age Limit"; Integer)
        {
            Caption = 'Minimum Age Limit';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(16; "Maximum Age Limit"; Integer)
        {
            Caption = 'Maximum Age Limit';
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(18; "Application Sale From"; Date)
        {
            Caption = 'Application Sale From';
            DataClassification = CustomerContent;
        }
        field(19; "Application Sale Till"; Date)
        {
            Caption = 'Application Sale Till';
            DataClassification = CustomerContent;
        }
        field(20; "Application Receive From"; Date)
        {
            Caption = 'Application Receive From';
            DataClassification = CustomerContent;
        }
        field(21; "Application Receive Till"; Date)
        {
            Caption = 'Application Receive Till';
            DataClassification = CustomerContent;
        }
        field(22; Capacity; Decimal)
        {
            CalcFormula = sum("Class Section".Capacity where(Class = field(Class),
                                                              Curriculum = field(Curriculum),
                                                              "Academic Year" = field(filter("Academic Year"))));
            Caption = 'Capacity';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Present Strength"; Integer)
        {
            CalcFormula = count(Student where(Class = field(Class),
                                               Curriculum = field(Curriculum),
                                               "Academic Year" = field(filter("Academic Year"))));
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
            DataClassification = CustomerContent;
        }
        field(26; Promoted; Boolean)
        {
            Caption = 'Promoted';
            DataClassification = CustomerContent;
        }
        field(27; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;
        }
        field(28; "Cut Off Age as on"; Date)
        {
            Caption = 'Cut Off Age as on';
            DataClassification = CustomerContent;
        }
        field(29; "Consolidated Grades"; Option)
        {
            Caption = 'Consolidated Grades';
            OptionCaption = ' ,Points,Marks';
            OptionMembers = " ",Points,Marks;
            DataClassification = CustomerContent;
        }
        field(30; Sequence; Integer)
        {
            Caption = 'Sequence';
            DataClassification = CustomerContent;
        }
        field(31; Withdrawal; Integer)
        {
            CalcFormula = Count(Withdrawal WHERE(Class = FIELD(Class),
                                                  Curriculum = FIELD(Curriculum),
                                                  "Academic Year" = FIELD(filter("Academic Year"))));
            Caption = 'Withdrawal';
            Editable = false;
            FieldClass = FlowField;

        }
        field(32; "Edu. Calendar Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
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

    end;

    var
    // ClassCard: Record "Class Card";
    // EducationSetup: Record "Education Setup";


    procedure LookUpClass(var getClass: Code[10]; var getCurriculum: Code[20]; var getAcademic: Code[20])
    var
        ClassCardRec: Record "Class Card";
    begin

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
    end;



    procedure LookUpCurriculum(var getClass: Code[10]; var getCurriculum: Code[20]; var getAcademic: Code[20])
    var
        ClassCardRec: Record "Class Card";
    begin

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

    end;


    procedure ValidateClass(var getClass: Code[10]; var getCurriculum: Code[20]; var getAcademic: Code[20])
    var
        ClassCardRec: Record "Class Card";
        ClassCardRec1: Record "Class Card";
    begin
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
            if (ClassCardRec1.Next() = 1) and GuiAllowed then
                if PAGE.RunModal(71011, ClassCardRec, ClassCardRec.Class) <> ACTION::LookupOK then
                    exit;
            getClass := ClassCardRec.Class;
            getCurriculum := ClassCardRec.Curriculum;
            getAcademic := ClassCardRec."Academic Year";
        end;
    end;


    procedure ValidateCurriculum(var getClass: Code[10]; var getCurriculum: Code[20]; var getAcademic: Code[20])
    var
        ClassCardRec: Record "Class Card";
        ClassCardRec1: Record "Class Card";
    begin

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
            if (ClassCardRec1.Next() = 1) and GuiAllowed then
                if PAGE.RunModal(71011, ClassCardRec, ClassCardRec.Class) <> ACTION::LookupOK then
                    exit;
            getClass := ClassCardRec.Class;
            getCurriculum := ClassCardRec.Curriculum;
            getAcademic := ClassCardRec."Academic Year";

        end;
    end;
}

