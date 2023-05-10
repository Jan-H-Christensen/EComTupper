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
    actions
    {
        addlast(Functions)
        {
            action(WooCommerce)
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                Caption = 'WooCommerce upload';
                Image = UpdateShipment;
                ToolTip = 'Uploade current item to woocommerce';

                trigger OnAction()
                var
                    webout: Codeunit WebOut;
                begin
                    webout.NewItem(Rec."No.");
                end;
            }

            action("WooCommerce Update")
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                Caption = 'WooCommerce update';
                Image = UpdateShipment;
                ToolTip = 'Uploade current item stock to woocommerce';

                trigger OnAction()
                var
                    webout: Codeunit WebOut;
                begin
                    webout.ItenStock(rec."No.");
                end;
            }
        }
    }
}
