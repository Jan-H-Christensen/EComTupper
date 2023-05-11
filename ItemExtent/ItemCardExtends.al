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
                    webout.IteMStock(rec."No.");
                end;
            }

            action("Send Order Mail")
            {
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = Basic, Suite;
                Caption = 'Send Order Mail';
                Image = SendMail;
                ToolTip = 'Send a mail when a new order was placed';

                trigger OnAction()
                var
                    sendOrderMail: Codeunit 50135;
                    test: Code[20];
                begin
                    test := '';
                    sendOrderMail.NewOrderEmail(test);
                end;
            }
        }
    }
}
