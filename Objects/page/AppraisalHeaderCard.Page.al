page 70033 "Appraisal Header Card"
{
    PageType = Document;
    SourceTable = "Appraisal Header";
    ApplicationArea = All;
    Caption = 'Appraisal Card';
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("App No."; Rec."App No.")
                {
                    ApplicationArea = All;
                    //AssistEdit = true;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;

                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Review Type"; Rec."Review Type")
                {
                    ApplicationArea = All;
                }
                field("Review Status"; Rec."Review Status")
                {
                    ApplicationArea = All;
                }
            }

            group("Employment Details")
            {
                field("Designation Code"; Rec."Designation Code")
                {
                    ApplicationArea = All;
                }
                field("Designation Description"; Rec."Designation Description")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Department Description"; Rec."Department Description")
                {
                    ApplicationArea = All;
                }
            }

            group("Expected CTC")
            {
                field("Expected in"; Rec."Expected in")
                {
                    ApplicationArea = All;
                }
                field(ExpectedCTCAmount; Rec."Expected CTC")
                {
                    ApplicationArea = All;
                }
                field("Expected CTC %"; Rec."Expected CTC %")
                {
                    ApplicationArea = All;
                }
            }

            group(Additional)
            {
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Appraisal Level upto"; Rec."Appraisal Level upto")
                {
                    ApplicationArea = All;
                }
                field(Post; Rec.Post)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
            part(AppraisalLines; "Appraisal Line SubPage")
            {
                ApplicationArea = All;
                SubPageLink = "App No." = field("App No."),
                  "Employee No" = field("Employee No");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Pay Elements")
            {
                ApplicationArea = All;
                Caption = 'Pay Elements';
                Image = List;
                ToolTip = 'View and manage the pay elements for the selected employee.';
                RunObject = Page "Employee Pay Elements List";
                RunPageLink = "Employee No" = field("Employee No");
            }
        }
    }
}
