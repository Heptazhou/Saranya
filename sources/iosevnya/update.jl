const dst = "."
const src = "../../../Iosevnya/dist/iosevnya/ttf"
const list = [
	# "thin"
	# "thin-italic"
	# "extralight"
	# "extralight-italic"
	# "light"
	# "light-italic"
	"regular"
	"regular-italic"
	# "medium"
	# "medium-italic"
	# "semibold"
	# "semibold-italic"
	"bold"
	"bold-italic"
	# "extrabold"
	# "extrabold-italic"
	# "black"
	# "black-italic"
]

try
	n = 0
	for f in "iosevnya-" .* list .* ".ttf"
		cp(joinpath(src, f), joinpath(dst, f), force = true)
		n += 1
	end
	@info "完成 > $n"
catch e
	@info "错误"
	@info e
end
length(ARGS) > 0 && exit()
print("> ")
readline()

