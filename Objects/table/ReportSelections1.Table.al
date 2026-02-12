table 71899 "Report Selections1"
{
    Caption = 'Report Selections';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Usage; Option)
        {
            Caption = 'Usage';
            OptionCaption = 'Application fee Receipt,Application,Receipt of Application,Call Letter,Transfer Certificatte,BankChallan,Admission Form';
            OptionMembers = "Application fee Receipt",Application,"Receipt of Application","Call Letter","Transfer Certificatte",BankChallan,"Admission Form";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the usage type for the report.';
        }

        field(2; Sequence; Code[20])
        {
            Caption = 'Sequence';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the sequence number of the report.';
        }
        field(3; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the ID of the report to be used.';
            // TableRelation = Object.ID where (Type = const (Report));
            TableRelation = AllObj."Object ID" where("Object Type" = const(Report));


            trigger OnValidate()
            begin
                CalcFields("Report Name");
            end;
        }
        field(4; "Report Name"; Text[300])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Report ID")));
            Caption = 'Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Usage)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ReportSelection2: Record "Report Selections";

    procedure NewRecord()
    begin
        ReportSelection2.SetRange(Usage, Usage);
        if ReportSelection2.FindLast() and (ReportSelection2.Sequence <> '') then
            Sequence := IncStr(ReportSelection2.Sequence)
        else
            Sequence := '1';
    end;
}

