tableextension 50134 ItemExtent extends Item
{
    fields
    {
        field(50135; ItemDeskription; text[100])
        {
            Caption = 'Item Deskription';
            DataClassification = ToBeClassified;
        }
    }


    trigger OnAfterInsert()
    var
        WebOutCode: Codeunit WebOut;
    begin
        WebOutCode.NewItem("No.");
    end;

    trigger OnAfterModify()
    var
        WebOutCode: Codeunit WebOut;
    begin
        WebOutCode.ItenStock("No.");
    end;
}
