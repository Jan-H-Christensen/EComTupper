pageextension 50134 ExtNavigation extends "Order Processor Role Center"
{
    actions
    {
        addlast(sections)
        {
            group("Tupperware")
            {
                action("Customer List")
                {
                    RunObject = page "Customer List";
                    ApplicationArea = All;
                }
                action("Item List")
                {
                    RunObject = page "Item List";
                    ApplicationArea = All;
                }
                action("Sales Order List")
                {
                    RunObject = page "Sales Order List";
                    ApplicationArea = All;
                }
                action("Chart")
                {
                    RunObject = page "Tupper Sales Charts";
                    ApplicationArea = All;
                }
                action("Stock")
                {
                    RunObject = page "Item Journal";
                    ApplicationArea = All;
                }
            }
        }
    }
}
