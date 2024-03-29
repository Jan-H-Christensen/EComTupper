table 50133 "Tupper Sales Table"
{
    Caption = 'Tupper Sales Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User ID"; Text[132])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }

        field(10; "Charts"; Option)
        {
            Caption = 'Charts type';
            DataClassification = ToBeClassified;
            OptionMembers = Point,,,Line,,StepLine,,,,,Column,,,,,"Area",,Pie,Doughnut;
            OptionCaption = 'Point,,,Line,,StepLine,,,,,Column,,,,,Area,,Pie,Doughnut';
        }

        field(20; "Show Profit or Sales"; Option)
        {
            Caption = 'Sales or Profit';
            OptionCaption = 'Product by sales, Product by Profit';
            OptionMembers = "Product by sales","Product by Profit";
        }
        field(30; "Start Date"; Date)
        {
            Caption = 'Start Date';

            trigger OnValidate()
            begin
                TestField("Start Date");
            end;
        }
        field(40; "End Date"; Date)
        {
            Caption = 'End Date';

            trigger OnValidate()
            begin
                TestField("End Date");
            end;
        }
    }


    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }
}