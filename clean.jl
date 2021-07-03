function rmr(path::String)
	ispath(path) ? (rm(path, recursive = true); 1) : 0
end

const list = [
	# dir
	"sources/iosevka-n-fixed-slab"
	"sources/iosevka-n-fixed"
	"sources/iosevka-n-slab"
	"sources/iosevka-n-term-slab"
	"sources/iosevka-n-term"
	"sources/iosevka-n"
	# file
	"sources/shs/SourceHanSansHC-Regular.otf"
	"sources/shs/SourceHanSansHW-Regular.otf"
	"sources/shs/SourceHanSansHWHC-Regular.otf"
	"sources/shs/SourceHanSansHWK-Regular.otf"
	"sources/shs/SourceHanSansHWSC-Regular.otf"
	"sources/shs/SourceHanSansHWTC-Regular.otf"
	"sources/shs/SourceHanSansK-Regular.otf"
]

try
	n = rmr.(list) |> sum
	@info "完成 > $n"
catch e
	@info "错误"
	@info e
end
print("> ")
readline()

