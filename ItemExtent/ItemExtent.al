tableextension 50134 ItemExtent extends Item
{
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
