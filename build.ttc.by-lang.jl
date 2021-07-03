function build(lang::String, args::String = "")
	args == "" || (args = "$args ")
	name = "saranya-" .* ["ui", "roman", "mono"]
	list = "-$lang-" .* ["regular", "regular-italic", "bold", "bold-italic"] .* ".ttf"
	list = vcat([s .* list for s in name]...)
	list = join(list, " ")
	cmd  = "otf2otc $args-o ../ttc/saranya-$lang.ttc $list"
	cmd  = @eval @cmd $cmd
	cmd |> println
	cmd |> run
	println()
end

try
	v = [
		"sc"
		"tc"
		"ja"
	]
	cd("dist/ttf") do
		build.(v)
	end
	cd("dist/ttf" * "-hinted") do
		build.(v .* "-h")
	end
	@info "完成"
catch e
	@info "错误"
	@info e
end
isempty(ARGS) || exit()
print("> ")
readline()

