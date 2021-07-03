function build(lang::String, arg::String = "")
	arg == "" || (arg = "$arg ")
	name = "saranya"
	list = ["regular", "regular-italic", "bold", "bold-italic"]
	input = join("$name-$lang-" .* list .* ".ttf", " ")
	cmd = Cmd(`otf2otc $arg-o ../ttc/$name-$lang.ttc $input`, windows_verbatim = true)
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

