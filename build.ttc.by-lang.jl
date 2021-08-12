function buildU(lang::String, arg::String = "")
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
function buildH(lang::String, arg::String = "")
	arg == "" || (arg = "$arg ")
	name = "saranya-" .* ["mono", "term"]
	list = "-$lang-h-" .* ["regular", "regular-italic", "bold", "bold-italic"] .* ".ttf"
	list = vcat([s .* list for s in name]...)
	list = join(list, " ")
	cmd = Cmd(`otf2otc $arg-o ../ttc/saranya-$lang-h.ttc $list`, windows_verbatim = true)
	cmd |> println
	cmd |> run
	println()
end

try
	root = pwd()
	cd("dist/ttf")
	buildU("sc")
	buildU("tc")
	buildU("ja")
	cd(root)
	cd("dist/ttf-hinted")
	buildH("sc")
	buildH("tc")
	buildH("ja")
	@info "完成"
catch e
	@info "错误"
	@info e
end
print("> ")
readline()

