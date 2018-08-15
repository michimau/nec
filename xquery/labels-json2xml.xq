declare namespace mmr = "mmr-pams";

(:~
    Translates JSON labels to XML - Requires BaseX 8.6.1
    Some manual changes are also required.
:)
declare function mmr:json2xml($file as xs:string) {
    let $x := file:read-text($file)
    return json:parse($x, map {"format" : "direct", "merge": "yes", "escape": "yes", "lax": "yes"})
};


let $file := "file:///home/dev-gso/eea/Reportnet/Dataflows/MMR-PAMs/translations/mmr-pams-labels-en.json"
return mmr:json2xml($file)