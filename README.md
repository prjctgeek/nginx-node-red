# Nginx node-red

## Synopsis

[Node-red](https://nodered.org/) has some interesting use cases; however it lacks some basic controls and protections needed to expose it to the Interet at large.  This project demonstrates a possible production deployable node-red instance. 

## Code Example

As an example, if you build and launch this container on a host exposed to the Internet at large, the flow will only accept web requiests from RFC1918 address space (and are rate limited), e.g.:

```curl -d test http://localhost/webhook/postWithHeaders```

The flow editor and dashboard are also password protected using nginx, allowing you to provide a password file or extend the authentication outside of node-red.


## Installation

You'll need Docker and gnu make.

```
make build run
```

Point your brower at [http://localhost/admin/](http://localhost/admin/) with the username/password of admin/deadb33f .

The sample dashboard is at [http://localhost/ui/](http://localhost/ui/) .

## Included Sample node-red flow

The purpose was only to demonstrate that the nginx restrictions are working, including the dashboard.

```
[{"id":"321b6c92.6b76d4","type":"tab","label":"Demonstration http listener"},{"id":"29499621.5a690a","type":"tab","label":"Dashboard Sample"},{"id":"1fdae066.87dc8","type":"ui_group","z":"","name":"Default","tab":"","disp":true,"width":"6"},{"id":"176474c5.430c5b","type":"ui_base","name":"test","theme":"theme-light"},{"id":"846c6065.93584","type":"ui_link","z":"","name":"test","link":"https://www.google.com/","icon":"open_in_browser","target":"newtab","order":2},{"id":"ee4f6b9d.154d48","type":"ui_link","icon":"open_in_browser","target":"newtab","order":1},{"id":"5abf0a53.543f24","type":"ui_group","z":"","name":"Random Values","tab":"e5c5a838.d5f488","order":null,"disp":true,"width":"9"},{"id":"e5c5a838.d5f488","type":"ui_tab","z":"","name":"Home","icon":"dashboard"},{"id":"8846087f.220ba8","type":"http in","z":"321b6c92.6b76d4","name":"","url":"/postWithHeaders","method":"post","swaggerDoc":"","x":125,"y":94,"wires":[["56977bae.6d3d94","4431a259.767fec"]]},{"id":"4431a259.767fec","type":"http response","z":"321b6c92.6b76d4","name":"","x":371,"y":78,"wires":[]},{"id":"56977bae.6d3d94","type":"debug","z":"321b6c92.6b76d4","name":"","active":true,"console":"false","complete":"true","x":365,"y":191,"wires":[]},{"id":"98cd05e4.cdbb28","type":"inject","z":"29499621.5a690a","name":"","topic":"","payload":"","payloadType":"date","repeat":"5","crontab":"","once":false,"x":136,"y":97,"wires":[["c715bb30.f75678"]]},{"id":"c715bb30.f75678","type":"function","z":"29499621.5a690a","name":"rand","func":"msg.payload = Math.round(Math.random()*Math.random()*1000);\nreturn msg","outputs":1,"noerr":0,"x":301,"y":98,"wires":[["c71178f9.110f48","29a61465.2a061c","41770bac.92ca54"]]},{"id":"c71178f9.110f48","type":"ui_chart","z":"29499621.5a690a","name":"","group":"5abf0a53.543f24","order":0,"width":"0","height":"0","label":"chart","chartType":"line","legend":"false","xformat":"%H:%M:%S","interpolate":"linear","nodata":"","ymin":"","ymax":"","removeOlder":1,"removeOlderUnit":"3600","x":449,"y":97,"wires":[[],[]]},{"id":"4faad667.23d268","type":"comment","z":"321b6c92.6b76d4","name":"Sample curl","info":"This flow shows how with the nginx wrapper,\nyou can have simple auth endpoints.\n\nWith the default password file in place, use this curl command\non the host running the node-red-auth docker container:\n\n    curl -d test http://localhost/webhook/postWithHeaders","x":94,"y":156,"wires":[]},{"id":"29a61465.2a061c","type":"ui_gauge","z":"29499621.5a690a","name":"","group":"5abf0a53.543f24","order":0,"width":0,"height":0,"gtype":"gage","title":"Gauge","label":"units","format":"{{value}}","min":0,"max":"1000","colors":["#00b500","#e6e600","#ca3838"],"x":454,"y":147,"wires":[]},{"id":"41770bac.92ca54","type":"ui_text","z":"29499621.5a690a","group":"5abf0a53.543f24","order":0,"width":0,"height":0,"name":"","label":"Last data value","format":"{{msg.payload}}","layout":"row-spread","x":496,"y":220,"wires":[]}]
```


## Tests

WIP, mostly I've used this curl for loop to show rate limiting:

```
for i in {1..10}; do echo $i;curl -d test http://localhost/webhook/postWithHeaders;done
```
