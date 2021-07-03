const src = "config.jsonc"
const dst = "config.json"

try
	json = read(src, String)
	json = replace(json, r"^\t*//.*\n"m => "")
	write(dst, json)
	@info "完成"
catch e
	@info "错误"
	@info e
end
print("> ")
readline()

