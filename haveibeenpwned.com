for x in {a..z}; do ldapsearch -z 0 -h some_dc.local -x -b "DC=some_domain,DC=com" -D "CN=someUser,CN=users,DC=some_domain,DC=com" -w "Some_Password' "(&(objectclass=Person)(mail=*)(cn=$x*))" cn mail; done | egrep "^mail" | cut -d' ' -f2 | while read email; do wget "https://haveibeenpwned.com/api/v2/breachedaccount/$email"; done
