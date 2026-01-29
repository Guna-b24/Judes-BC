table 71013 "Selection process"
{
    //    No     Date    Sign     Trigger                 Description
    // -----------------------------------------------------------------------------------------------
    //   01     07/10/09 VANDHANA OnInsert()            Code added for No.series
    //   02     07/10/09 VANDHANA OnValidate()          Code added for No.series
    //   03     07/10/09 VANDHANA Assistedit()          Code added for No.series
    //   04     07/10/09 VANDHANA OnInsert()            Code to insert the Academic Year.
    //   05     19/10/09 VANDHANA OnInser()             Code to insert the User ID.
    //   06     16/11/09 GUNA                           New field added interview DATE
    //   07     23/11/09 VIGNESH  Class - OnValidate()            Code added to get the Class & Curriculum value
    //   08     23/11/09 VIGNESH  Class - OnLookup()              Code added to get the Class & Curriculum value
    //   09     23/11/09 VIGNESH  Curriculum - OnValidate()       Code added to get the Class & Curriculum value
    //   10     23/11/09 VIGNESH  Curriculum - OnLookup()         Code added to get the Class & Curriculum value
    //   11     24/11/09 VIGNESH  getSeatVacant                    Code added to get the seat vacant

    Caption = 'Selection process';
    LookupPageID = 71024;

    fields
    {
        field(1; Class; Code[10])
        {
            Caption = 'Class';
            TableRelation = "Class Card".Class;

            trigger OnLookup()
            begin
                // Start 08.VIGNESH
                ClassCardLook.LookUpClass(Class, Curriculum, "Academic Year");
                getSeatVacant;
                // Stop 08.VIGNESH
            end;

            trigger OnValidate()
            begin
                // Start 07.VIGNESH
                ClassCardLook.ValidateClass(Class, Curriculum, "Academic Year");
                getSeatVacant;
                // Stop 07.VIGNESH
            end;
        }
        field(2; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            TableRelation = "Class Card".Curriculum;

            trigger OnLookup()
            begin
                // Start 10.VIGNESH
                ClassCardLook.LookUpCurriculum(Class, Curriculum, "Academic Year");
                getSeatVacant;
                // Stop 10.VIGNESH
            end;

            trigger OnValidate()
            begin
                // Start 09.VIGNESH
                ClassCardLook.ValidateCurriculum(Class, Curriculum, "Academic Year");
                getSeatVacant;
                // Stop 09.VIGNESH
            end;
        }
        field(3; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(4; "Seats Vacant"; Integer)
        {
            Caption = 'Seats Vacant';
            Editable = false;
        }
        field(5; "Selection No."; Code[10])
        {
            Caption = 'Selection No.';

            trigger OnValidate()
            begin
                // Start 02 VANDHANA
                if "Selection No." <> xRec."Selection No." then begin
                    ADMSetup.Get;
                    NoseriesMgt.TestManual(ADMSetup."Selection No.");
                    "No Series" := '';
                end;
                // Stop 02 VANDHANA
            end;
        }
        field(6; "No Series"; Code[20])
        {
            Caption = 'No Series';
        }
        field(7; "Interview Date"; Date)
        {
            Caption = 'Interview Date';
        }
        field(8; "Total Selected"; Integer)
        {
            CalcFormula = Count (Application WHERE ("Application Status" = CONST (Selected),
                                                   Class = FIELD (Class),
                                                   "Curriculum Intrested" = FIELD (Curriculum),
                                                   "Academic Year" = FIELD ("Academic Year")));
            Caption = 'Total Selected';
            Editable = false;
            FieldClass = FlowField;
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
        key(Key1; "Selection No.")
        {
        }
        key(Key2; Class)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 01 VANDHANA
        ADMSetup.Get;
        if "No Series" = '' then begin
            ADMSetup.TestField("Selection No.");
            NoseriesMgt.InitSeries(ADMSetup."Selection No.", xRec."No Series", 0D, "Selection No.", "No Series");
        end;
        //Stop 01 VANDHANA

        // Start 04 VANDHANA
        "Academic Year" := EduVertical.GetAdmissionYear;
        // Stop 04 VANDHANA

        // Start 05. VANDHANA
        "User ID" := UserId;
        // Stop 05. VANDHANA
    end;

    var
        ADMSetup: Record "Admission Setup";
        NoseriesMgt: Codeunit NoSeriesManagement;
        SelectionProcess: Record "Selection process";
        EduVertical: Codeunit "Education Vertical";
        ClassCard: Record "Class Card";
        ClassCardLook: Record "Class Card";

    [Scope('Internal')]
    procedure Assistedit(Oldsel: Record "Selection process"): Boolean
    begin
        // Start 03 VANDHANA
        with Oldsel do begin
            Oldsel := Rec;
            ADMSetup.Get;
            ADMSetup.TestField("Selection No.");
            if NoseriesMgt.SelectSeries(ADMSetup."Selection No.", Oldsel."No Series", "No Series") then begin
                NoseriesMgt.SetSeries("Selection No.");
                Rec := Oldsel;
                exit(true);
            end;
        end;
        // Stop 03 VANDHANA
    end;

    [Scope('Internal')]
    procedure getSeatVacant()
    var
        ClassCard1: Record "Class Card";
        Student: Record Student;
    begin
        // Start 11.VIGNESH
        ClassCard1.Get(Class, Curriculum);
        ClassCard1.CalcFields(Capacity);
        ClassCard1.CalcFields("Present Strength");
        "Seats Vacant" := ClassCard1.Capacity - ClassCard1."Present Strength";
        // Stop 11.VIGNESH
    end;
}

