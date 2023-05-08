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
            OptionMembers = Point,,Bubble,Line,,StepLine,,,,,StackedColumn,StackedColumn100,Area,Column;
            OptionCaption = 'Point,, Bubble, Line,, StepLine,,,,, StackedColumn,StackedColumn100, Area,Column';
        }

        field(20; "Show Profit or Sales"; Option)
        {
            Caption = 'Sales or Profit';
            OptionCaption = 'Product by sales, Product by Profit';
            OptionMembers = "Product by sales","Product by Profit";
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