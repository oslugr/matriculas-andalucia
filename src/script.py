from lxml import etree

parser = etree.HTMLParser ()
tree = etree.parse ('../datos/2012-ugr.html', parser)

# Todos los enlaces

tree=tree.xpath("//body")


for u in tree:
	print (u)