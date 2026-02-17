tableextension 71000 "Application Ext" extends "Application"
{
    fields
    {
        field(71000; "Free Prospectus"; Boolean)
        {
            Caption = 'Free Prospectus';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the prospectus is provided free of cost for this application.';
        }
    }
}
