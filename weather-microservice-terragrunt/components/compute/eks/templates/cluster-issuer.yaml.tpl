---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
  namespace: cert-manager
spec:
  acme:
    email: geoffreyscarvell@gmail.com
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: segmint-issuer-account-key
    solvers:
    - selector:
        dnsZones:
          - "segmint.com"
      dns01:
        route53:
          region: ${region}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
  namespace: cert-manager
spec:
  acme:
    email: geoffreyscarvell@gmail.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: segmint-issuer-account-key-prod
    solvers:
    - selector:
        dnsZones:
          - "segmint.com"
      dns01:
        route53:
          region: ${region}
---
