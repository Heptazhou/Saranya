# Copyright (C) 2021-2022 Heptazhou <zhou@0h7z.com>
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
	for f in list .* ".ttf"
		cp(joinpath(src, "iosevnya-$f"), joinpath(dst, "iosevnya-fixed-$f"), force = true)
		n += 1
	end
	@info "完成 > $n"
catch e
	@info "错误"
	@info e
end
isempty(ARGS) || exit()
print("> ")
readline()

