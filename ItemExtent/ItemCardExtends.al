pageextension 50135 ItemCardExtends extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field(ItemDeskription; Rec.ItemDeskription)
            {
                Caption = 'Item Deskription';
                MultiLine = true;
                Width = 200;
            }
        }
    }
}
