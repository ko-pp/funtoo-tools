#!/usr/bin/env python3

import portage


dbapi = portage.db[portage.root]["vartree"].dbapi
packages = dbapi.cp_all()
tree = [dbapi.match(package) for package in packages]
for package in tree:
    for version in package:
        inherited = dbapi.aux_get(version, ["INHERITED"])
        for inherit in inherited:
            if 'linux-info' in inherit:
                print('>={version}'.format(version=version))
