{{/*
  Create monitoring-specific labels, including global project labels
*/}}
{{- define "monitoring-chart.labels" -}}
app: {{ .Values.labels.name | default "monitoring" }}
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