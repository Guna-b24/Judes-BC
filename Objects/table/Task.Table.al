table 71910 Task
{
    //    No    Date        Sign         Trigger              Description
    // -----------------------------------------------------------------------------------------------
    //   01     07.01.10    ANKESH      OnInsert()            To Initialize The Series.
    //   02     07.01.10    ANKESH    Task No.-OnValidate()   To Run TestManual Function Of NoSeriesManagment Codeunit.
    //   03     07.01.10    ANKESH      AssistEdit()          The Code will Run when the AssistEdit Button Is activated on Form.

    Caption = 'Task';
    LookupPageID = 71916;

    fields
    {
        field(1; "Task No."; Code[20])
        {
            Caption = 'Task No.';

            trigger OnValidate()
            begin
                // Start 02. Ankesh
                if "Task No." <> xRec."Task No." then begin
                    TaskSetup.Get;
                    NoSeriesMgt.TestManual(TaskSetup."Task No.");
                    "No. Series" := '';
                end;
                // Stop 02. Ankesh
            end;
        }
        field(2; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Staff,Student';
            OptionMembers = " ",Staff,Student;
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST (Staff)) Employee
            ELSE
            IF (Type = CONST (Student)) Table33009767;
        }
        field(9; Date; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;
        }
        field(10; "Task Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Not Started,In Progress,Completed,Waiting,Postponed';
            OptionMembers = "Not Started","In Progress",Completed,Waiting,Postponed;

            trigger OnValidate()
            begin
                if "Task Status" = "Task Status"::Completed then
                    Validate(Closed, true)
                else
                    Validate(Closed, false);
            end;
        }
        field(11; Priority; Option)
        {
            Caption = 'Priority';
            InitValue = Normal;
            OptionCaption = 'Low,Normal,High';
            OptionMembers = Low,Normal,High;
        }
        field(12; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(13; Closed; Boolean)
        {
            Caption = 'Closed';

            trigger OnValidate()
            begin
                if Closed then begin
                    "Date Closed" := Today;
                    "Task Status" := "Task Status"::Completed;
                end;
            end;
        }
        field(14; "Date Closed"; Date)
        {
            Caption = 'Date Closed';
            Editable = false;
        }
        field(15; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(17; Canceled; Boolean)
        {
            Caption = 'Canceled';

            trigger OnValidate()
            begin
                if Canceled and not Closed then
                    Validate(Closed, true);
                if (not Canceled) and Closed then
                    Validate(Closed, false);
            end;
        }
        field(19; "Assinged To"; Code[20])
        {
            Caption = 'Assinged To';
        }
        field(20; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(21; "End Date"; Date)
        {
            Caption = 'End Date';
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
        key(Key1; "Task No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin


        "User ID" := UserId;
        Date := Today;


        // Start 01. Ankesh
        if "Task No." = '' then begin
            TaskSetup.Get;
            TaskSetup.TestField(TaskSetup."Task No.");
            NoSeriesMgt.InitSeries(TaskSetup."Task No.", xRec."No. Series", 0D, "Task No.", "No. Series");
        end
        // Stop 01. Ankesh
    end;

    var
        Text006: Label 'The valid range of dates is from %1 to %2. Please enter a date within this range.';
        Task: Record Task;
        TaskSetup: Record "Education Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    [Scope('Internal')]
    procedure AssistEdit(OldTaskno: Record Task): Boolean
    begin
        // Start 03. Ankesh
        with Task do begin
            Task := Rec;
            TaskSetup.Get;
            TaskSetup.TestField(TaskSetup."Task No.");
            if NoSeriesMgt.SelectSeries(TaskSetup."Task No.", OldTaskno."No. Series", "No. Series") then begin
                TaskSetup.Get;
                TaskSetup.TestField(TaskSetup."Task No.");
                NoSeriesMgt.SetSeries("Task No.");
                Rec := Task;
                exit(true);
            end;
        end;
        // Stop 03. Ankesh
    end;
}

