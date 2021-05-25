{{/* Used to put the right TLD on the P1 URLs based on the Region */}}
{{- define "sampleCiam.pingOneTld" -}}
    {{ if .Values.pingOne.usePingOneServices }}
        {{- if eq ( default "NA" .Values.pingOne.envRegion ) "EU" }}
            {{- print "eu" }}
        {{- else if eq ( default "NA" .Values.pingOne.envRegion ) "AP" }}
            {{- print "asia" }}
        {{- else }}
            {{- print "com" }}
        {{- end}}
    {{- end }}
{{- end }}

{{/* Used to put the right TLD on the P1 URLs based on the Region */}}
{{- define "sampleCiam.pingOneRegion" -}}
    {{ if .Values.pingOne.usePingOneServices }}
        {{- if eq ( default "NA" .Values.pingOne.envRegion ) "EU" }}
            {{- print "eu" }}
        {{- else if eq ( default "NA" .Values.pingOne.envRegion ) "AP" }}
            {{- print "asia" }}
        {{- else }}
            {{- print "na" }}
        {{- end}}
    {{- end }}
{{- end }}

{{/* Used to create the Admin Console Client URLs used in Software */}}
{{- define "sampleCiam.pingOneAdminUrl" }}
    {{- print "https://auth.pingone." }}{{ include "sampleCiam.pingOneTld" . }}{{ print "/" .Values.pingOne.administration.envId "/as" }}
{{- end }}

{{/* Helper for the Ingress Hostname */}}
{{- define "sampleCiam.hostname" -}}
        {{- .Release.Name }}{{- print "." }}{{ default "ping-devops.com" .Values.global.envs.DOMAIN_NAME }}
{{- end }}

{{- define "sampleCiam.pfAdminServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingfederate-admin" ) .Values.global)) }}
{{- end }}

{{- define "sampleCiam.pfEngineServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingfederate-engine" ) .Values.global)) }}
{{- end }}

{{- define "sampleCiam.pdAdminServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingdirectory" ) .Values.global)) }}
{{- end }}

{{- define "sampleCiam.pdsAdminServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingdatasync" ) .Values.global)) }}
{{- end }}

{{- define "sampleCiam.delegatorServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingdelegator" ) .Values.global)) }}
{{- end }}

{{- define "sampleCiam.paAdminServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingaccess-admin" ) .Values.global)) }}
{{- end }}

{{- define "sampleCiam.paEngineServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingaccess-engine" ) .Values.global)) }}
{{- end }}

{{- define "sampleCiam.pazAdminServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingdatagovernance" ) .Values.global)) }}
{{- end }}

{{- define "sampleCiam.papServiceName" -}}
    {{ include "pinglib.fullname" (list . (merge ( index .Values "ping-devops" "pingdatagovernancepap" ) .Values.global)) }}
{{- end }}

{{- define "sampleCiam.pfAdminHostname" -}}
    {{ if eq .Values.global.ingress.addReleaseNameToHost "append" }}
        {{- print "pingfederate-admin-" .Release.Name "." .Values.global.ingress.defaultDomain }}
    {{- else if eq .Values.global.ingress.addReleaseNameToHost "prepend" -}}
        {{- print .Release.Name "-" "pingfederate-admin." .Values.global.ingress.defaultDomain }}
    {{- else -}}
        {{- print "pingfederate-admin." .Values.global.ingress.defaultDomain }}
    {{- end -}}
{{- end -}}

{{- define "sampleCiam.pdAdminHostname" -}}
    {{ if eq .Values.global.ingress.addReleaseNameToHost "append" }}
        {{- print "pingdataconsole-" .Release.Name "." .Values.global.ingress.defaultDomain }}
    {{- else if eq .Values.global.ingress.addReleaseNameToHost "prepend" -}}
        {{- print .Release.Name "-" "pingdataconsole." .Values.global.ingress.defaultDomain }}
    {{- else -}}
        {{- print "pingdataconsole." .Values.global.ingress.defaultDomain }}
    {{- end -}}
{{- end -}}

{{- define "sampleCiam.paAdminHostname" -}}
    {{ if eq .Values.global.ingress.addReleaseNameToHost "append" }}
        {{- print "pingaccess-admin-" .Release.Name "." .Values.global.ingress.defaultDomain }}
    {{- else if eq .Values.global.ingress.addReleaseNameToHost "prepend" -}}
        {{- print .Release.Name "-" "pingaccess-admin." .Values.global.ingress.defaultDomain }}
    {{- else -}}
        {{- print "pingaccess-admin." .Values.global.ingress.defaultDomain }}
    {{- end -}}
{{- end -}}

{{- define "sampleCiam.pazAdminHostname" -}}
    {{ if eq .Values.global.ingress.addReleaseNameToHost "append" }}
        {{- print "pingdatagovernancepap-" .Release.Name "." .Values.global.ingress.defaultDomain }}
    {{- else if eq .Values.global.ingress.addReleaseNameToHost "prepend" -}}
        {{- print .Release.Name "-" "pingdatagovernancepap." .Values.global.ingress.defaultDomain }}
    {{- else -}}
        {{- print "pingdatagovernancepap." .Values.global.ingress.defaultDomain }}
    {{- end -}}
{{- end -}}

{{/* Playing with Lookups */}}
{{- define "sampleCiam.pfAdminHostnameLookup" -}}
    {{ range $index, $val := ((lookup "extensions/v1beta1" "Ingress" .Release.Namespace ( include "sampleCiam.pfAdminServiceName" . )).spec.rules) }}
            {{- print $val.host }}
    {{- end -}}
{{- end -}} {{/* */}}

{{/* Playing with Merges for PingOne --> Postman URLs */}}
{{- define "sampleCiam.addPingOneConfigs" -}}
        {{- $merged := merge .Values.pingOne.services.licensed .Values.collections.useCases.pingOneServices -}}
        {{- range $index, $val := $merged -}}
            {{- if $val.enabled -}}
                {{ print "," $val.url }}
            {{- end -}}
        {{- end -}}
        {{ print "," .Values.collections.useCases.pingOneServices.pf.url }}
{{- end -}}

{{/* Playing with Merges for PingOne --> Postman URLs  - Testing splitting out components in to separate collections*/}}
{{- define "sampleCiam.addPingOneConfigURLs" -}}
        {{- $pingOne := merge .Values.capabilities .Values.collections.capabilities -}}
        {{ print .Values.collections.capabilities.pingOne.url }}
        {{- range $index, $val := $pingOne -}}
            {{- if $val.enabled -}}
                {{ print "," $val.url }}
            {{- end -}}
        {{- end -}}
{{- end -}}

{{- define "sampleCiam.addPingOneConfigNames" -}}
        {{- $pingOne := merge .Values.capabilities .Values.collections.capabilities -}}
        {{ print .Values.collections.capabilities.pingOne.name }}
        {{- range $index, $val := $pingOne -}}
            {{- if $val.enabled -}}
                {{ print ", " $val.name }}
            {{- end -}}
        {{- end -}}
{{- end -}}

{{- define "sampleCiam.addCapabilityURLs" -}}
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

{{- define "sampleCiam.addCapabilityNames" -}}
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
{{- define "sampleCiam.useCaseUrls" -}}
    {{- $useCaseURLs := merge .Values.collections.useCases .Values.useCases }}
    {{- range $key, $val := $useCaseURLs }}
        {{- if $val.enabled }}
            {{- print "," $val.url }}
        {{- end }}
    {{- end }}
{{- end }}

{{/* Used to build the of the collections URLs passed into the job/pingconfig */}}
{{- define "sampleCiam.useCaseNames" -}}
    {{- $useCaseNames := merge .Values.collections.useCases .Values.useCases }}
    {{- range $key, $val := $useCaseNames }}
        {{- if $val.enabled }}
            {{- print $val.name ", " }}
        {{- end }}
    {{- end }}
{{- end }}