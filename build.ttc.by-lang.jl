function build(lang::String, arg::String = "")
	arg == "" || (arg = "$arg ")
	name = ["saranya-mono", "saranya-term"]
	list = ["regular", "regular-italic", "bold", "bold-italic"]
	list = "-$lang-" .* list .* ".ttf"
	list = vcat([x .* list for x in name]...)
	list = join(list, " ")
	cmd = Cmd(`otf2otc $arg-o ../ttc/$name-$lang.ttc $list`, windows_verbatim = true)
	cmd |> println
	cmd |> run
	println()
end

try
	cd("dist/ttf")
	build("sc")
	build("tc")
	build("ja")
	@info "完成"
catch e
	@info "错误"
	@info e
end
print("> ")
readline()

