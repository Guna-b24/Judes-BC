page 71025 "Student Card"
{
    PageType = Card;
    SourceTable = Student;
    ApplicationArea = All;
    Caption = 'Student Card';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Name 2"; Rec."Name 2") { ApplicationArea = All; }
                field("Academic Year"; Rec."Academic Year") { ApplicationArea = All; }
                field(Class; Rec.Class) { ApplicationArea = All; }
                field(Section; Rec.Section) { ApplicationArea = All; }
                field("Class Code"; Rec."Class Code") { ApplicationArea = All; }
                field("Student Status"; Rec."Student Status") { ApplicationArea = All; }
                field("New Student"; Rec."New Student") { ApplicationArea = All; }
                field("Date Joined"; Rec."Date Joined") { ApplicationArea = All; }
                field(Image; rec."Student Image") { ApplicationArea = all; }
            }

            group("Personal Details")
            {
                field(Gender; Rec.Gender) { ApplicationArea = All; }
                field("Date Of Birth"; Rec."Date Of Birth") { ApplicationArea = All; }
                field(Age; Rec.Age) { ApplicationArea = All; }
                field(Months; Rec.Months) { ApplicationArea = All; }
                field(Religion; Rec.Religion) { ApplicationArea = All; }
                field(Caste; Rec.Caste) { ApplicationArea = All; }
                field(Community; Rec.Community) { ApplicationArea = All; }
                field("Mother Tongue"; Rec."Mother Tongue") { ApplicationArea = All; }
                field("Blood Group"; Rec."Blood Group") { ApplicationArea = All; }
                field(Height; Rec.Height) { ApplicationArea = All; }
                field(Weight; Rec.Weight) { ApplicationArea = All; }
            }

            group("Parent Details")
            {
                field("Father's Name"; Rec."Father's Name") { ApplicationArea = All; }
                field("Father's Qualification"; Rec."Father's Qualification") { ApplicationArea = All; }
                field("Father's Occupation"; Rec."Father's Occupation") { ApplicationArea = All; }
                field("Father's Annual Income"; Rec."Father's Annual Income") { ApplicationArea = All; }

                field("Mother's Name"; Rec."Mother's Name") { ApplicationArea = All; }
                field("Mother's Qualification"; Rec."Mother's Qualification") { ApplicationArea = All; }
                field("Mother's Occupation"; Rec."Mother's Occupation") { ApplicationArea = All; }
                field("Mother's Annual Income"; Rec."Mother's Annual Income") { ApplicationArea = All; }

                field("Guardian Name"; Rec."Guardian Name") { ApplicationArea = All; }
                field("Guardian Qualification"; Rec."Guardian Qualification") { ApplicationArea = All; }
                field("Guardian Occupation"; Rec."Guardian Occupation") { ApplicationArea = All; }
                field("Guardian Annual Income"; Rec."Guardian Annual Income") { ApplicationArea = All; }
            }

            group(Address)
            {
                field(Addressee; Rec.Addressee) { ApplicationArea = All; }
                field(Address1; Rec.Address1) { ApplicationArea = All; }
                field(Address2; Rec.Address2) { ApplicationArea = All; }
                field("Address 3"; Rec."Address 3") { ApplicationArea = All; }
                field(City; Rec.City) { ApplicationArea = All; }
                field(State; Rec.State) { ApplicationArea = All; }
                field("Post Code"; Rec."Post Code") { ApplicationArea = All; }
                field(Country; Rec.Country) { ApplicationArea = All; }
                field("E-Mail Address"; Rec."E-Mail Address") { ApplicationArea = All; }
                field("Mobile Number"; Rec."Mobile Number") { ApplicationArea = All; }
                field("Phone Number"; Rec."Phone Number") { ApplicationArea = All; }
            }

            group("Academic Info")
            {
                field(Curriculum; Rec.Curriculum) { ApplicationArea = All; }
                field("Previous Class"; Rec."Previous Class") { ApplicationArea = All; }
                field("Previous Curriculum"; Rec."Previous Curriculum") { ApplicationArea = All; }
                field(CGPA; Rec.CGPA) { ApplicationArea = All; }
                field("Latest GPA"; Rec."Latest GPA") { ApplicationArea = All; }
                field("Latest Grade"; Rec."Latest Grade") { ApplicationArea = All; }
                field("Latest Rank"; Rec."Latest Rank") { ApplicationArea = All; }
                field(Points; Rec.Points) { ApplicationArea = All; }
                field("Academic Points"; Rec."Academic Points") { ApplicationArea = All; }
            }

            group("Hostel Details")
            {
                field("Hostel Acommodation"; Rec."Hostel Acommodation") { ApplicationArea = All; }
                field("Hostel Code"; Rec."Hostel Code") { ApplicationArea = All; }
                field("Room No."; Rec."Room No.") { ApplicationArea = All; }
                field("Room Type"; Rec."Room Type") { ApplicationArea = All; }
                field(Mess; Rec.Mess) { ApplicationArea = All; }
                field("Hostel Alloted"; Rec."Hostel Alloted") { ApplicationArea = All; }
                field("Hostel Vacated"; Rec."Hostel Vacated") { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Student)
            {
                Caption = 'Student';

                action(OptionalSubjects)
                {
                    Caption = 'Optional Subjects';
                    ApplicationArea = All;
                    Image = Item;

                    RunObject = page "Student Optional Subjects";
                    RunPageLink = "Student No" = field("No.");

                    ToolTip = 'Opens the optional subjects assigned to this student.';
                }

                // Subjects
                action(Subjects)
                {
                    Caption = 'Subjects';
                    ApplicationArea = All;
                    Image = Item;

                    RunObject = page "Student Subjects List";
                    RunPageLink = "Student No." = field("No.");

                    ToolTip = 'Opens the subjects assigned to this student.';
                }

                // Co-Curricular
                action(CoCurricular)
                {
                    Caption = 'Co-Curricular';
                    ApplicationArea = All;
                    Image = Activities;

                    RunObject = page "Application Co-Curricular List";
                    RunPageLink = "Student No." = field("No.");

                    ToolTip = 'Opens the co-curricular activities assigned to this student.';
                }

                // Marks
                action(Marks)
                {
                    Caption = 'Marks';
                    ApplicationArea = All;
                    Image = Statistics;

                    RunObject = page "Student Mark List";
                    RunPageLink = "Student No." = field("No.");

                    ToolTip = 'Opens the marks records for this student.';
                }
                action(UpdateStudentGrade)
                {
                    Caption = 'Update Student &Grade';
                    ApplicationArea = All;
                    Image = Calculate;
                    ToolTip = 'Calculates and updates the CGPA and Grade for the current student based on posted academic records.';

                    trigger OnAction()
                    begin
                        Academics.UpdateStudentCPGAGrade(Rec);
                        CurrPage.Update();
                    end;
                }

                action(ImportStudentImage)
                {
                    Caption = 'Import Student Image';
                    ApplicationArea = All;
                    Image = Import;
                    ToolTip = 'Imports an image for the current student.';

                    trigger OnAction()
                    begin
                        if Rec."Student Image".Count > 0 then
                            if not Confirm('The student already has an image. Do you want to replace it?') then
                                exit;

                        Clear(Rec."Student Image");
                        Rec.Modify(true);
                        CurrPage.Update();
                    end;
                }

                action(DeleteStudentImage)
                {
                    Caption = 'Delete Student Image';
                    ApplicationArea = All;
                    Image = Delete;
                    ToolTip = 'Deletes the image of the current student.';

                    trigger OnAction()
                    begin
                        if Rec."Student Image".Count = 0 then
                            exit;

                        if Confirm('Are you sure you want to delete the image?') then begin
                            Clear(Rec."Student Image");
                            Rec.Modify(true);
                            CurrPage.Update();
                        end;
                    end;
                }
            }
        }
    }
    VAR
        Academics: Codeunit Academics;
}