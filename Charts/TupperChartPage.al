page 50134 "Tupper Sales Chart"
{
    Caption = 'Tupper Sales Chart';
    PageType = Card;
    SourceTable = "Business Chart Buffer";

    layout
    {
        area(Content)
        {
            usercontrol(TupperCharts; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;

                trigger AddInReady()
                begin
                    UpdateChart();
                end;

                trigger Refresh()
                begin
                    UpdateChart();
                end;

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("chart setup")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Caption = 'Chart setup';
                Image = Setup;

                trigger OnAction()
                begin
                    Page.RunModal(Page::"Tupper Sales Charts");
                    UpdateChart();
                end;
            }
        }
    }
    var
        ChartMgt: Codeunit 50137;
        buffer: Record "Business Chart Buffer";

    local procedure UpdateChart()
    begin
        //ChartMgt.GenerateData(Rec);
        buffer.Update(CurrPage.TupperCharts);
    end;
}