page 71002 "Enquiry List"
{
    PageType = List;
    SourceTable = Enquiry;
    ApplicationArea = All;
    Caption = 'Enquiry List';
    Editable = true;
    UsageCategory = Lists;
    CardPageId = "Enquiry Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the unique number for the enquiry.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;

                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the student for the enquiry.';
                }
                field("Enquiry Date"; Rec."Enquiry Date")
                {
                    ToolTip = 'Specifies the date when the enquiry was created.';
                }
                field("Class Applied"; Rec."Class Applied")
                {
                    ToolTip = 'Specifies the class the student is applying for.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ToolTip = 'Specifies the academic year for which the enquiry is made.';
                }
                field("Enquiry Gender"; Rec."Enquiry Gender")
                {
                    ToolTip = 'Specifies the gender of the student.';
                }
                field("Enquirer Name"; Rec."Enquirer Name")
                {
                    ToolTip = 'Specifies the name of the person who made the enquiry.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the city of the student or enquirer.';
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ToolTip = 'Specifies the contact mobile number for the enquiry.';
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ToolTip = 'Specifies the email address for communication.';
                }
                field("Enquiry Closed"; Rec."Enquiry Closed")
                {
                    ToolTip = 'Specifies whether the enquiry has been closed.';
                }
            }
        }
    }

    actions
    {
        area(Navigation) { }
    }
}