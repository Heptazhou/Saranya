function rmr(path::String)
	ispath(path) ? (rm(path, recursive = true); 1) : 0
end

const list = [
	# dir
	# "sources/iosevka-n-fixed-slab"
	# "sources/iosevka-n-fixed"
	# "sources/iosevka-n-slab"
	# "sources/iosevka-n-term-slab"
	# "sources/iosevka-n-term"
	# "sources/iosevka-n"
	# file
	"sources/shs/SourceHanSansHC-Bold.otf"
	"sources/shs/SourceHanSansHC-Regular.otf"
	"sources/shs/SourceHanSansHW-Bold.otf"
	"sources/shs/SourceHanSansHW-Regular.otf"
	"sources/shs/SourceHanSansHWHC-Bold.otf"
	"sources/shs/SourceHanSansHWHC-Regular.otf"
	"sources/shs/SourceHanSansHWK-Bold.otf"
	"sources/shs/SourceHanSansHWK-Regular.otf"
	"sources/shs/SourceHanSansHWSC-Bold.otf"
	"sources/shs/SourceHanSansHWSC-Regular.otf"
	"sources/shs/SourceHanSansHWTC-Bold.otf"
	"sources/shs/SourceHanSansHWTC-Regular.otf"
	"sources/shs/SourceHanSansK-Bold.otf"
	"sources/shs/SourceHanSansK-Regular.otf"
]

try
	@info "正在清理"
	n = rmr.(list) |> sum
	@info "完成 > $n"
catch e
	@info "错误"
	@info e
end
print("> ")
readline()

