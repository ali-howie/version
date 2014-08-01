local cjson = require("cjson")
local request_method = ngx.var.request_method
local args = nil
local latest_version = 10000
local client_id = 10000
local client_secret = "e5a7c3beffe6dea4105ff1c64c42089f"

if "GET"==request_method then
    args = ngx.req.get_uri_args()
else
    return "request method must be get"
end

local param_client_id = args["client_id"]
local param_client_secret = args["client_secret"]
local param_version_code = args["version_code"]

local response ={}
response["path"] = ngx.var.uri

if param_client_id~=nil and param_client_secret~=nil and param_version_code~=nil and tonumber(param_client_id)==client_id and param_client_secret==client_secret then
    if tonumber(param_version_code) < latest_version then
        response["latest_version"] = latest_version
        local zip = {}
        local f = io.open("html/res/monster.zip",'r')
        local str = f:read("*all") 
        f:close()
        zip["url"]= "http://localhost:8080/res/monster.zip"
        zip["md5"]= ngx.md5(str)

        response["download"] = {zip}
    else
        response["response"] = "no update"
    end
else
    response["error_code"] = "30102"
end
return cjson.encode(response)