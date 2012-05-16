local Asserts = { currentTestCaseID = "Unnamed Test Case" };
local Results = {};


function Asserts:isUnequal(expect, actual)
    local r;
    if expect ~= actual then
        r = { success = true, message = "PASS:  " .. Asserts.currentTestCaseID };
    else
        expect = expect or 'nil';
        actual = actual or 'nil';
        r = { success = false, message = "FAIL: " .. Asserts.currentTestCaseID .. " Found " .. tostring(actual) .. " expected " .. tostring(expect) };
    end
    table.insert(Results, r);
end

function Asserts:isEqual(expect, actual)
    local r;
    if expect == actual then
        r = { success = true, message = "PASS:  " .. Asserts.currentTestCaseID };
    else
        expect = expect or 'nil';
        actual = actual or 'nil';
        r = { success = false, message = "FAIL: " .. Asserts.currentTestCaseID .. " Found " .. tostring(actual) .. " expected " .. tostring(expect) };
    end
    table.insert(Results, r);
end

function Asserts:numbFailingTests()
    local count = 0;
    for i = 1, #Results do
        if not Results[i].success then count = count + 1 end
    end
    return count
end

function Asserts:printSummary()
    local total = Asserts:totalTests();
    local failing = Asserts:numbFailingTests();
    local passing = total - failing
    print( "----------------------------------------------------------------" );
    print( "  failing = " .. failing.. "  passing = " .. passing .. "  total tests = " .. total );
    print( "----------------------------------------------------------------" );

end

function Asserts:printFailingTests()

    for i = 1, #Results do
        if not Results[i].success then print(Results[i].message) end
    end

end

function Asserts:totalTests()
    return #Results;
end

function Asserts:getResults()
    return Results;
end

return Asserts;