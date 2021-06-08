{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper Zookeeper image name
*/}}
{{- define "zookeeper.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.config_values.image "global" .Values.config_values.global) }}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "zookeeper.volumePermissions.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.config_values.volumePermissions.image "global" .Values.config_values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "zookeeper.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.config_values.image .Values.config_values.volumePermissions.image) "global" .Values.config_values.global) -}}
{{- end -}}

{{/*
Check if there are rolling tags in the images
*/}}
{{- define "zookeeper.checkRollingTags" -}}
{{- include "common.warnings.rollingTag" .Values.config_values.image }}
{{- end -}}

{{/*
 Create the name of the service account to use
 */}}
{{- define "zookeeper.serviceAccountName" -}}
{{- if .Values.config_values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.config_values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.config_values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return ZooKeeper Client Password
*/}}
{{- define "zookeeper.clientPassword" -}}
{{- if .Values.config_values.auth.clientPassword -}}
    {{- .Values.config_values.auth.clientPassword -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}

{{/*
Return ZooKeeper Servers Passwords
*/}}
{{- define "zookeeper.serverPasswords" -}}
{{- if .Values.config_values.auth.serverPasswords -}}
    {{- .Values.config_values.auth.serverPasswords -}}
{{- else -}}
    {{- randAlphaNum 10 -}}
{{- end -}}
{{- end -}}

{{/*
Return ZooKeeper Namespace to use
*/}}
{{- define "zookeeper.namespace" -}}
    {{- if .Values.config_values.namespaceOverride }}
        {{- .Values.config_values.namespaceOverride -}}
    {{- else }}
        {{- .Release.Namespace -}}
    {{- end }}
{{- end -}}