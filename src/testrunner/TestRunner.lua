local TestRunner = { print = print, results = {}, cases = {} };
local runner_mt = { __index = TestRunner };
local Asserts
function TestRunner:new(asserts)
    Asserts = asserts ;
    local newTestRunner = {};
    return setmetatable(newTestRunner, runner_mt);
end



function TestRunner:runAll()

    self.print('Running tests...');

    for name, testCase in pairs(TestRunner.cases) do
        self:runTestCase(testCase);
    end

    return Asserts.getResults();
end

function TestRunner:runTestCase(testCase)

    for name, func in pairs(testCase) do
        Asserts.currentTestCaseID = testCase.id;
        if (type( func ) == "function" and name ~= "setUp"and name ~= "new" and name ~= "tearDown") then
            local newTestCase = testCase:new(Asserts);
            if (newTestCase.setUp ~= nil) then newTestCase:setUp() end;
            newTestCase[name]();
            if (testCase.tearDown ~= nil) then testCase:tearDown() end;
        end
    end
end

function TestRunner:add(testCase)
    table.insert(TestRunner.cases, testCase);
end

local function logResult(event)
    table.insert(TestRunner.results, event)
end

return TestRunner;

