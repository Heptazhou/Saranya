# Copyright (C) 2021-2023 Heptazhou <zhou@0h7z.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

function rmr(path::String)
	ispath(path) ? (rm(path, recursive = true); 1) : 0
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
	n = rmr.([".build/" "sources/"] .* list) |> sum
	@info "完成 > $n"
catch e
	@info "错误"
	@info e
end
isempty(ARGS) || exit()
print("> ")
readline()

