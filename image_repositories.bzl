# GENERATED FILE. DO NOT MODIFY!

load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_pull",
)

def image_repositories():
    container_pull(
        name = "cfcontainerization_app_autoscaler",
        registry = "index.docker.io",
        repository = "cfcontainerization/app-autoscaler",
        digest = "sha256:8ec62c633c92b7614a8d7c05109e00a3624d84b53b8147aaf8a86d2e709a2aed",
    )

    container_pull(
        name = "cfcontainerization_binary_buildpack",
        registry = "index.docker.io",
        repository = "cfcontainerization/binary-buildpack",
        digest = "sha256:6f169e26097eada50a677751b83baa8ce7519cf03261bbb1b8162bd270863ebd",
    )

    container_pull(
        name = "cfcontainerization_bits_service",
        registry = "index.docker.io",
        repository = "cfcontainerization/bits-service",
        digest = "sha256:af3910b2ff82c6837b6c282068049789882cb520a45bf548429c01e5f3844583",
    )

    container_pull(
        name = "cfcontainerization_brain_tests",
        registry = "index.docker.io",
        repository = "cfcontainerization/brain-tests",
        digest = "sha256:f5ab07ed4a9bed809006c8ea8590422bc640a4eea1d55faef6bd197c1562c0b4",
    )

    container_pull(
        name = "cfcontainerization_capi",
        registry = "index.docker.io",
        repository = "cfcontainerization/capi",
        digest = "sha256:8d2f66b7bec262bdb7901ff1cea2bb74cc3eccada4ab9edffc04e0e537ca1d0a",
    )

    container_pull(
        name = "cfcontainerization_cf_acceptance_tests",
        registry = "index.docker.io",
        repository = "cfcontainerization/cf-acceptance-tests",
        digest = "sha256:58a4c01a9a12700cae7a117c1cd3a0af6e0f323e5d506df97bcb43a611db5351",
    )

    container_pull(
        name = "cfcontainerization_cf_cli",
        registry = "index.docker.io",
        repository = "cfcontainerization/cf-cli",
        digest = "sha256:faf2a51338427bf53f6c596f521e04183dd016f406a03255f2d13a36961895db",
    )

    container_pull(
        name = "cfcontainerization_cf_networking",
        registry = "index.docker.io",
        repository = "cfcontainerization/cf-networking",
        digest = "sha256:81ef92c584d90ed6167f462a5efa9b7da8334fb48a99b40b2f1743ddf2918b62",
    )

    container_pull(
        name = "cfcontainerization_cf_smoke_tests",
        registry = "index.docker.io",
        repository = "cfcontainerization/cf-smoke-tests",
        digest = "sha256:4acf2952d9f5ef1e06e730928a52c8bf9d3deddb7cd983dbc2089d729ecfae7f",
    )

    container_pull(
        name = "cfcontainerization_cf_syslog_drain",
        registry = "index.docker.io",
        repository = "cfcontainerization/cf-syslog-drain",
        digest = "sha256:e8c2f47570ba8132aa48232505b5487a8f47a0b737b5330f117a0574b51010bc",
    )

    container_pull(
        name = "cfcontainerization_cflinuxfs3",
        registry = "index.docker.io",
        repository = "cfcontainerization/cflinuxfs3",
        digest = "sha256:e8fab25ae7efa495f01f3b6f3bdaba1b8b8c843d1bb9fdb0131bed3732a9a657",
    )

    container_pull(
        name = "cfcontainerization_credhub",
        registry = "index.docker.io",
        repository = "cfcontainerization/credhub",
        digest = "sha256:85c53d9fccb52f9d353cd92c60312ee1a5fe103a56963d4e446a5b3582efac7c",
    )

    container_pull(
        name = "cfcontainerization_diego",
        registry = "index.docker.io",
        repository = "cfcontainerization/diego",
        digest = "sha256:1a9acc3239a9e2ba9bd978baa8609caf5b7e6a79f48294c769d7e62b93798f66",
    )

    container_pull(
        name = "cfcontainerization_dotnet_core_buildpack",
        registry = "index.docker.io",
        repository = "cfcontainerization/dotnet-core-buildpack",
        digest = "sha256:525780a201f9d03a7d5e54dbc79d8353c3567a428d780ad9bc89271d78a96eec",
    )

    container_pull(
        name = "cfcontainerization_eirini",
        registry = "index.docker.io",
        repository = "cfcontainerization/eirini",
        digest = "sha256:3eadc9101d03abe754c77977675fc0bd65ecbaf881bb7e1185189eee4dd6c621",
    )

    container_pull(
        name = "cfcontainerization_garden_runc",
        registry = "index.docker.io",
        repository = "cfcontainerization/garden-runc",
        digest = "sha256:fd74333df04a4732c39b226c1354bc1e004a10ade70a7ddd9aa1985b9ee193ce",
    )

    container_pull(
        name = "cfcontainerization_go_buildpack",
        registry = "index.docker.io",
        repository = "cfcontainerization/go-buildpack",
        digest = "sha256:dd4c21aa94aada661249ec47be45193e98c639109e2ef6a1cac82a8d33b74946",
    )

    container_pull(
        name = "cfcontainerization_java_buildpack",
        registry = "index.docker.io",
        repository = "cfcontainerization/java-buildpack",
        digest = "sha256:829b1a3732b3094902a454be3b381f3d7e946444d01a661b294c21582e9cebe2",
    )

    container_pull(
        name = "cfcontainerization_log_cache",
        registry = "index.docker.io",
        repository = "cfcontainerization/log-cache",
        digest = "sha256:6cd54f8e05113a9b29ee5d076c7afac411423fedd839f18f81b5d44ca8b94492",
    )

    container_pull(
        name = "cfcontainerization_loggregator_agent",
        registry = "index.docker.io",
        repository = "cfcontainerization/loggregator-agent",
        digest = "sha256:20a4f342dc818bebaedebba7a98f24ec992b5e23b66e0561bdb6963e2116336a",
    )

    container_pull(
        name = "cfcontainerization_loggregator",
        registry = "index.docker.io",
        repository = "cfcontainerization/loggregator",
        digest = "sha256:871236cc474b9e07e7638f04e76aad6edfbb4a4bd9c5bc1747aca069983b3df2",
    )

    container_pull(
        name = "cfcontainerization_nats",
        registry = "index.docker.io",
        repository = "cfcontainerization/nats",
        digest = "sha256:351f371cf5a71198c664c91137aa8d2876309760335d542717346ae906524eae",
    )

    container_pull(
        name = "cfcontainerization_nginx_buildpack",
        registry = "index.docker.io",
        repository = "cfcontainerization/nginx-buildpack",
        digest = "sha256:ddfacab6300c85cf1963563473c5c050ae25e44a96d71c776df48942aa1dd0a3",
    )

    container_pull(
        name = "cfcontainerization_nodejs_buildpack",
        registry = "index.docker.io",
        repository = "cfcontainerization/nodejs-buildpack",
        digest = "sha256:47e52c7080d24556ab1911b81729be4b20df742b6ea61f8a0b835bbb83fdbd51",
    )

    container_pull(
        name = "cfcontainerization_php_buildpack",
        registry = "index.docker.io",
        repository = "cfcontainerization/php-buildpack",
        digest = "sha256:8b73799ca6f522a26ebecd97d3b384d0a9e5a1daa4597b21c643f8843dbe6486",
    )

    container_pull(
        name = "cfcontainerization_postgres",
        registry = "index.docker.io",
        repository = "cfcontainerization/postgres",
        digest = "sha256:b3bc6dda99213947bd07b9bb20d7636bbc49c417861e8a6d93435d521f3d2750",
    )

    container_pull(
        name = "cfcontainerization_pxc",
        registry = "index.docker.io",
        repository = "cfcontainerization/pxc",
        digest = "sha256:a85da06a4c8e748d6a0a28d4d35064766a20b76aeed52e0af95016eb3680d593",
    )

    container_pull(
        name = "cfcontainerization_python_buildpack",
        registry = "index.docker.io",
        repository = "cfcontainerization/python-buildpack",
        digest = "sha256:3d39379b8ceac8226be657082db6a51fb5c31e2b6a0f1a185bb472f5aba8418c",
    )

    container_pull(
        name = "cfcontainerization_r_buildpack",
        registry = "index.docker.io",
        repository = "cfcontainerization/r-buildpack",
        digest = "sha256:bfd2cd06b91a4d6ce2e77f71b9e218b5cf66b8e6e9c8b80e11253176d95a628c",
    )

    container_pull(
        name = "cfcontainerization_routing",
        registry = "index.docker.io",
        repository = "cfcontainerization/routing",
        digest = "sha256:4990e721bb1d4e40735860abff88419da31f95d8db1650bd2004d9bf307398a0",
    )

    container_pull(
        name = "cfcontainerization_ruby_buildpack",
        registry = "index.docker.io",
        repository = "cfcontainerization/ruby-buildpack",
        digest = "sha256:8a7eef9c7e19ec7c757fa18adf4002157e5f59bef35338904f754824a0479e09",
    )

    container_pull(
        name = "cfcontainerization_silk",
        registry = "index.docker.io",
        repository = "cfcontainerization/silk",
        digest = "sha256:80bc04d64ac94637837e94a8a0eda17d6978c82e6496b12d3820fdfaa23bc7ef",
    )

    container_pull(
        name = "cfcontainerization_sle15",
        registry = "index.docker.io",
        repository = "cfcontainerization/sle15",
        digest = "sha256:de36fe7bed6a4c342ea3ae11ccd8e5582494c23b924d63776636c7b99de6548c",
    )

    container_pull(
        name = "cfcontainerization_staticfile_buildpack",
        registry = "index.docker.io",
        repository = "cfcontainerization/staticfile-buildpack",
        digest = "sha256:df6e3cc07fab60369ac6efb79992868282a0823161476e139709c447f46fdf70",
    )

    container_pull(
        name = "cfcontainerization_statsd_injector",
        registry = "index.docker.io",
        repository = "cfcontainerization/statsd-injector",
        digest = "sha256:17ad3bb2e2e18d5058c5221b516d31c28c8c5fb2568345fe869e91ab64dd0d16",
    )

    container_pull(
        name = "cfcontainerization_sync_integration_tests",
        registry = "index.docker.io",
        repository = "cfcontainerization/sync-integration-tests",
        digest = "sha256:229b872c09ceb495ad6e48c2aba32ab56a9c4726ca1b4a75c9e12392396186a4",
    )

    container_pull(
        name = "cfcontainerization_uaa",
        registry = "index.docker.io",
        repository = "cfcontainerization/uaa",
        digest = "sha256:b1ad21c5435c3a95170409afe7b4b3dcfd226e9ae940ee36d4906479e9bdc3e6",
    )

    container_pull(
        name = "cap_staging_suse_binary_buildpack",
        registry = "registry.suse.com",
        repository = "cap-staging/suse-binary-buildpack",
        digest = "sha256:51e295376da8dbf7a1439317f9983a772748bde522bd9b08005dc9bccbb090b3",
    )

    container_pull(
        name = "cap_staging_suse_dotnet_core_buildpack",
        registry = "registry.suse.com",
        repository = "cap-staging/suse-dotnet-core-buildpack",
        digest = "sha256:d7dda42751b491b94fc1db7a90d883ffcd0d907a19e90f0e09a98ad52e805ccc",
    )

    container_pull(
        name = "cap_staging_suse_go_buildpack",
        registry = "registry.suse.com",
        repository = "cap-staging/suse-go-buildpack",
        digest = "sha256:65fa90a2ef4c1f9c8006c547255e3ddb62c2470a1acbc36f56b58eb6fdf04348",
    )

    container_pull(
        name = "cap_staging_suse_java_buildpack",
        registry = "registry.suse.com",
        repository = "cap-staging/suse-java-buildpack",
        digest = "sha256:1d4f6460490b45b91848b9ad526dbe2a7c885c69afb46967fc2995504c97e512",
    )

    container_pull(
        name = "cap_staging_suse_nginx_buildpack",
        registry = "registry.suse.com",
        repository = "cap-staging/suse-nginx-buildpack",
        digest = "sha256:39ca1a9609ea55bc1f4e5a29835264b8f09fe3c85e7439999b9e9ac7f93a1260",
    )

    container_pull(
        name = "cap_staging_suse_nodejs_buildpack",
        registry = "registry.suse.com",
        repository = "cap-staging/suse-nodejs-buildpack",
        digest = "sha256:2df435f338d993e3f44a678d2a3ebc52e00f92a149d11c56e050a94d0533b540",
    )

    container_pull(
        name = "cap_staging_suse_php_buildpack",
        registry = "registry.suse.com",
        repository = "cap-staging/suse-php-buildpack",
        digest = "sha256:859a92a655f25f3def57bba9d022f5a0b268bfa8faca1ea0316796803973fc46",
    )

    container_pull(
        name = "cap_staging_suse_python_buildpack",
        registry = "registry.suse.com",
        repository = "cap-staging/suse-python-buildpack",
        digest = "sha256:63cdb72e73ae4af796240d7395c249e95b0164ba0a944f37bfd85fafe4dc14c1",
    )

    container_pull(
        name = "cap_staging_suse_ruby_buildpack",
        registry = "registry.suse.com",
        repository = "cap-staging/suse-ruby-buildpack",
        digest = "sha256:76846bc22161ccaa90177b4518fdd5e88b29dff062cfd50427ce2b0696f95e77",
    )

    container_pull(
        name = "cap_staging_suse_staticfile_buildpack",
        registry = "registry.suse.com",
        repository = "cap-staging/suse-staticfile-buildpack",
        digest = "sha256:e04182348ced195a324463bc6dee2a77f1ab823ecccc1105445fbd897956d63b",
    )

