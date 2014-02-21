from lxml import etree

parser = etree.HTMLParser ()
tree = etree.parse ('../datos/2012-ugr.html', parser)

# Todos los enlaces
urls=tree.xpath("//text()")

for u in urls:
	print (u)