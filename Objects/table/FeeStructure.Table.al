table 50010 "Fee Structure"
{
    Caption = 'Fee Structure';
    DataPerCompany = false;
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year for which the fee structure applies.';
        }

        field(2; "From Class"; Integer)
        {
            Caption = 'From Class';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the starting class for this fee structure.';
        }

        field(3; "To Class"; Integer)
        {
            Caption = 'To Class';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the ending class for this fee structure.';
        }
        field(4; "Fee Code"; Code[20])
        {
            TableRelation = "Fee Components";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the academic year for which the fee structure applies.';

            trigger OnValidate()
            begin
                if FeeComponent.Get("Fee Code") then begin
                    "Fee Description" := FeeComponent.Description;
                    "G/L Account" := FeeComponent."G/L Account";
                end;
            end;
        }
        field(5; "Fee Description"; Text[30])
        {
            Caption = 'Fee Description';
            DataClassification = CustomerContent;
            ToolTip = 'Description of the selected fee component.';
        }

        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = true;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fee amount.';
        }
        field(7; "Type Of Fees"; Option)
        {
            Caption = 'Type Of Fees';
            OptionCaption = ' ,Initial,Term1,Term2';
            OptionMembers = " ",Initial,Term1,Term2;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the fee type such as Initial or Term fees.';
        }

        field(8; Company; Code[30])
        {
            Caption = 'Company';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the company to which this fee structure applies.';
        }
        field(9; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the G/L account associated with this fee.';
        }

        field(10; Thai; Boolean)
        {
            Caption = 'Thai';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the fee is applicable for Thai category.';
        }

        field(11; Group; Option)
        {
            Caption = 'Group';
            OptionCaption = ' ,Group A,Group B,Group C,Group D,Group E,Group F';
            OptionMembers = " ","Group A","Group B","Group C","Group D","Group E","Group F";
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the student group.';
        }

        field(12; "Staff Child"; Boolean)
        {
            Caption = 'Staff Child';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the fee applies to staff children.';
        }

        field(13; "Group Subject"; Code[20])
        {
            Caption = 'Group Subject';
            TableRelation = Subject;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the subject group.';
        }

        field(14; "Caution Depoit Select"; Boolean)
        {
            Caption = 'Caution Deposit Select';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the fee includes a caution deposit.';
        }
    }

    keys
    {
        key(Key1; "Academic Year", "From Class", "To Class", "Fee Code", Company, "Type Of Fees")
        {
            Clustered = true;
        }
        key(Key2; "Fee Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FeeComponent: Record "Fee Components";
}

