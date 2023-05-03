table 50133 "Tupper Sales Table"
{
    DataClassification = ToBeClassified;
    Caption = 'Tupper Sales Table';

    fields
    {
        field(1; "Prod ID"; Integer)
        {
            Caption = 'Product ID';
            DataClassification = ToBeClassified;
        }

        field(10; "Charts"; Option)
        {
            Caption = 'Charts type';
            DataClassification = ToBeClassified;
            OptionMembers = Point,,Bubble,Line,,StepLine,,,,,StackedColumn,StackedColumn100,Area;
            OptionCaption = 'Point,, Bubble, Line,, StepLine,,,,, StackedColumn,StackedColumn100, Area';
        }


    }


    keys
    {
        key(Key1; "Prod ID")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}