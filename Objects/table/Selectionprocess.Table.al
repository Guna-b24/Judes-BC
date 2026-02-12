table 71013 "Selection process"
{
    Caption = 'Selection process';
    DataClassification = CustomerContent;
    //LookupPageID = 71024;

    fields
    {
        field(1; Class; Code[10])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
            TableRelation = "Class Card".Class;
            ToolTip = 'Specifies the class for which the selection process is conducted.';

            trigger OnLookup()
            begin

                ClassCardLook.LookUpClass(Class, Curriculum, "Academic Year");
                getSeatVacant();
            end;

            trigger OnValidate()
            begin

                ClassCardLook.ValidateClass(Class, Curriculum, "Academic Year");
                getSeatVacant();
            end;
        }
        field(2; Curriculum; Code[20])
        {
            Caption = 'Curriculum';
            DataClassification = CustomerContent;
            TableRelation = "Class Card".Curriculum;
            ToolTip = 'Specifies the curriculum for the selected class.';


            trigger OnLookup()
            begin

                ClassCardLook.LookUpCurriculum(Class, Curriculum, "Academic Year");
                getSeatVacant();

            end;

            trigger OnValidate()
            begin

                ClassCardLook.ValidateCurriculum(Class, Curriculum, "Academic Year");
                getSeatVacant();

            end;
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year";
            ToolTip = 'Specifies the academic year.';
        }
        field(4; "Seats Vacant"; Integer)
        {
            Caption = 'Seats Vacant';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Shows the number of vacant seats available.';
        }
        field(5; "Selection No."; Code[20])
        {
            Caption = 'Selection No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique number of the selection process.';

            trigger OnValidate()
            begin

                if "Selection No." <> xRec."Selection No." then begin
                    ADMSetup.Get();
                    NoseriesMgt.TestManual(ADMSetup."Selection No.");
                    "No Series" := '';
                end;

            end;
        }
        field(6; "No Series"; Code[20])
        {
            Caption = 'No Series';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number series used for the selection process.';
        }
        field(7; "Interview Date"; Date)
        {
            Caption = 'Interview Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the interview date for the selection process.';
        }
        field(8; "Total Selected"; Integer)
        {
            Caption = 'Total Selected';
            CalcFormula = Count(Application WHERE("Application Status" = CONST(Selected),
                                                   Class = FIELD(Class),
                                                   "Curriculum Intrested" = FIELD(Curriculum),
                                                   "Academic Year" = FIELD("Academic Year")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(70121; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the portal identifier.';
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


        if "Selection No." = '' then begin
            ADMSetup.Get();
            ADMSetup.TestField("Selection No.");
            "No Series" := ADMSetup."Selection No.";
            "Selection No." := NoseriesMgt.GetNextNo("No Series");

        end;
        "Academic Year" := EduVertical.GetAdmissionYear();

    end;

    var
        ADMSetup: Record "Admission Setup";
        ClassCardLook: Record "Class Card";
        NoseriesMgt: Codeunit "No. Series";

        EduVertical: Codeunit "Education Vertical";


    procedure Assistedit(Oldsel: Record "Selection process"): Boolean
    begin

        Oldsel := Rec;
        ADMSetup.Get();
        ADMSetup.TestField("Selection No.");
        if NoseriesMgt.LookupRelatedNoSeries(ADMSetup."Selection No.", Oldsel."No Series", "No Series") then begin
            Oldsel."Selection No." := NoseriesMgt.GetNextNo(Oldsel."No Series");
            Rec := Oldsel;
            exit(true);
        end;
    end;


    procedure getSeatVacant()
    var
        ClassCard1: Record "Class Card";
    begin

        ClassCard1.Get(Class, Curriculum);
        ClassCard1.CalcFields(Capacity);
        ClassCard1.CalcFields("Present Strength");
        "Seats Vacant" := ClassCard1.Capacity - ClassCard1."Present Strength";
    end;
}

