for f in readdir()
	splitext(f)[2] == ".ttf" || continue
	mv(f, f * ".tmp", force = true)
	mv(f * ".tmp", f |> lowercase, force = true)
end

