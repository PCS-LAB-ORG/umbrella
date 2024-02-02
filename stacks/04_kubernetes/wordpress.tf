resource "kubernetes_manifest" "service_wordpress" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "wordpress"
      }
      "name" = "wordpress"
      "namespace" = "default"
    }
    "spec" = {
      "ports" = [
        {
          "port" = 80
        },
      ]
      "selector" = {
        "app" = "wordpress"
        "tier" = "frontend"
      }
      "type" = "LoadBalancer"
    }
  }
}

resource "kubernetes_manifest" "persistentvolumeclaim_wp_pv_claim" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "PersistentVolumeClaim"
    "metadata" = {
      "labels" = {
        "app" = "wordpress"
      }
      "name" = "wp-pv-claim"
      "namespace" = "default"
    }
    "spec" = {
      "accessModes" = [
        "ReadWriteOnce",
      ]
      "resources" = {
        "requests" = {
          "storage" = "20Gi"
        }
      }
    }
  }  
  depends_on = [
    helm_release.aws-ebs-csi-driver
  ]
}

resource "kubernetes_manifest" "deployment_wordpress" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "wordpress"
      }
      "name" = "wordpress"
      "namespace" = "default"
    }
    "spec" = {
      "selector" = {
        "matchLabels" = {
          "app" = "wordpress"
          "tier" = "frontend"
        }
      }
      "strategy" = {
        "type" = "Recreate"
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "wordpress"
            "tier" = "frontend"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "WORDPRESS_DB_HOST"
                  "value" = "wordpress-mysql"
                },
                {
                  "name" = "WORDPRESS_DB_PASSWORD"
                  "valueFrom" = {
                    "secretKeyRef" = {
                      "key" = "password"
                      "name" = "mysql-pass"
                    }
                  }
                },
              ]
              "image" = "wordpress:4.8-apache"
              "name" = "wordpress"
              "ports" = [
                {
                  "containerPort" = 80
                  "name" = "wordpress"
                },
              ]
              "volumeMounts" = [
                {
                  "mountPath" = "/var/www/html"
                  "name" = "wordpress-persistent-storage"
                },
              ]
            },
          ]
          "volumes" = [
            {
              "name" = "wordpress-persistent-storage"
              "persistentVolumeClaim" = {
                "claimName" = "wp-pv-claim"
              }
            },
          ]
        }
      }
    }
  }
}
