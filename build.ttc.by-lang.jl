function build(lang::String, arg::String = "")
	arg == "" || (arg = "$arg ")
	name = "saranya-" .* ["mono", "term"]
	list = "-$lang-" .* ["regular", "regular-italic", "bold", "bold-italic"] .* ".ttf"
	list = vcat([s .* list for s in name]...)
	list = join(list, " ")
	cmd = Cmd(`otf2otc $arg-o ../ttc/saranya-$lang.ttc $list`, windows_verbatim = true)
	cmd |> println
	cmd |> run
	println()
end

try
	root = pwd()
	cd("dist/ttf")
	build("sc")
	build("tc")
	build("ja")
	cd(root)
	cd("dist/ttf-hinted")
	build("sc-h")
	build("tc-h")
	build("ja-h")
	@info "完成"
catch e
	@info "错误"
	@info e
end
length(ARGS) > 0 && exit()
print("> ")
readline()

