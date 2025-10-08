from pulumi.provider.experimental import component_provider_host
from my_bucket import MyBucketComponent
from static_page import StaticPage

if __name__ == "__main__":
    component_provider_host(name="python-components", components=[MyBucketComponent, StaticPage])