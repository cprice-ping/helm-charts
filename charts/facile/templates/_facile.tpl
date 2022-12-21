{{/* Used to put the right TLD on the P1 URLs based on the Region */}}
{{- define "facile.pingOneTld" -}}
    {{ if .Values.pingOne.usePingOneServices }}
        {{- if eq ( default "NA" .Values.pingOne.envRegion ) "EU" }}
            {{- print "eu" }}
        {{- else if eq ( default "NA" .Values.pingOne.envRegion ) "ASIA" }}
            {{- print "asia" }}
        {{- else if eq ( default "NA" .Values.pingOne.envRegion ) "CA" }}
            {{- print "ca" }}
        {{- else }}
            {{- print "com" }}
        {{- end}}
    {{- end }}
{{- end }}

{{/* Used to put the right TLD on the P1 URLs based on the Region */}}
{{- define "facile.pingOneRegion" -}}
    {{ if .Values.pingOne.usePingOneServices }}
        {{- if eq ( default "NA" .Values.pingOne.envRegion ) "EU" }}
            {{- print "eu" }}
        {{- else if eq ( default "NA" .Values.pingOne.envRegion ) "ASIA" }}
            {{- print "ap" }}
        {{- else if eq ( default "NA" .Values.pingOne.envRegion ) "CA" }}
            {{- print "ca" }}
        {{- else }}
            {{- print "na" }}
        {{- end}}
    {{- end }}
{{- end }}

{{/* Used to create the Admin Console Client URLs used in Software */}}
{{- define "facile.pingOneAdminUrl" }}
    {{- print "https://auth.pingone." }}{{ include "facile.pingOneTld" . }}{{ print "/" .Values.pingOne.administration.envId "/as" }}
{{- end }}

{{/* Helper for the Ingress Hostname */}}
{{- define "facile.hostname" -}}
        {{- .Release.Name }}{{- print "." }}{{ default "ping-devops.com" .Values.global.envs.DOMAIN_NAME }}
{{- end }}

{{- define "facile.pfAdminServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingfederate-admin" ) .Values.global)) }}
{{- end }}

{{- define "facile.pfEngineServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingfederate-engine" ) .Values.global)) }}
{{- end }}

{{- define "facile.pdAdminServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingdirectory" ) .Values.global)) }}
{{- end }}

{{- define "facile.pdsAdminServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingdatasync" ) .Values.global)) }}
{{- end }}

{{- define "facile.delegatorServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingdelegator" ) .Values.global)) }}
{{- end }}

{{- define "facile.paAdminServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingaccess-admin" ) .Values.global)) }}
{{- end }}

{{- define "facile.paEngineServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingaccess-engine" ) .Values.global)) }}
{{- end }}

{{- define "facile.pazAdminServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingauthorize" ) .Values.global)) }}
{{- end }}

{{- define "facile.papServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingauthorizepap" ) .Values.global)) }}
{{- end }}

{{- define "facile.pcAdminServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingcentral" ) .Values.global)) }}
{{- end }}

{{- define "facile.pfAdminHostname" -}}
    {{ if eq .Values.global.ingress.addReleaseNameToHost "append" }}
        {{- print "pingfederate-admin-" .Release.Name "." .Values.global.ingress.defaultDomain }}
    {{- else if eq .Values.global.ingress.addReleaseNameToHost "prepend" -}}
        {{- print .Release.Name "-" "pingfederate-admin." .Values.global.ingress.defaultDomain }}
    {{- else -}}
        {{- print "pingfederate-admin." .Values.global.ingress.defaultDomain }}
    {{- end -}}
{{- end -}}

{{- define "facile.pdAdminHostname" -}}
    {{ if eq .Values.global.ingress.addReleaseNameToHost "append" }}
        {{- print "pingdataconsole-" .Release.Name "." .Values.global.ingress.defaultDomain }}
    {{- else if eq .Values.global.ingress.addReleaseNameToHost "prepend" -}}
        {{- print .Release.Name "-" "pingdataconsole." .Values.global.ingress.defaultDomain }}
    {{- else -}}
        {{- print "pingdataconsole." .Values.global.ingress.defaultDomain }}
    {{- end -}}
{{- end -}}

{{- define "facile.paAdminHostname" -}}
    {{ if eq .Values.global.ingress.addReleaseNameToHost "append" }}
        {{- print "pingaccess-admin-" .Release.Name "." .Values.global.ingress.defaultDomain }}
    {{- else if eq .Values.global.ingress.addReleaseNameToHost "prepend" -}}
        {{- print .Release.Name "-" "pingaccess-admin." .Values.global.ingress.defaultDomain }}
    {{- else -}}
        {{- print "pingaccess-admin." .Values.global.ingress.defaultDomain }}
    {{- end -}}
{{- end -}}

{{- define "facile.pazAdminHostname" -}}
    {{ if eq .Values.global.ingress.addReleaseNameToHost "append" }}
        {{- print "pingauthorizepap-" .Release.Name "." .Values.global.ingress.defaultDomain }}
    {{- else if eq .Values.global.ingress.addReleaseNameToHost "prepend" -}}
        {{- print .Release.Name "-" "pingauthorizepap." .Values.global.ingress.defaultDomain }}
    {{- else -}}
        {{- print "pingauthorizepap." .Values.global.ingress.defaultDomain }}
    {{- end -}}
{{- end -}}

{{- define "facile.pcAdminHostname" -}}
    {{ if eq .Values.global.ingress.addReleaseNameToHost "append" }}
        {{- print "pingcentral-" .Release.Name "." .Values.global.ingress.defaultDomain }}
    {{- else if eq .Values.global.ingress.addReleaseNameToHost "prepend" -}}
        {{- print .Release.Name "-" "pingcentral." .Values.global.ingress.defaultDomain }}
    {{- else -}}
        {{- print "pingcentral." .Values.global.ingress.defaultDomain }}
    {{- end -}}
{{- end -}}

{{/* Playing with Lookups */}}
{{- define "facile.pfAdminHostnameLookup" -}}
    {{ range $index, $val := ((lookup "extensions/v1beta1" "Ingress" .Release.Namespace ( include "facile.pfAdminServiceName" . )).spec.rules) }}
            {{- print $val.host }}
    {{- end -}}
{{- end -}} {{/* */}}

{{/* Playing with Merges for PingOne --> Postman URLs */}}
{{- define "facile.addPingOneConfigs" -}}
        {{- $merged := merge .Values.pingOne.services.licensed .Values.collections.useCases.pingOneServices -}}
        {{- range $index, $val := $merged -}}
            {{- if $val.enabled -}}
                {{ print "," $val.url }}
            {{- end -}}
        {{- end -}}
        {{ print "," .Values.collections.useCases.pingOneServices.pf.url }}
{{- end -}}

{{/* Playing with Merges for PingOne --> Postman URLs  - Testing splitting out components in to separate collections*/}}
{{- define "facile.addPingOneConfigURLs" -}}
        {{- $pingOne := merge .Values.capabilities .Values.collections.capabilities -}}
        {{ print .Values.collections.capabilities.pingOne.url }}
        {{- range $index, $val := $pingOne -}}
            {{- if $val.enabled -}}
                {{ print "," $val.url }}
            {{- end -}}
        {{- end -}}
{{- end -}}

{{- define "facile.addPingOneConfigNames" -}}
        {{- $pingOne := merge .Values.capabilities .Values.collections.capabilities -}}
        {{ print .Values.collections.capabilities.pingOne.name }}
        {{- range $index, $val := $pingOne -}}
            {{- if $val.enabled -}}
                {{ print ", " $val.name }}
            {{- end -}}
        {{- end -}}
{{- end -}}

{{- define "facile.addCapabilityURLs" -}}
        {{- $pingOne := merge .Values.capabilities .Values.collections.capabilities -}}
        {{ print .Values.collections.capabilities.pingOne.url }},
        {{- if .Values.baseline.directory.enabled -}}
            {{- printf .Values.collections.baseline.directory.url }}
        {{- end -}}
        {{- range $index, $val := $pingOne -}}
            {{- if $val.enabled -}}
                {{ print "," $val.url }}
            {{- end -}}
        {{- end -}}
{{- end -}}

{{- define "facile.addCapabilityNames" -}}
        {{- $capabilities := merge .Values.capabilities .Values.collections.capabilities -}}
        {{ print .Values.collections.capabilities.pingOne.name }},  
        {{- if .Values.baseline.directory.enabled -}}
            {{- print " " .Values.collections.baseline.directory.name }}
        {{- end -}}
        {{- range $index, $val := $capabilities -}}
            {{- if $val.enabled -}}
                {{ print ", " $val.name }}
            {{- end -}}
        {{- end -}}
{{- end -}}


{{/* Used to build the additional URLs passed into the job/pingconfig */}}
{{- define "facile.useCaseUrls" -}}
    {{- $useCaseURLs := merge .Values.collections.useCases .Values.useCases }}
    {{- range $key, $val := $useCaseURLs }}
        {{- if $val.enabled }}
            {{- print "," $val.url }}
        {{- end }}
    {{- end }}
{{- end }}

{{/* Used to build the of the collections URLs passed into the job/pingconfig */}}
{{- define "facile.useCaseNames" -}}
    {{- $useCaseNames := merge .Values.collections.useCases .Values.useCases }}
    {{- range $key, $val := $useCaseNames }}
        {{- if $val.enabled }}
            {{- print $val.name ", " }}
        {{- end }}
    {{- end }}
{{- end }}