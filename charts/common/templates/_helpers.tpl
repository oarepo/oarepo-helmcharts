{{/* vim: set filetype=mustache: */}}

{{- define "my.var_dump" -}}
{{- . | printf "\ndumped var is: \n%s" | fail }}
{{- end -}}

{{/*
Name of the chart.
*/}}
{{- define "common.name" -}}
{{- if .Values.nameOverride -}}
{{- .Values.nameOverride -}}
{{- else -}}
{{- .Chart.Name -}}
{{- end -}}
{{- end -}}

{{/*
Concats chart name and version
*/}}
{{- define "common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | -}}
{{- end -}}

{{/*
fully qualified app name.
*/}}
{{- define "common.fullname" -}}
{{- if .Values.fullNameOverride -}}
{{- .Values.fullNameOverride -}}
{{- else -}}
{{- $name := include "common.name" . -}}
{{- printf "%s-%s" .Release.Name $name -}}
{{- end -}}
{{- end -}}

{{/*
Kubernetes standard labels
*/}}
{{- define "common.labels" }}
app.kubernetes.io/name: {{ include "common.name" . }}
helm.sh/chart: {{ include "common.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Chart.AppVersion }}
app.kubernetes.io/version: {{ . | quote }}
{{- end -}}
{{- end -}}

{{/*
Kubernetes standard labels
*/}}
{{- define "common.annotations" }}
checksum/values {{ print ( $.BasePath values.yaml ) | sha256sum }}
{{- end }}

{{/*
generates passwords for secrets
*/}}
{{- define "common.password" -}}
{{- $ := .context }}
{{- $keyName := .key }}
{{- $secretName := printf "%s-%s" ( include "common.fullname" .context ) .svc }}
{{- if $.Release.IsInstall -}}
  {{- $val := randAlphaNum ( .pwlength | int ) }}
  {{- print $val }}
{{- else }}
  {{- $obj := (lookup "v1" "Secret" $.Release.Namespace $secretName).data }}
  {{- $password := get $obj ( print  $keyName )  | b64dec -}}
  {{- print $password -}}
{{- end -}}
{{- end -}}

