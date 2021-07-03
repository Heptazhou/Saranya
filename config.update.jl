const src = "config.jsonc"
const dst = "config.json"

try
	@info "正在更新配置文件"
	json = read(src, String)
	json = replace(json, r"^\s*//.*\n"m => "")
	write(dst, json)
	@info "完成"
catch e
	@info "错误"
	@info e
end
length(ARGS) > 0 && exit()
print("> ")
readline()

