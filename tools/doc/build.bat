mkdir ..\..\haxedoc
haxe build_xml.hxml
copy template.xml ..\..\haxedoc\template.xml
cd ..\..\haxedoc
haxedoc output.xml -f tweenx909
rm template.xml
rm output.xml