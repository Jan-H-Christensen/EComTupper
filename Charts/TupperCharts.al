page 50133 "Tupper Sales Charts"
{
    ApplicationArea = All;
    Caption = 'Tupper Sales Charts';
    PageType = Card;
    SourceTable = "Tupper Sales Table";

    layout
    {

        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Charts"; Rec.Charts)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateChart();
                    end;
                }

                field("Show Profit or Sales"; Rec."Show Profit or Sales")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateChart();
                    end;
                }

                field("Start Date"; rec."Start Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateChart();
                    end;
                }

                field("End Date"; rec."End Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        UpdateChart();
                    end;
                }
            }
            group(ChartToShow)
            {
                Caption = 'Item Chart';
                usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
                {
                    ApplicationArea = Basic, Suit;

                    trigger DataPointClicked(point: JsonObject)
                    var
                        JsonTokenItem: JsonToken;
                        JsonText: Text;
                    begin
                        if point.Get('XValueString', JsonTokenItem) then begin
                            JsonText := Format(JsonTokenItem);
                            JsonText := DelChr(JsonText, '=', '"');
                            ChartMgt.DrillDown(JsonText);
                        end;
                    end;

                    trigger AddInReady()
                    begin
                        UpdateChart();
                    end;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Setup Chart")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Caption = 'Setup';
                Image = ServiceOrderSetup;

                trigger OnAction()
                var
                    SearchCat: Record "Item Category";
                begin
                    SearchCat.Init();
                    SearchCat.Code := 'TUPPER';
                    SearchCat.Description := 'Tupperware';
                    SearchCat.Insert();
                end;
            }
        }
    }


    var
        buffer: Record "Business Chart Buffer";
        ChartMgt: Codeunit 50137;
        // test: Record 27;
        // testOrder: Record 37;
        // chart: Record 760;
        // charts: Record 770;
        // chartss: Record 1382;
        pageesss: Page "Sales Order";

    local procedure UpdateChart()
    begin
        ChartMgt.GenerateData(buffer, Rec);
        buffer.Update(CurrPage.Chart);
    end;
}