`mysql-s3-backup` is a MySQL backup helper that:

* Takes the dump of the MySQL database
* Uploads it to AWS' object storage service S3
* Reports to [WebGazer](https://www.webgazer.io) (optional)

## Usage

### Environment variables

| Variable               | Required | Default value | Description                                                                                                                   |
|------------------------|:--------:|---------------|-------------------------------------------------------------------------------------------------------------------------------|
| AWS_ACCESS_KEY_ID      |    ✔     |               | Access key id for the AWS account                                                                                             |
| AWS_REGION             |    ✔     |               | Region for the AWS bucket                                                                                                     |
| AWS_S3_ENDPOINT        |    ✔     |               | AWS S3 endpoint with bucket and path (e.g. "my-bucket/mysql-backup")                                                          |
| AWS_S3_STORAGE_CLASS   |          | STANDARD_IA   | AWS S3 storage class (see https://aws.amazon.com/s3/storage-classes/ and https://rclone.org/s3/#s3-storage-class for options. |
| AWS_SECRET_ACCESS_KEY  |    ✔     |               | Secret access key for the AWS account                                                                                         |
| MYSQL_DB               |    ✔     |               | MySQL server database                                                                                                         |
| MYSQL_HOST             |          | mysql         | MySQL server host                                                                                                             |
| MYSQL_PASSWORD         |    ✔     |               | MySQL server password                                                                                                         |
| MYSQL_PORT             |          | 3306          | MySQL server port                                                                                                             |
| MYSQL_USER             |          | root          | MySQL server user                                                                                                             |
| WEBGAZER_HEARTBEAT_URL |          |               | [WebGazer Heartbeat Monitor](https://www.webgazer.io/services/cron-job-monitoring) URL                                        |

### Running

```shell
$ docker run \
  -e AWS_ACCESS_KEY_ID=<aws_access_key_id> \
  -e AWS_REGION=<aws_region> \
  -e AWS_S3_ENDPOINT=<aws_s3_endpoint> \
  -e AWS_S3_STORAGE_CLASS=<aws_s3_storage_class[STANDARD_IA]> \
  -e AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> \
  -e MYSQL_DB=<database> \
  -e MYSQL_HOST=<mysql_hostname[mysql]> \
  -e MYSQL_PASSWORD=<mysql_password> \
  -e MYSQL_PORT=<mysql_port[3306]> \
  -e MYSQL_USER=<mysql_user[root]> \
  -e WEBGAZER_HEARTBEAT_URL=<webgazer_heartbeat_url> \
  th0th/mysql-s3-backup
```

### Example

```shell
$ docker run \
  -e AWS_ACCESS_KEY_ID=g9XqNnqKmUk6xqwkStkN \
  -e AWS_REGION=eu-west-1 \
  -e AWS_S3_ENDPOINT=my-bucket/mysql-backup \
  -e AWS_S3_STORAGE_CLASS=GLACIER \
  -e AWS_SECRET_ACCESS_KEY=GLBZ8mQf27UL57YHbkLhXWtfJWVwtUBbQup6mFzw \
  -e MYSQL_DB=database \
  -e MYSQL_HOST=mysql \
  -e MYSQL_PASSWORD=mysql_password \
  -e MYSQL_PORT=3306 \
  -e MYSQL_USER=mysql_user \
  -e WEBGAZER_HEARTBEAT_URL=https://heartbeat.webgazer.io/1-8f713c75d659 \
  th0th/mysql-s3-backup
```

## Shameless plug

I am an indie hacker, and I am running two services that might be useful for your business. Check them out :)

### WebGazer

[<img alt="WebGazer" src="https://user-images.githubusercontent.com/698079/162474223-f7e819c4-4421-4715-b8a2-819583550036.png" width="256" />](https://www.webgazer.io/?utm_source=github&utm_campaign=mysql-s3-backup-readme)

[WebGazer](https://www.webgazer.io/?utm_source=github&utm_campaign=mysql-s3-backup-readme) is a monitoring service
that checks your website, cron jobs, or scheduled tasks on a regular basis. It notifies
you with instant alerts in case of a problem. That way, you have peace of mind about the status of your service without
manually checking it.

### PoeticMetric

[<img alt="PoeticMetric" src="https://user-images.githubusercontent.com/698079/162474946-7c4565ba-5097-4a42-8821-d087e6f56a5d.png" width="256" />](https://www.poeticmetric.com/?utm_source=github&utm_campaign=mysql-s3-backup-readme)

[PoeticMetric](https://www.poeticmetric.com/?utm_source=github&utm_campaign=mysql-s3-backup-readme) is a
privacy-first, regulation-compliant, blazingly fast analytics tool.

No cookies or personal data collection. So you don't have to worry about cookie banners or GDPR, CCPA, and PECR
compliance.

## License

Copyright © 2022, Gokhan Sari. Released under the [MIT License](LICENSE).
