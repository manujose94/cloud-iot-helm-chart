# database/_helpers.tpl
{{/*
Expand the name of the chart.
*/}}
{{- define "cloud-iot-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

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

{{/*
  Create database-specific labels, including global project labels
*/}}
{{- define "database-chart.labels" -}}
app: {{ .Values.databases.postgres.name | default "database" }}
release: {{ .Release.Name }}
{{- if .Values.global.labels.project }}
{{- include "root-chart.project-labels" . | nindent 2 }}
{{- end }}
{{- end }}

{{/*
  Create Redis-specific labels, including global project labels
*/}}
{{- define "redis-chart.labels" -}}
app: {{ .Values.databases.redis.name | default "redis" }}
release: {{ .Release.Name }}
{{- if .Values.global.labels.project }}
{{- include "root-chart.project-labels" . | nindent 2 }}
{{- end }}
{{- end }}