# elastic-dump


## Dependencies
- Docker

## Docker

#### Build
Now you are ready to build an image from this project Dockerfile.
```bash
docker build -t elastic-dump .
```

#### Run

After your image has been built successfully, you can run it as a container. In your terminal, run the command docker images to view your images.

```bash
docker run -it \
    -e AWS_REGION='<elastic-region>' \
    -e AWS_HOST='<elastic-cluster-host>' \
    -e AWS_ACCESS_KEY_ID='<your-access-key-id>' \
    -e AWS_SECRET_ACCESS_KEY='<your-secret-access-key>' \
    elastic-dump
```

#### Dump

Using docker to use **elasticdump**, you can download this project from docker hub:

```bash
docker pull taskrabbit/elasticsearch-dump
```

Then you can use it just by:

- using `docker run --rm -ti taskrabbit/elasticsearch-dump`
- you'll need to mount your file storage dir `-v <your dumps dir>:<your mount point>` to your docker container

Example:
```bash
# Export ES data to S3 (using s3urls)
elasticdump \
  --s3AccessKeyId "${access_key_id}" \
  --s3SecretAccessKey "${access_key_secret}" \
  --input=http://production.es.com:9200/my_index \
  --output "s3://${bucket_name}/${file_name}.json"

# Import data from S3 into ES (using s3urls)
elasticdump \
  --s3AccessKeyId "${access_key_id}" \
  --s3SecretAccessKey "${access_key_secret}" \
  --input "s3://${bucket_name}/${file_name}.json" \
  --output=http://production.es.com:9200/my_index

# Backup index data to a file:
docker run --rm -ti -v /data:/tmp taskrabbit/elasticsearch-dump \
  --input=http://production.es.com:9200/my_index \
  --output=/tmp/my_index_mapping.json \
  --type=data

# Copy an index from production to staging with mappings:
docker run --rm -ti taskrabbit/elasticsearch-dump \
  --input=http://production.es.com:9200/my_index \
  --output=http://staging.es.com:9200/my_index \
  --type=mapping

docker run --rm -ti taskrabbit/elasticsearch-dump \
  --input=http://production.es.com:9200/my_index \
  --output=http://staging.es.com:9200/my_index \
  --type=data
```

## Author
App managed by DNX Solutions.

## License
Apache 2 Licensed. See LICENSE for full details.