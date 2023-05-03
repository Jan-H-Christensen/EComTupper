// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50133 TestExt extends "Customer List"
{
    trigger OnOpenPage();
    var
        test: Record 21;
    begin
        Message('App published:');
    end;
}

