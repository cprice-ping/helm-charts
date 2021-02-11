{{/* Helpers for the Product Port Numbers */}}

{{/* PingDirectory ConfigAPI */}}
{{- define "pingports.pdConfigPort" -}}
    {{- print (index .Values "ping-devops").pingdirectory.services.https.servicePort }}
{{- end }}

{{/* PingDirectory non-ConfigAPI */}}
{{- define "pingports.pdApiPort" -}}
    {{- print (index .Values "ping-devops").pingdirectory.services.apis.servicePort }}
{{- end }}

{{/* PingDirectory LDAP */}}
{{- define "pingports.pdLdapPort" -}}
    {{- print (index .Values "ping-devops").pingdirectory.services.ldap.servicePort }}
{{- end }}

{{/* PingDirectory LDAPS */}}
{{- define "pingports.pdLdapsPort" -}}
    {{- print (index .Values "ping-devops").pingdirectory.services.ldaps.servicePort }}
{{- end }}

{{/* PingDataConsole HTTPS */}}
{{- define "pingports.pdConsolePort" -}}
    {{- print (index .Values "ping-devops").pingdataconsole.services.https.servicePort }} 
{{- end }}

{{/* PingDataConsole HTTPS */}}
{{- define "pingports.pdsAdminPort" -}}
    {{- print (index .Values "ping-devops").pingdatasync.services.https.servicePort }} 
{{- end }}

{{/* PingFederate Admin */}}
{{- define "pingports.pfAdminPort" -}}
    {{- print (index .Values "ping-devops" "pingfederate-admin" ).services.https.servicePort }} 
{{- end }}

{{/* PingFederate Runtime */}}
{{- define "pingports.pfEnginePort" -}}
    {{- print (index .Values "ping-devops" "pingfederate-engine" ).services.https.servicePort }}
{{- end }}

{{/* PingDelegator */}}
{{- define "pingports.pingDelegatorPort" -}}
    {{- print (index .Values "ping-devops" ).pingdelegator.services.https.servicePort }}
{{- end }}

{{/* PingAccess Admin */}}
{{- define "pingports.paAdminPort" -}}
    {{- print (index .Values "ping-devops" "pingaccess-admin" ).services.https.servicePort }}
{{- end }}
{{/* PingAccess Engine */}}
{{- define "pingports.paEnginePort" -}}
    {{- print (index .Values "ping-devops" "pingaccess-engine" ).services.https.servicePort }}
{{- end }}

{{/* PingCentral Admin */}}
{{- define "pingports.pcAdminPort" -}}
    {{- print 9022 }} 
{{- end }}
