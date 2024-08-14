{{/*
  Create application-specific labels, including global project labels
*/}}
{{- define "applications-chart.labels" -}}
release: {{ .Release.Name }}
{{- if .Values.global.labels.project }}
{{- include "root-chart.project-labels" . | nindent 2 }}
{{- end }}
{{- end }}