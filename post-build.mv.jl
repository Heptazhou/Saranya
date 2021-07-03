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

function rename()
	ext = ".ttf"
	for f in readdir()
		splitext(f)[2] ≠ ext && continue
		dst = replace(f, Regex("(?<=[a-z])(?=italic\\$ext\$)", "i") => "-")
		dst ≠ f && mv(f, dst, force = true)
	end
end

try
	@info "正在重命名"
	cd(rename, "dist/ttf/")
	cd(rename, "dist/ttf-hinted/")
	@info "完成"
catch e
	@info "错误"
	@info e
end
isempty(ARGS) || exit()
print("> ")
readline()

