# database/_helpers.tpl
{{/*
Expand the name of the chart.
*/}}
{{- define "cloud-iot-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define "checkRequiredGlobalLabels" -}}
{{- if not .Values.global }}
    {{- fail "The global configuration 'global' is required and missing" -}}
{{- end -}}
{{- if not .Values.global.labels }}
    {{- fail "The global labels 'labels' under 'global' are required and missing" -}}
{{- end -}}
{{- if and .Values.global.labels.project .Values.global.labels.version }}
    {{- $projectLabel := .Values.global.labels.project -}}
    {{- $versionLabel := .Values.global.labels.version -}}
{{- else }}
    {{- fail "Both 'project' and 'version' labels are required under 'global.labels'" -}}
{{- end -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
*/}}
{{- define "cloud-iot-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- printf "%s-%s" $name .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "database-chart.labels" -}}
app: {{ .Values.databases.postgres.name | default "database" }}
release: {{ .Release.Name }}
{{- if and .Values.global (not (empty .Values.global.labels.project)) }}
{{- if hasKey .Template "root-chart.project-labels" }}
{{- include "root-chart.project-labels" . | nindent 2 }}
{{- else }}
project: {{ .Values.global.labels.project }}
{{- end }}
{{- else }}
project: "default-project"
{{- end }}
{{- end }}

{{- define "redis-chart.labels" -}}
app: {{ .Values.databases.redis.name | default "redis" }}
release: {{ .Release.Name }}
{{- if and .Values.global (not (empty .Values.global.labels.project)) }}
{{- if hasKey .Template "root-chart.project-labels" }}
{{- include "root-chart.project-labels" . | nindent 2 }}
{{- else }}
project: {{ .Values.global.labels.project }}
{{- end }}
{{- else }}
project: "default-project"
{{- end }}
{{- end }}