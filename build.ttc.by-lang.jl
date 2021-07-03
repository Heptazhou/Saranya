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

function build(lang::String, args::String = "")
	args ≠ "" && (args *= " ")
	name = "saranya-" .* ["ui" "roman" "mono"]
	list = "-$lang-" .* ["regular", "regular-italic", "bold", "bold-italic"] .* ".ttf"
	list = join(name .* list, " ")
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

