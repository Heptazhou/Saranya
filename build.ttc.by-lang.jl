function build(lang::String, args::String = "")
	args == "" || (args = "$args ")
	name = "saranya-" .* ["ui", "roman", "mono"]
	list = "-$lang-" .* ["regular", "regular-italic", "bold", "bold-italic"] .* ".ttf"
	list = vcat([s .* list for s in name]...)
	list = join(list, " ")
	cmd = "otf2otc $args-o ../ttc/saranya-$lang.ttc $list"
	cmd = :(@cmd $cmd) |> eval
	cmd |> println
	cmd |> run
	println()
end

try
	cwd = pwd()
	cd("dist/ttf")
	build("sc")
	build("tc")
	build("ja")
	cd(cwd)
	cd("dist/ttf-hinted")
	build("sc-h")
	build("tc-h")
	build("ja-h")
	@info "完成"
catch e
	@info "错误"
	@info e
end
isempty(ARGS) || exit()
print("> ")
readline()

