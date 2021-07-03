function rmr(path::String)
	ispath(path) ? (rm(path, recursive = true); 1) : 0
end
function rmr(path::Vector{String})
	sum(rmr.(path))
end

const list = [
	# dir
	# "iosevka-n-fixed-slab"
	# "iosevka-n-fixed"
	# "iosevka-n-slab"
	# "iosevka-n-term-slab"
	# "iosevka-n-term"
	# "iosevka-n"
	# file
	"shs/SourceHanSans-Bold.otf"
	"shs/SourceHanSans-Regular.otf"
	"shs/SourceHanSansHC-Bold.otf"
	"shs/SourceHanSansHC-Regular.otf"
	"shs/SourceHanSansHW-Bold.otf"
	"shs/SourceHanSansHW-Regular.otf"
	"shs/SourceHanSansHWHC-Bold.otf"
	"shs/SourceHanSansHWHC-Regular.otf"
	"shs/SourceHanSansHWK-Bold.otf"
	"shs/SourceHanSansHWK-Regular.otf"
	"shs/SourceHanSansHWSC-Bold.otf"
	"shs/SourceHanSansHWSC-Regular.otf"
	"shs/SourceHanSansHWTC-Bold.otf"
	"shs/SourceHanSansHWTC-Regular.otf"
	"shs/SourceHanSansK-Bold.otf"
	"shs/SourceHanSansK-Regular.otf"
	"shs/SourceHanSansSC-Bold.otf"
	"shs/SourceHanSansSC-Regular.otf"
	"shs/SourceHanSansTC-Bold.otf"
	"shs/SourceHanSansTC-Regular.otf"
]

try
	@info "正在清理"
	n = 0
	for dir in [".build/", "sources/"]
		n += rmr(dir .* list)
	end
	@info "完成 > $n"
catch e
	@info "错误"
	@info e
end
isempty(ARGS) || exit()
print("> ")
readline()

