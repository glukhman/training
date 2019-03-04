cfy blu upload -b ex5 -n ex5.yaml ../ex5.zip
cfy dep create -b ex5 -i ../ex5-depvalues.yaml
cfy exec start install -d ex5
