table 71070 "Class Fee Header"
{
    //    No  Date    Sign      Trigger                                 Description
    // -----------------------------------------------------------------------------------------------
    //   01  22/09/09 KATHIR    OnInsert()                              Code added to get Current academic year
    //   02  22/09/09 KATHIR    OnInsert()                              Code Added to generate number series
    //   03  22/02/09 KATHIR    AssistEdit()                            Code Added to generate number series
    //   04  23/09/09 KATHIR    Fee Classification Code - OnValidate()  Code Added to Check Fees Generated for Particular Class,Section
    //                                                                  Curriculum,Academic Year
    //   05  19/10/09 VANDHANA  OnInsert                                Code to assign User ID.
    //   06  23/11/09 VIGNESH  Class - OnLookup()                       Code added to get the Look up value for Class & Curriculum
    //   07  23/11/09 VIGNESH  Curriculum Intrested - OnLookup()        Code added to get the Look up value for Class & Curriculum
    //   08  23/11/09 VIGNESH  Class - OnLookup()                      Code added to get the Look up value for Class&Curriculum last attend
    //   09  23/11/09 VIGNESH  Curriculum Followed - OnLookup()        Code added to get the Look up value for Class&Curriculum last attend
    //   10  24/11/09 VIGNESH  Fee Classification Code - OnValidate()  Code commented Filter based on section

    Caption = 'Class Fee Header';
    LookupPageID = 71078;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Class; Code[20])
        {
            Caption = 'Class';
            TableRelation = "Class Card".Class;

            trigger OnLookup()
            begin
                // Start 07.VIGNESH
                ClassCardLook.LookUpClass(Class, Curriculum, "Academic Year");
                // Stop 07.VIGNESH
            end;

            trigger OnValidate()
            begin
                // Start 06.VIGNESH
                ClassCardLook.ValidateClass(Class, Curriculum, "Academic Year");
                // Stop 06.VIGNESH
            end;
        }
        field(4; "Fee Classification Code"; Code[20])
        {
            Caption = 'Fee Classification Code';
            TableRelation = "Fee Classification";

            trigger OnValidate()
            begin
                // Start 04.KATHIR
                ClassFeeHead.Reset;
                ClassFeeHead.SetCurrentKey(Class, Curriculum, "Academic Year", "Fee Classification Code");
                ClassFeeHead.SetRange(Class, Class);
                ClassFeeHead.SetRange(Curriculum, Curriculum);
                ClassFeeHead.SetRange("Academic Year", "Academic Year");
                ClassFeeHead.SetRange("Fee Classification Code", "Fee Classification Code");
                if ClassFeeHead.FindFirst then
                    Error(Text000);

                // Start 04.KATHIR
            end;
        }
        field(5; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year";
        }
        field(6; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            TableRelation = "Class Card".Curriculum;

            trigger OnLookup()
            begin
                // Start 09.VIGNESH
                ClassCardLook.LookUpCurriculum(Class, Curriculum, "Academic Year");
                // Stop 09.VIGNESH
            end;

            trigger OnValidate()
            begin
                // Start 08.VIGNESH
                ClassCardLook.ValidateCurriculum(Class, Curriculum, "Academic Year");
                // Stop 08.VIGNESH
            end;
        }
        field(7; "Class Group"; Code[10])
        {
            Caption = 'Class Group';
            TableRelation = "Class Group";
        }
        field(8; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
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
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Class, Curriculum, "Academic Year", "Fee Classification Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        // Start 02.KATHIR
        FeeSetup.Get;
        if "No. Series" = '' then begin
            FeeSetup.TestField("Class Fee No.");
            NoSeriesMgt.InitSeries(FeeSetup."Class Fee No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        // Stop 02.KATHIR
        // Start 01.KATHIR
        "Academic Year" := EduVert.GetAcademicYear;
        // Stop 01.KATHIR
        // Start 05. VANDHANA
        "User ID" := UserId;
        // Stop 05. VANDHANA
    end;

    var
        EduVert: Codeunit "Education Vertical";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FeeHead: Record "Class Fee Header";
        FeeSetup: Record "Fee Setup";
        ClassFeeHead: Record "Class Fee Header";
        Text000: Label 'Fees Already Generated for Current Class ';
        ClassCardLook: Record "Class Card";

    [Scope('Internal')]
    procedure AssistEdit(OldFee: Record "Class Fee Header"): Boolean
    begin
        // Start 03.KATHIR
        with FeeHead do begin
            FeeHead := Rec;
            FeeSetup.Get;
            FeeSetup.TestField("Class Fee No.");
            if NoSeriesMgt.SelectSeries(FeeSetup."Class Fee No.", OldFee."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := FeeHead;
                exit(true);
            end;
        end;

        // Stop 03.KATHIR
    end;
}

