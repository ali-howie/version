local request_method = ngx.var.request_method
local args = nil

if "GET"==request_method then
    args = ngx.req.get_uri_args()
elseif "POST"==request_method then
end
return args["param"] or 'no param'
