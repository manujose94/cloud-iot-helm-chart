{{/*
  Create monitoring-specific labels, including global project labels
*/}}
{{- define "monitoring-chart.labels" -}}
app: {{ .Values.labels.name | default "monitoring" }}
release: {{ .Release.Name }}
{{- if .Values.global.labels.project }}
{{- include "root-chart.project-labels" . | nindent 2 }}
{{- end }}
{{- end }}