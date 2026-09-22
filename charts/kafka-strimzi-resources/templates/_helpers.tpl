{{/*

 Copyright 2026 The OKDP Authors.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.

*/}}

{{/*
Expand the name of the chart.
*/}}
{{- define "kafka-strimzi-resources.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
The Strimzi `strimzi.io/cluster` identity that Kafka/KafkaNodePool/KafkaUser/
KafkaTopic resources share. Defaults to the Helm release name itself (this
chart's only purpose is to render this one Kafka cluster's resources, so
there's no need to derive a separate app name from the chart name).
*/}}
{{- define "kafka-strimzi-resources.fullname" -}}
{{- default .Release.Name .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kafka-strimzi-resources.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kafka-strimzi-resources.labels" -}}
helm.sh/chart: {{ include "kafka-strimzi-resources.chart" . }}
{{ include "kafka-strimzi-resources.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kafka-strimzi-resources.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kafka-strimzi-resources.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
