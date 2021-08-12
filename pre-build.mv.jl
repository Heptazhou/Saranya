function rename()
	ext = ".ttf"
	for f in readdir()
		splitext(f)[2] == ext || continue
		dst = replace(f, Regex("(?<=[a-z])-(?=italic\\$ext\$)", "i") => "")
		dst != f && mv(f, dst, force = true)
	end
end

try
	@info "正在重命名"
	cd(rename, "dist/ttf/")
	cd(rename, "dist/ttf-hinted/")
	@info "完成"
catch e
	@info "错误"
	@info e
end
print("> ")
readline()

