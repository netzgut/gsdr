# GSDR, the Geb-Spock-Docker-runner

A docker container for easily running Geb-based Spock-specs in a headless Chrome environment.

## Build (optional)

```
docker build -t netzgut/gsdr:latest
```

## Configure

You need to map 3 locations into the container:

| Container-Location          | Description                        |
| --------------------------- | ---------------------------------- |
| `/runner/src/test/groovy`   | Contains the tests                 |
| `/runner/build/reports`     | Output folder for the test reports |
| `/runner/build/testResults` | Output folder for the test results |

### Base Url and dependencies

To configure the base url and additional dependencies needed by the specs you should map a `runner-settings.gradle` file
to `/runner/runner-settings.gradle`. See [runner/runner-settings.gradle](runner/runner-settings.gradle) for an example.


## Use

```
docker run \
    -v <path to specs>:/runner/src/test/groovy \
    -v <path to specs>:/runner/src/test/groovy \
    -v <path for output>/reports:/runner/build/reports \
    -v <path for output>/testResults:/runner/build/testResults \
    netzgut/gsdr:latest
```

## License

MIT. See [LICENSE](LICENSE).