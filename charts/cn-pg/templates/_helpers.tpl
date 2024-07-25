{{/* vim: set filetype=mustache: */}}
{{/*
############
S3
############
*/}}

{{/*
s3 secret name
*/}}

{{- define "cn-pg.s3.secretname" }}
{{- if .Values.s3.useExternalSecret }}
{{- $secretName := .Values.s3.externalSecretName }}
{{- else }}
{{- $secretSuffix := required "missing .Values.s3.secretNameSuffix" .Values.s3.secretNameSuffix }}
{{- $fullName := include "common.fullname" . }}
{{- printf "%s-%s" $fullName $secretSuffix }}
{{- end }}
{{- end }}

{{/*
############
postgres
certificates
############
*/}}

{{/*
Secret's templates
*/}}
{{- define "cn-pg.certs.server.secretTemplateLabels" }}
{{- if and ( hasKey .Values.certs "server" ) ( hasKey .Values.certs.server "secretTemplateLabels" ) -}}
{{- range $key, $val := .Values.certs.server.secretTemplateLabels }}
{{ $key }}: {{ $val | quote }}
{{- end -}}
{{- end }}
{{- end }}
{{- define "cn-pg.certs.client.secretTemplateLabels" }}
{{- if and ( hasKey .Values.certs "client" ) ( hasKey .Values.certs.client "secretTemplateLabels" ) -}}
{{- range $key, $val := .Values.certs.client.secretTemplateLabels }}
{{ $key }}: {{ $val | quote }}
{{- end -}}
{{- end }}
{{- end }}

{{/*
server DNS names
*/}}
{{- define "cn-pg.certs.server.dnsNames" }}
{{- $relname := .Release.Name -}}
{{- $relns := .Release.Namespace -}}
{{- range tuple "r" "ro" "rw" }}
- {{ $relname -}}-{{- . }}
- {{ $relname -}}-{{- . -}}.{{- $relns }}
- {{ $relname -}}-{{- . -}}.{{- $relns -}}-{{- "svc.cluster.local" }}
{{- end }}
{{- end }}

{{/*
########
cluster
########
*/}}

{{/*
postgresql.conf & pg_hba.conf
*/}}
{{- define "cn-pg.cluster.postgresql.params" -}}
{{- if and ( hasKey .Values.cluster "postgresql" ) ( or ( hasKey .Values.cluster.postgresql "parameters" ) ( hasKey .Values.cluster.postgresql "pg_hba")) }}
{{ print "postgresql:" }}
{{- if ( hasKey .Values.cluster.postgresql "parameters" ) }}
{{ print "parameters:" | indent 2 -}}
{{ range $key, $val := .Values.cluster.postgresql.parameters }}
{{ printf "%s: \"%s\"" $key $val | indent 4 }}
{{- end -}}
{{- end -}}
{{- if ( hasKey .Values.cluster.postgresql "pg_hba" ) }}
{{ print "pg_hba:" | indent 2 -}}
{{ range $val := .Values.cluster.postgresql.pg_hba }}
{{ printf "- %s" $val | indent 4 }}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
barman S3 backup
*/}}
{{- define "cn-pg.barmanobjectstore.s3" -}}
{{- $credNames := tuple "region" "accessKeyId" "secretAccessKey" -}} 
{{- $s3SecretName := include "cn-pg.s3.secretname" . -}} 
{{- range $cred := $credNames }}
{{ printf "%s:" $cred | indent 8 }}
{{ printf "name: %s" $s3SecretName | indent 10 }}
{{ printf "key: %s" $cred | indent 10 }}
{{- end }}
{{- end }}

