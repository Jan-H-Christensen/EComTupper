page 50133 "Tupper Sales Charts"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Item;
    Caption = 'Tupper Sales Charts';
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;
                trigger AddInReady()
                var
                    buffer: Record "Business Chart Buffer";
                    item: Record Item;
                    i: Integer;
                begin
                    buffer.Initialize();
                    // index 0
                    buffer.AddMeasure('Qty', 1, buffer."Data Type"::Decimal, buffer."Chart Type"::Line);
                    buffer.SetXAxis('Description', buffer."Data Type"::String);

                    if item.FindFirst() then
                        repeat

                            if item."Unit Cost" <> 0 then begin
                                buffer.AddColumn(item.Description);
                                buffer.SetValueByIndex(0, i, item."Unit Cost"); // 0 based not 1 like normal in AL 
                                i += 1
                            end;
                        until item.Next() = 0;

                    buffer.Update(CurrPage.Chart);
                end;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        test: Record 27;
        testOrder: Record 37;
}