mkdir docs
haxe build_xml.hxml
copy template.xml docs\template.xml
cd docs
haxedoc output.xml -f tweenx909
rm template.xml
rm output.xml
