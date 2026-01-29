page 50100 "SJPS Fee Structure"
{
    ApplicationArea = All;
    Caption = 'Fee Structure';
    PageType = List;
    SourceTable = "Fee Structure";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("From Class"; Rec."From Class")
                {
                    ToolTip = 'Specifies the value of the From Class field.', Comment = '%';
                }
                field("To Class"; Rec."To Class")
                {
                    ToolTip = 'Specifies the value of the To Class field.', Comment = '%';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the value of the Academic Year field.', Comment = '%';
                }
                field("Type Of Fees"; Rec."Type Of Fees")
                {
                    ToolTip = 'Specifies the value of the Type Of Fees field.', Comment = '%';
                }
                field("Fee Code"; Rec."Fee Code")
                {
                    ToolTip = 'Specifies the value of the Fee Code field.', Comment = '%';
                }
                field("Fee Description"; Rec."Fee Description")
                {
                    ToolTip = 'Specifies the value of the Fee Description field.', Comment = '%';
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ToolTip = 'Specifies the value of the G/L Account field.', Comment = '%';
                }
                field(Company; Rec.Company)
                {
                    ToolTip = 'Specifies the value of the Company field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Caution Depoit Select"; Rec."Caution Depoit Select")
                {
                    ToolTip = 'Specifies the value of the Caution Depoit Select field.', Comment = '%';
                }
                field(Group; Rec."Group")
                {
                    ToolTip = 'Specifies the value of the Group field.', Comment = '%';
                }
                field("Group Subject"; Rec."Group Subject")
                {
                    ToolTip = 'Specifies the value of the Group Subject field.', Comment = '%';
                }
                field("Staff Child"; Rec."Staff Child")
                {
                    ToolTip = 'Specifies the value of the Staff Child field.', Comment = '%';
                }
                field(Thai; Rec.Thai)
                {
                    ToolTip = 'Specifies the value of the Thai field.', Comment = '%';
                }
            }
        }
    }
}
