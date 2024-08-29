# test-oci-terraform

## Requirement

- docker(<https://www.docker.com/ja-jp/>)
- task(<https://taskfile.dev/installation/>)

## How to Develop

1. `terraform.tfvars`ファイルを`./terraform/terraform.tfvars`に配置する

    - Lfab Notionのwikiに２配置済み

1. `./.oci/`に、ociの秘密鍵を配置する

   - <https://docs.oracle.com/ja-jp/iaas/developer-tutorials/tutorials/tf-compute/01-summary.htm#create-ssh-keys>

1. 環境立ち上げ

    ```sh
    task install
    ```
